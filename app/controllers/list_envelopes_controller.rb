class ListEnvelopesController < ApplicationController
  # This is a quick start example for listing the envelopes
  # whose status has changed in the last 10 days
  # Language: Ruby
  #
  # See the Readme and Setup files for more information.
  #
  # Copyright (c) DocuSign, Inc.
  # License: MIT Licence. See the LICENSE file.
  #
  # This example does not include authentication. Instead, an access token
  # must be supplied from the Token Generator tool on the DevCenter or from
  # elsewhere.
  #
  # This example also does not look up the DocuSign account id to be used.
  # Instead, the account id must be set.
  #
  # For a more production oriented example, see the
  # Authorization code grant authentication example:
  #      https://github.com/docusign/eg-03-ruby-auth-code-grant
  #
  #
  def index
    # Fill in these constants:
    # Obtain an OAuth token from https://developers.hqtest.tst/oauth-token-generator
    access_token = '{ACCESS_TOKEN}'

    # Obtain your accountId from demo.docusign.com -- the account id is shown in the drop down on the
    # upper right corner of the screen by your picture or the default picture.
    account_id = '{ACCOUNT_ID}'

    base_path = 'http://demo.docusign.net/restapi'

    # Step 1. Create a date string for 10 days ago and call the API
    # The Envelopes::listStatusChanges method has many options
    # See https://developers.docusign.com/esign-rest-api/reference/Envelopes/Envelopes/listStatusChange#
    # The list status changes call requires at least a from_date OR
    # a set of envelopeIds. Here we filter using a from_date.
    # Here we set the from_date to filter envelopes for the last month
    # # Use ISO 8601 date format
    options =  DocuSign_eSign::ListStatusChangesOptions.new
    options.from_date = (Date.today - 10).strftime("%Y/%m/%d")

    # Step 2. Call the API
    configuration = DocuSign_eSign::Configuration.new
    configuration.host = base_path
    api_client = DocuSign_eSign::ApiClient.new configuration
    api_client.default_headers["Authorization"] = "Bearer " + access_token
    envelopes_api = DocuSign_eSign::EnvelopesApi.new api_client
    results = envelopes_api.list_status_changes account_id, options

    # Prepare data for the view template
    @api_results = results

  rescue DocuSign_eSign::ApiError => e
    @error_msg = e.response_body
    render "welcome/error_return"
  end
end
