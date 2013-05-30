require 'spec_helper'

describe ApplicationHelper do

  describe "#full_title" do
    let(:base_title) { t('layouts.application.base_title') }

    all_locales do |locale|
      I18n.locale = locale
      context "with a page title" do
        it "displays the base and page title" do
          expect(full_title("foo")).to eql("#{base_title} | foo")
        end
      end
    end

    context "without a page title" do
      it "displays only the base title" do
        expect(full_title("")).to eq(base_title)
      end
    end
  end

  describe "#gravatar_link" do
    let(:link) { 'http://gravatar.com/emails' }
    it "returns the correct link for gravatar" do
      expect(gravatar_link).to eq(link)
    end
  end
end