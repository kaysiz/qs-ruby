require 'test_helper'

class SendEnvelopeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get send_envelope_index_url
    assert_response :success
  end

  test "should get create" do
    get send_envelope_create_url
    assert_response :success
  end

end
