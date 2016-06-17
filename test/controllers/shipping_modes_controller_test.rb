require 'test_helper'

class ShippingModesControllerTest < ActionController::TestCase

    # Tests controllers's method using fixture
    fixtures :shipping_modes

    def setup
      #request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(LittletubeConfiguration::Authentication::USERNAME,LittletubeConfiguration::Authentication::PASSWORD)
      @shipping_mode = shipping_modes(:shipping_mode_one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:shipping_modes)
    end

    test "should get show" do
      get :show, { :id => @shipping_mode.id }
      assert_response :success
      assert_not_nil assigns(:shipping_mode)
    end

    test "should create shipping mode" do
      assert_difference('ShippingMode.count') do
        post :create, shipping_mode: { mode: "ABC"}
      end
      assert_redirected_to shipping_mode_path(assigns(:shipping_mode))
    end

    def test_routes
      assert_routing "shipping_modes/2", { :controller => 'shipping_modes', :id => '2', :action => 'show' }
      assert_routing "shipping_modes/new", { :controller => 'shipping_modes', :action => 'new' }
    end
end
