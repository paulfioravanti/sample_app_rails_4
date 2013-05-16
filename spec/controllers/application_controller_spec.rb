require 'spec_helper'

describe ApplicationController do
  specify "#url_options contains locale" do
    expect(controller.url_options).to have_key(:locale)
  end
end