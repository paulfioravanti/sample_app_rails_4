require 'spec_helper'

describe MicropostsHelper do
  describe "#wrap" do
    let(:zero_width_space) { '&#8203;' }

    context "with short strings" do
      let(:short_string) { "a" * 5 }
      it "does not contain any zero width spaces" do
        expect(wrap(short_string)).to_not match(zero_width_space)
      end
    end

    context "with long strings" do
      let(:long_string) { "a" * 50 }
      it "contains zero width spaces" do
        expect(wrap(long_string)).to match(zero_width_space)
      end
    end
  end
end