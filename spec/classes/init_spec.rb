require 'spec_helper'
describe 'cactos_cloudiator' do
  context 'with default values for all parameters' do
    it { should contain_class('cactos_cloudiator') }
  end
end
