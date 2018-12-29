class EmbeddedSigningController < ApplicationController
  # This is a quick start example of embedding the signing ceremony within your website.
  # Language: Node.js
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
    client_user_id = '123' # Used to indicate that the signer will use an embedded
    # Signing Ceremony. Represents the signer's userId within
    # your application.
    authentication_method = 'None' # How is this application authenticating
    # the signer? See the `authenticationMethod' definition
    file_name = 'World_Wide_Corp_lorem.pdf' # The document to be signed.

    # Step 1. Create the envelope request definition
    envelope_definition = DocuSign_eSign::EnvelopeDefinition.new
    envelope_definition.email_subject = "Please sign this document sent via the Ruby SDK"

    doc1 = DocuSign_eSign::Document.new
    doc1.document_base64 = Base64.encode64(File.binread(File.join('data', file_name)))
    doc1.name = "pdf"
    doc1.file_extension = "Lorem Ipsum"
    doc1.document_id = "1"

    # The order in the docs array determines the order in the envelope
    envelope_definition.documents = [doc1]
    # create a signer recipient to sign the document, identified by name and email
    # We're setting the parameters via the object creation
    signer1 = DocuSign_eSign::Signer.new ({
        :email => signer_email, :name => signer_name,
        :clientUserId => client_user_id,  :recipientId => 1
    })
    # routingOrder (lower means earlier) determines the order of deliveries
    # to the recipients. Parallel routing order is supported by using the
    # same integer as the order for two or more recipients.

    # The DocuSign platform searches throughout your envelope's
    # documents for matching anchor strings. So the
    # sign_here_2 tab will be used in both document 2 and 3 since they
    # use the same anchor string for their "signer 1" tabs.
    sign_here1 = DocuSign_eSign::SignHere.new
    sign_here1.anchor_string = "/sn1/"
    sign_here1.anchor_units = "pixels"
    sign_here1.anchor_x_offset = "20"
    sign_here1.anchor_y_offset = "10"
    # Tabs are set per recipient / signer
    tabs = DocuSign_eSign::Tabs.new
    tabs.sign_here_tabs = [sign_here1]
    signer1.tabs = tabs
    # Add the recipients to the envelope object
    recipients = DocuSign_eSign::Recipients.new
    recipients.signers = [signer1]

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
    envelope_id = results.envelope_id

    # Step 3. create the recipient view request for the Signing Ceremony
    view_request =  DocuSign_eSign::RecipientViewRequest.new
    # Set the url where you want the recipient to go once they are done signing
    # should typically be a callback route somewhere in your app.
    view_request.return_url = base_url + '/ds_return'
    # How has your app authenticated the user? In addition to your app's
    # authentication, you can include authenticate steps from DocuSign.
    # Eg, SMS authentication
    view_request.authentication_method = authentication_method
    # Recipient information must match embedded recipient info
    # we used to create the envelope.
    view_request.email = signer_email
    view_request.user_name = signer_name
    view_request.client_user_id = client_user_id

    # Step 4. call the CreateRecipientView API
    results = envelopes_api.create_recipient_view account_id, envelope_id, view_request

    # Step 5. Redirect the user to the Signing Ceremony
    # Don't use an iFrame!
    # State can be stored/recovered using the framework's session or a
    # query parameter on the returnUrl (see the makeRecipientViewRequest method)
    redirect_to results.url
  end

  def index
  end
end
