require 'spec_helper'
describe 'apigateway' do

  context 'with defaults for all parameters' do
    it { should contain_class('apigateway') }
  end
end
