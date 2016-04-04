$(function() {
  function fragmentToBuyLink(fragment) {
    var routes = {
      'en': '/en/events/',
      'no': '/arrangement/'
    };

    return routes[$('html').attr('lang')] + fragment;
  }

  function findParentEvent(element) {
    $(element).parents().each(function() {
      if($(this).hasClass('upcoming-event')) {
        element = this;
      }
    });

    return element;
  }

  // Chrome fires the onpopstate even on regular page loads,
  // so we need to detect that and ignore it.
  var popped = ('state' in window.history && window.history.state !== null), initialURL = location.href;

  function openPurchaseModal(url, source) {
    ga('send', 'pageview', {
      'page': url,
      'title': 'Purchase event - Virtual'
    });

    $.get(url, function(html) {
    $("html, body").animate({ scrollTop: 0 }, "slow");
      $(html).appendTo('body').modal({
        clickClose: false,
        escapeClose: false,
      }).on($.modal.CLOSE, function(e) {
        $(this).remove();
        ga('send', 'pageview');
        history.pushState(null, null, '#');
        popped = true;
        $('html, body').animate({
          scrollTop: $(findParentEvent(source)).offset().top
        }, 1000);
      });
    });
  }

  function openPurchaseModalBasedOnHash() {
      var fragment = window.location.hash.substr(1);
      if(fragment.match(/buy$/)) {
        openPurchaseModal(fragmentToBuyLink(fragment), $('body').eq(0));
      }
      else {
        if ($.modal.close()) { ga('send', 'pageview'); }
      }
  }
  openPurchaseModalBasedOnHash();

  $(document).on('click', 'a.purchase-button', function(e) {
    history.pushState(null, null, '#' + this.getAttribute('data-event-id') + '/buy');
    popped = true;
    openPurchaseModal(this.pathname, this);
    e.preventDefault();
  });

  $(window).bind('popstate', function (e) {
    var initialPop = !popped && location.href == initialURL;
    popped = true;

    if(initialPop) return;

    openPurchaseModalBasedOnHash();
  });

  $(document).on('keyup blur', '#cardnumber, #email, #email_confirmation',
      function clearOtherInputOnType() {

    // Only clear other form if we've written something
    if ($(this).val() == '') {
      return;
    }

    var id = '#' + $(this).attr('id');
    $(id)
      .siblings('input:radio')
      .prop('checked', true);

    if (id === '#cardnumber') {
      $('#email, #email_confirmation').val('');
    } else {
      $('#cardnumber').val('');
    }
  });

  $(document).on('focus', '.billig-buy input[type=radio]',
      function enforceRadioChoice() {

    // Clear selected and other input fields
    var textfield = $(this).siblings('input[type=text], input[type=email]');

    var id = '#' + textfield.attr('id');
    if (id === '#cardnumber') {
      $('#email, #email_confirmation').val('');
    } else {
      $('#cardnumber').val('');
    }
  });

  $(document).on('change', '.ticket-table select', function(e) {
    var sum = 0;
    var amount = 0;

    $('.ticket-table-row').each(function() {
      $(this).find('.sum').html($(this).find('select').val() * $(this).find('.price').data('price'));
    });

    $('.ticket-table-row .sum').each(function() {
      sum += (+$(this).html());
    });

    $('.ticket-table-row select').each(function() {
      amount += (+$(this).val());
    });

    $('.ticket-table .totalAmount').html(amount);
    $('.ticket-table .totalSum').html(sum);
  });

  $('.ticket-table select').change();

  function validateCardChecksum(value, pattern) {
    var sum = 0;

    if (!value.match(pattern)) {
      return false;
    }


    for (var i = 1; i <= value.length; i++) {
      var cur = Number(value.charAt(value.length - i));

      if (i % 2 == 0) {
        var tmp = (cur * 2).toString();

        if (tmp.length == 2) {
            sum += Number(tmp.charAt(1));
        }

        sum += Number(tmp.charAt(0));
      } else {
        sum += cur;
      }
    }

    return (sum % 10 == 0);
  }

  function getCardInformation(value) {
    if (value.match(/^4/)) {
      return {pattern: /^(\d{13}|\d{16})$/, name: 'VISA', type: 'visa'};
    } else if (value.match(/^5[12345]/)) {
      return {pattern: /^\d{16}$/, name: 'MasterCard', type: 'mastercard'};
    }
  }

  function validateEmail() {
    var feedback = $('#email_feedback');
    var email1 = $('#email').val();
    var email2 = $('#email_confirmation').val();

    var text = {
        "no": ["Epostene er like", "Epostene er ikke like"],
        "en": ["Emails are equal", "Emails are not equal"]
    }

    if ($('#ticket_type_card').prop('checked')) {
        feedback.text('');
        feedback.attr('class', '');
    } else if (email1 === email2 && email1 != '') {
      feedback.text(text[$('html').attr('lang')][0]);
      feedback.attr('class', 'email_equal');
      return true;
    } else {
      feedback.text(text[$('html').attr('lang')][1]);
      feedback.attr('class', 'email_error');
    }
  }

  function cardEditingFeedback() {
    var input = $(this);
    var value = input.val();
    var info = getCardInformation(input.val());
    var feedback = $('#card_feedback');

    if (info) {
      feedback.text(info['name']);
      feedback.attr('class', 'card_' + info.type);
    }
    else {
      feedback.html('&nbsp;');
      feedback.attr('class', '');
    }
  }

  function finalCardFeedback() {
    var input = $(this);
    var value = input.val();
    var info = getCardInformation(input.val());
    var feedback = $('#card_feedback');

    if (value.match(/^\s*$/)) {
      feedback.html('&nbsp;');
      feedback.attr('class', '');
    } else if (info && validateCardChecksum(value, info.pattern)) {
      feedback.text(info.name);
      feedback.attr('class', 'card_valid card_' + info.type);
    } else {
      var error_message = {
        'no': 'Dette ser ikke ut som et gyldig kortnummer.',
        'en': 'This does not appear to be a valid card number.'
      };

      feedback.text(error_message[$('html').attr('lang')]);
      feedback.attr('class', 'card_error');
    }
  }

  function checkValidForm() {
    var input = $('#ccno');
    var info = getCardInformation(input.val());

    var validEmail = validateEmail();

    if (info && info['type'] !== 'error' &&
        (!$('#ticket_type_paper').prop('checked') || 
        validEmail)) {

      $('.billig-buy .custom-form [name="commit"]').prop('disabled', false);
    }
    else {
      $('.billig-buy .custom-form [name="commit"]').prop('disabled', true);
    }
  }

  $(document).on('focus keyup', '#ccno', cardEditingFeedback);
  $(document).on('blur', '#ccno', finalCardFeedback); 
  $(document).on('blur focus keyup change', '.billig-buy .custom-form input', checkValidForm);
});
