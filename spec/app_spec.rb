# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/spec_helper'

describe HealthHistory::App do
  include Rack::Test::Methods

  def app
    Rack::URLMap.new HealthHistory.route_map
  end

  context 'when asking for options' do
    subject { get '/' }

    context 'digest' do
      before do
        Digest::MD5.should_receive(:hexdigest).with(anything).and_return('a')
        subject
      end

      it 'should have etag' do
        last_response.should be_ok
        last_response.headers['Etag'].should eq '"%s"' % 'a'
      end
    end

    context 'should return the API index' do
      context '/user resource' do
        before { subject }
        let(:result) { JSON.parse last_response.body }
        let(:health) { result['health_history'] }
        let(:user) { health.find { |e| e['rel'] == 'user' } }


        it { user['href'].should == '/user' }
        it { user['type'].should == 'application/health_history.user+json;charset=utf-8' }
      end
    end
  end
end
