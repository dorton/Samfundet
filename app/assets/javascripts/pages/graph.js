var scaleFactor = 1;
var translation = [0,0];
var nodes = [];
var links = [];
var node, link, zoomer;

function open_link(d){
  if(d.name.startsWith("http")){
    window.open(d.name);
  }
  else if(d.name.startsWith("/")){
    window.open("http://samfundet.no/"+d.name);
  }
  else{
    window.open("/informasjon/"+d.name);
  }
}

/*** Set the position of the elements based on data ***/
function tick() {
  link.attr("x1", function (d) {
      return translation[0] + scaleFactor*d.source.x;
    })
    .attr("y1", function (d) {
       return translation[1] + scaleFactor*d.source.y;
    })
    .attr("x2", function (d) {
      return translation[0] + scaleFactor*d.target.x;
    })
    .attr("y2", function (d) {
      return translation[1] + scaleFactor*d.target.y;
    });

  node.attr("transform", function(d) {
    return "translate(" + (translation[0] + scaleFactor*d.x) + "," + (translation[1] + scaleFactor*d.y) + ")";
  });
}

function zoom() {
    //console.log("zoom", d3.event.translate, d3.event.scale);
    //scaleFactor = d3.event.scale;
    //translation = d3.event.translate;
    tick(); //update positions
}

function dragstart(d) {
    d3.select(this).classed("fixed", d.fixed = true);
}

function click(d) {
    if (d3.event.defaultPrevented) return; // click suppressed
    d3.select(this).classed("fixed", d.fixed = false);
}

link_grap_to_d3js = function(graph){

  /*** Configure zoom behaviour ***/
  zoomer = d3.behavior.zoom()
        .scaleExtent([0.1,10])
        //allow 10 times zoom in or out
        .on("zoom", zoom);
        //define the event handler function

  // generate nodes and name to index table
  nameLookup = {};
  i=0;
  for(name in graph) {
    nameLookup[name]=i;
    nodes.push({"name":name});
    i+=1;
  }

  // generate links
  for(source_name in graph) {
    source=nameLookup[source_name];
    for(index in graph[source_name]) {
      target_name = graph[source_name][index];
      target=nameLookup[target_name];
      if(target==undefined) {
        // Link is broken.
        // Create psuedo node that is representing
        // a broken link.
        nodes.push({"name":target_name, "broken":true});
        nameLookup[target] = nodes.length-1;
        target = nodes.length-1;
      }
      links.push({"source":source, "target":target});
    }
  }

  return {"nodes":nodes, "links":links};
}

$(document).ready(function(){
  var width = "1300",
      height = "800";

  var color = d3.scale.category20();

  graph = link_grap_to_d3js(graph_data);

  var force = d3.layout.force()
      .charge(-300)
      .linkDistance(60)
      .size([width, height])
      .nodes(graph.nodes)
      .links(graph.links)
      .start();

  var svg = d3.select("#d3js-graph").append("svg")
      .attr("width", width)
      .attr("height", height)
      .append("g")
        .attr("class", "graph")
        .call(zoomer);

  // build the arrow.
  svg.append("svg:defs").selectAll("marker")
      .data(["end"])
    .enter().append("svg:marker")
      .attr("id", String)
      .attr("viewBox", "0 -5 10 10")
      .attr("refX", 15)
      .attr("refY", -1.5)
      .attr("markerWidth", 6)
      .attr("markerHeight", 6)
      .attr("orient", "auto")
    .append("svg:path")
      .attr("d", "M0,-5L10,0L0,5");

  link = svg.selectAll(".link")
      .data(graph.links)
    .enter().append("line")
      .attr("class", "link")
      .attr("marker-end", "url(#end)")
      .style("stroke-width", function(d) { return Math.sqrt(d.value); });

  drag = force.drag()
          .on("dragstart", dragstart);

  node = svg.selectAll(".node")
      .data(graph.nodes)
    .enter().append("g")
      .attr("class", "node")
      .call(drag)
      .on("click", click);

  node.append("circle")
      .attr("r", function(d) { return Math.sqrt(d.weight) + 5; })
      .style("fill", function(d) { if(d.broken){return "#f00";}else{return color(d.group)} })
      .on("dblclick", open_link);

  node.append("title")
      .text(function(d) { return d.name; });

  node.append("text")
        .attr("dx", function(d){return 12+Math.sqrt(d.weight)+5;})
        .attr("dy", ".35em")
        .text(function(d) { return d.name; });

  force.on("tick", tick);
  //force.on("tick", function() {
  //  link.attr("x1", function(d) { return d.source.x; })
  //      .attr("y1", function(d) { return d.source.y; })
  //      .attr("x2", function(d) { return d.target.x; })
  //      .attr("y2", function(d) { return d.target.y; });
  //  node.attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
  //});
});
