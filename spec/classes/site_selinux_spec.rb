require 'spec_helper'

describe 'site_selinux' do
  include_context :defaults

  let(:facts) { default_facts }

  let(:params) {{}}

  it { should create_class('site_selinux') }

  it { should have_selinux__module_resource_count(2) }

  it do
    should contain_selinux__module('my-mcollective-iptables').with({
      :ensure => 'present',
      :source => 'puppet:///modules/site_selinux/my-mcollective-iptables',
    })
  end

  it do
    should contain_selinux__module('my-zabbix-agent').with({
      :ensure => 'present',
      :source => 'puppet:///modules/site_selinux/my-zabbix',
    })
  end

  context "when ensure => 'absent'" do
    let(:params) {{ :ensure => 'absent' }}

    it { should have_selinux__module_resource_count(2) }
    it { should contain_selinux__module('my-mcollective-iptables').with_ensure('absent') }
    it { should contain_selinux__module('my-zabbix-agent').with_ensure('absent') }
  end

  context "when manage_modules => false" do
    let(:params) {{ :manage_modules => false }}

    it { should have_selinux__module_resource_count(0) }
    it { should_not contain_selinux__module('my-mcollective-iptables') }
    it { should_not contain_selinux__module('my-zabbix-agent') }
  end

  context "when manage_modules => 'false'" do
    let(:params) {{ :manage_modules => 'false' }}

    it { should have_selinux__module_resource_count(0) }
    it { should_not contain_selinux__module('my-mcollective-iptables') }
    it { should_not contain_selinux__module('my-zabbix-agent') }
  end

  context "when selinux::mode => 'permissive'" do
    let(:pre_condition) { "class { 'selinux': mode => 'permissive' }" }

    it { should have_selinux__module_resource_count(2) }
    it { should contain_selinux__module('my-mcollective-iptables').with_ensure('present') }
    it { should contain_selinux__module('my-zabbix-agent').with_ensure('present') }
  end

  context "when selinux::mode => 'enforcing'" do
    let(:pre_condition) { "class { 'selinux': mode => 'enforcing' }" }

    it { should have_selinux__module_resource_count(2) }
    it { should contain_selinux__module('my-mcollective-iptables').with_ensure('present') }
    it { should contain_selinux__module('my-zabbix-agent').with_ensure('present') }
  end

  context "when selinux::mode => 'disabled'" do
    let(:pre_condition) { "class { 'selinux': mode => 'disabled' }" }

    it { should have_selinux__module_resource_count(0) }
    it { should_not contain_selinux__module('my-mcollective-iptables') }
    it { should_not contain_selinux__module('my-zabbix-agent') }
  end

end
