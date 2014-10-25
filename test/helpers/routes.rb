# :nodoc: the routes used in all tests
class ActionController::TestCase
  def setup_routes
    @routes = ActionDispatch::Routing::RouteSet.new

    @routes.draw do
      resource :cookie, controller: 'cookie' do
        collection do
          get :bouncer
          put :update
        end
      end
      resource :http_basic, controller: 'http_basic' do
        collection { get :bouncer }
      end

      # NOTE: this route should be kept in sync with the session template.
      authpwn_session

      authpwn_session controller: 'bare_session', method_names: 'bare_session'
      authpwn_session controller: 'bare_session2',
                      method_names: 'bare_session2'
      root to: 'session#index'
    end
    ApplicationController.send :include, @routes.url_helpers
    ActionMailer::Base.send :include, @routes.url_helpers
  end

  setup :setup_routes
end
