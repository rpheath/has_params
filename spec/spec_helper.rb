require 'rubygems'
require 'activesupport'
require File.join(File.dirname(__FILE__), '../lib/has_params')

class AppControllerTest
  include RPH::HasParams
  
  GROUP_PARAMS = { :name => 'my group',   :type => 'personal' } 
  USER_PARAMS  = { :name => 'ryan heath', :age => '27'        }
  ID_PARAMS    = '1'
  
  def params
    { :group => GROUP_PARAMS, :user => USER_PARAMS, :id => ID_PARAMS }
  end
end