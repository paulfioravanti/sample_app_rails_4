require 'spec_helper'

describe "Routing" do

  all_locales do |locale|

    it "routes /locale to static_pages#home" do
      expect(get("/#{locale}")).to \
        route_to("static_pages#home", locale: locale.to_s)
    end

    it "routes /signup to users#new" do
      expect(get("/#{locale}/signup")).to \
        route_to("users#new", locale: locale.to_s)
    end

    it "routes /signin to sessions#new" do
      expect(get("/#{locale}/signin")).to \
        route_to("sessions#new", locale: locale.to_s)
    end

    it "routes /signout to sessions#destroy" do
      expect(delete("/#{locale}/signout")).to \
        route_to("sessions#destroy", locale: locale.to_s)
    end

    it "routes /help to static_pages#help" do
      expect(get("/#{locale}/help")).to \
        route_to("static_pages#help", locale: locale.to_s)
    end

    it "routes /about to static_pages#about" do
      expect(get("/#{locale}/about")).to \
        route_to("static_pages#about", locale: locale.to_s)
    end

    it "routes /contact to static_pages#contact" do
      expect(get("/#{locale.to_s}/contact")).to \
        route_to("static_pages#contact", locale: locale.to_s)
    end
  end
end