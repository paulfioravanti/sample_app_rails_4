module CustomMatchers
  extend RSpec::Matchers::DSL

  matcher :have_alert_message do |type, message|
    match do |page|
      page.has_selector?("div.alert.alert-#{type}", text: message)
    end
  end

  matcher :have_unique_css_ids_in do |expected_feed|
    match do |actual_feed|
      expected_feed.each do |item|
        actual_feed.has_selector?("li##{item.id}", text: item.content)
      end
    end
  end

  matcher :have_active_link do |link|
    match do |page|
      page.has_css?("li.active a", text: link)
    end
  end

  matcher :have_section do |section|
    match do |page|
      page.has_selector?("div.#{section}")
    end
  end

  matcher :have_pagination_link do |link|
    match do |page|
      page.has_css?("div.pagination ul li a", text: link)
    end
  end

  matcher :display_user_profile_links_for do |users|
    users[0..2].each do |user|
      match do |page|
        page.has_selector?('li>a', text: user.name)
      end
    end
  end
end