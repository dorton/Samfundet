# -*- encoding : utf-8 -*-

module ViewMatchers
  def have_link_to(path, optional_text = nil)
    have_tag("a[href='#{path}']", optional_text)
  end
end
