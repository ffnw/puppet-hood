require 'spec_helper'
describe 'hood' do

  context 'with defaults for all parameters' do
    it { should contain_class('hood') }
  end
end
