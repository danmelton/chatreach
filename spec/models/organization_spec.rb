require 'spec_helper'

describe Organization do 
  before do
    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=1000%20S%20Van%20Ness,%20San%20Francisco,%20CA,%2094110,%20USA&language=en&sensor=false").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => fixture('google_maps'), :headers => {})
    @organization = Factory(:organization, :brands => [Factory(:brand)])
  end
    
  context 'responds' do
    it 'to tags' do
      @organization.respond_to?(:tag_list).should be_true
      @organization.tag_list.size.should == 2
    end
    
    it "to state_name" do
      @organization.respond_to?(:state_name)
      @organization.state_name.should == "California"
    end
    
    it "to full_street_address" do
      @organization.respond_to?(:full_street_address)
      @organization.full_street_address.should == "#{@organization.address}, #{@organization.city}, #{@organization.state}, #{@organization.zip}, #{@organization.country}"
    end
    
    it "to brands" do
      @organization.respond_to?(:brands)
    end  
  end
  context 'destroy' do
    it 'deletes brand_organizations' do
      lambda {@organization.destroy}.should change(BrandOrganization, :count).by(-1)
    end
  end
  

end
