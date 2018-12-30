class SendEnvelopeController < ApplicationController

  # This is a quick start example of sending an envelope (a transaction).
  # The signer will receive an invitation to the signing ceremony via email.
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
  # Authorization code grant authentication example. It includes an express web app:
  #      https://github.com/docusign/eg-03-ruby-auth-code-grant
  #
  #
  def create
    # base_url is the url of this application. Eg http://localhost:3000
    base_url = request.base_url

    # Fill in these constants
    # Obtain an OAuth token from https://developers.hqtest.tst/oauth-token-generator
    access_token = '{ACCESS_TOKEN}'

    # Obtain your accountId from demo.docusign.com -- the account id is shown in the drop down on the
    # upper right corner of the screen by your picture or the default picture.
    account_id = '{ACCOUNT_ID}'

    # Recipient Information:
    signer_name = '{USER_FULLNAME}'
    signer_email = '{USER_EMAIL}'

    base_path = 'http://demo.docusign.net/restapi'
    file_name = 'World_Wide_Corp_lorem.pdf' # The document to be signed.

    # Step 1. Create the envelope request definition
    envelope_definition = DocuSign_eSign::EnvelopeDefinition.new
    envelope_definition.email_subject = "Please sign this document sent via the Ruby SDK"

    doc = DocuSign_eSign::Document.new({
             :documentBase64 => Base64.encode64(File.binread(File.join('data', file_name))),
             :name => "Lorem Ipsum", :fileExtension => "pdf", :documentId => "1"})

    # The order in the docs array determines the order in the envelope
    envelope_definition.documents = [doc]
    # create a signer recipient to sign the document, identified by name and email
    # We're setting the parameters via the object creation
    signer = DocuSign_eSign::Signer.new ({
        :email => signer_email, :name => signer_name, :recipientId => 1})
    sign_here = DocuSign_eSign::SignHere.new ({
        :documentId => '1', :pageNumber => '1',
        :recipientId => '1', :tabLabel => 'SignHereTab',
        :xPosition => '195', :yPosition => '147'
    })

    # Tabs are set per recipient / signer
    tabs = DocuSign_eSign::Tabs.new({:signHereTabs => [sign_here]})
    signer.tabs = tabs
    # Add the recipients to the envelope object
    recipients = DocuSign_eSign::Recipients.new({:signers => [signer]})

    envelope_definition.recipients = recipients
    # Request that the envelope be sent by setting |status| to "sent".
    # To request that the envelope be created as a draft, set to "created"
    envelope_definition.status = "sent"

    # Step 2. Call DocuSign with the envelope definition to have the
    #         envelope created and sent
    configuration = DocuSign_eSign::Configuration.new
    configuration.host = base_path
    api_client = DocuSign_eSign::ApiClient.new configuration
    api_client.default_headers["Authorization"] = "Bearer " + access_token
    envelopes_api = DocuSign_eSign::EnvelopesApi.new api_client

    results = envelopes_api.create_envelope account_id, envelope_definition
    # Prepare data for the view template
    @envelope_id = results.envelope_id
    @signer_name = signer_name
    @signer_email = signer_email
    @api_results = results

  rescue DocuSign_eSign::ApiError => e
    @error_msg = e.response_body
    render "welcome/error_return"
  end

  def index
  end
end
