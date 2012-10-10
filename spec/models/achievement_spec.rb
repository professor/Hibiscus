require 'spec_helper'

describe Achievement do
  
  it 'can be created' do
    lambda {
      FactoryGirl.create(:achievement)
    }.should change(Achievement, :count).by(1)
  end

  context "is not valid" do

    [:name, :description, :level].each do |attr|
      it "without #{attr}" do
        subject.should_not be_valid
        subject.errors[attr].should_not be_empty
      end
    end
  end
end
