require "spec_helper"

describe "GMO::Payment::ShopAPI" do

  before(:each) do
    @service ||= GMO::Payment::ShopAPI.new({
      :shop_id   => SPEC_CONF["shop_id"],
      :shop_pass => SPEC_CONF["shop_pass"]
    })
  end

  it "has an attr_reader for shop_id" do
    @service.shop_id.should == SPEC_CONF["shop_id"]
  end

  it "has an attr_reader for shop_pass" do
    @service.shop_pass.should == SPEC_CONF["shop_pass"]
  end

  describe "#entry_tran" do
    it "gets data about a transaction", :vcr do
      result = @service.entry_tran({
        :order_id => 100,
        :job_cd => "AUTH",
        :amount => 100
      })
      result["AccessID"].nil?.should_not be_true
      result["AccessPass"].nil?.should_not be_true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.entry_tran()
      }.should raise_error
    end
  end

  describe "#exec_tran" do
    it "gets data about a transaction", :vcr do
      client_field1 = "client_field1"
      result = @service.exec_tran({
        :order_id      => 100,
        :access_id     => ACCESS_ID,
        :access_pass   => ACCESS_PASS,
        :method        => 1,
        :pay_times     => 1,
        :card_no       => "4111111111111111",
        :expire        => "1405",
        :client_field1 => client_field1
      })
      result["ACS"].nil?.should_not be_true
      result["OrderID"].nil?.should_not be_true
      result["Forward"].nil?.should_not be_true
      result["Method"].nil?.should_not be_true
      result["PayTimes"].nil?.should_not be_true
      result["Approve"].nil?.should_not be_true
      result["TranID"].nil?.should_not be_true
      result["TranDate"].nil?.should_not be_true
      result["CheckString"].nil?.should_not be_true
      result["ClientField1"].nil?.should_not be_true
      (result["ClientField1"] == client_field1).should be_true
      result["ClientField3"].nil?.should_not be_true
    end

    it "got error if missing options", :vcr do
      lambda {
        result = @service.exec_tran()
      }.should raise_error
    end
  end

end