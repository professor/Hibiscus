require 'spec_helper'

describe "Flags" do
  describe "GET /flags" do
    it "works! (now write some real specs)" do
      get flags_path
      response.status.should be(200)
    end
  end
end
