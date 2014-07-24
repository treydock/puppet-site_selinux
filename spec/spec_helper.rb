require 'puppetlabs_spec_helper/module_spec_helper'
require 'hiera-puppet-helper/version'
require 'hiera-puppet-helper/puppet'
require 'hiera-puppet-helper/rspec'
require 'hiera'
require 'puppet/indirector/data_binding/hiera'

def hiera_stub
  config = Hiera::Config.load(hiera_config)
  config[:logger] = 'puppet'
  Hiera.new(:config => config)
end

RSpec.configure do |c|
  c.mock_framework = :rspec

  c.before(:each) do
    Puppet::DataBinding::Hiera.stub(:hiera => hiera_stub)
  end
end

shared_context :defaults do
  let :default_facts do
    {
      :kernel                     => 'Linux',
      :osfamily                   => 'RedHat',
      :operatingsystem            => 'CentOS',
      :operatingsystemrelease     => '6.5',
      :operatingsystemmajrelease  => '6',
      :architecture               => 'x86_64',
      :concat_basedir             => '/dne',
    }
  end
end

at_exit { RSpec::Puppet::Coverage.report! }
