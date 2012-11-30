require 'spec_helper'

describe AuditTrail do
  before(:each) do
    @audit_trail = FactoryGirl.build(:audit_trail)
  end

  it { should respond_to(:action) }
  it { should respond_to(:element_id) }
  it { should respond_to(:element_class) }
  it { should respond_to(:username) }

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
      it "should be invalid without a element class" do
        @audit_trail.element_class = nil
        @audit_trail.should be_invalid

        @audit_trail.element_class = ""
        @audit_trail.should be_invalid

        @audit_trail.element_class = " "
        @audit_trail.should be_invalid
      end
    end

    describe "Required fields: " do
      it "should be invalid without a username " do
        @audit_trail.username = nil
        @audit_trail.should be_invalid

        @audit_trail.username = ""
        @audit_trail.should be_invalid

        @audit_trail.username = " "
        @audit_trail.should be_invalid
      end
    end

    it "should be valid with a valid element id and element type" do
      @audit_trail.should be_valid_verbose
    end
  end

end
