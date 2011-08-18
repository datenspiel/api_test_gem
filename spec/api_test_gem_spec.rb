require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "ApiTestGem" do
  before(:each) do
    Dir.chdir("/Users/ds/projects/ave/tavex2/rails")
    puts Dir.getwd
    api_test('product', 'update')
  end
  it "gets the right url" do
    @result[:curl].include?("/products/3").should be true
  end
  it "gets the infos from api_test_config.yml" do
    @result[:curl].include?('"identifier":"Produkt"').should be true
    @result[:curl].include?('"info_short":"short product info"').should be true
    @result[:curl].include?('"minimum_price":12.5').should be true
    @result[:curl].include?('"calc_type_id":1').should be true
  end
  it "returns the result of the curl request" do
    @result[:result].should_not be_nil
    @result[:result].is_a?(String).should be true 
  end
  it "could authenticate if required" do
    pending
  end
end
