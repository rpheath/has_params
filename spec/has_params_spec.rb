require File.join(File.dirname(__FILE__), 'spec_helper')

describe 'HasParams' do
  before(:each) do
    @controller = AppControllerTest.new
  end
  
  it "should have group params (params[:group])" do
    @controller.has_group_params?.should be_true
    @controller.group_params?.should be_true
  end
  
  it "should have user params (params[:user])" do
    @controller.has_user_params?.should be_true
    @controller.user_params?.should be_true
  end
  
  it "should have id params (params[:id])" do
    @controller.has_id_params?.should be_true
    @controller.id_params?.should be_true
  end
  
  it "should have blank project params (params[:project])" do
    @controller.blank_project_params?.should be_true
    @controller.has_project_params?.should_not be_true
    @controller.project_params?.should_not be_true
  end
  
  it "should raise NoMethodError (i.e. call 'super')" do
    @controller.some_random_method rescue NoMethodError; true
  end
  
  it "should force result to be an instance of TrueClass when true" do
    @controller.user_params?.should be_an_instance_of(TrueClass)
  end
  
  it "should force result to be an instance of FalseClass when false" do
    @controller.blank_user_params?.should be_an_instance_of(FalseClass)
  end
end