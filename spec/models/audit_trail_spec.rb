require 'spec_helper'

describe AuditTrail do
  before(:each) do
    @audit_trail = FactoryGirl.build(:audit_trail)
  end

  it { should respond_to(:action) }
  it { should respond_to(:element_id) }
  it { should respond_to(:element_type) }

  describe "Required fields: " do
    it "should be invalid without a action" do
      @audit_trail.action = nil
      @audit_trail.should be_invalid

      @audit_trail.action = ""
      @audit_trail.should be_invalid

      @audit_trail.action = " "
      @audit_trail.should be_invalid
    end

    describe "Required fields: " do
      it "should be invalid without a element id" do
        @audit_trail.element_id = nil
        @audit_trail.should be_invalid

        @audit_trail.element_id = ""
        @audit_trail.should be_invalid

        @audit_trail.element_id = " "
        @audit_trail.should be_invalid
      end
    end

    describe "Required fields: " do
      it "should be invalid without a element type" do
        @audit_trail.element_type = nil
        @audit_trail.should be_invalid

        @audit_trail.element_type = ""
        @audit_trail.should be_invalid

        @audit_trail.element_type = " "
        @audit_trail.should be_invalid
      end
    end

    it "should be valid with a valid element id and element type" do
      @audit_trail.should be_valid_verbose
    end
  end

end
