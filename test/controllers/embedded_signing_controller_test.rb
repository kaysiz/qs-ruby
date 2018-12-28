require 'test_helper'

class EmbeddedSigningControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get embedded_signing_index_url
    assert_response :success
  end

  test "should get create" do
    get embedded_signing_create_url
    assert_response :success
  end

end
