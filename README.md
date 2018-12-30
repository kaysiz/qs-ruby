# DocuSign Quick Start examples for Ruby and Ruby on Rails

Repository: [qs-ruby](https://github.com/docusign/qs-ruby)

These quick start examples provide straight-forward
code examples for quickly
trying the DocuSign eSignature API with the
[Ruby SDK](https://github.com/docusign/docusign-ruby-client).

The repo includes:

1. Embedding a signing ceremony in your web application.
   [Source.](https://github.com/docusign/qs-ruby/blob/master/app/controllers/embedded_signing_controller.rb)
2. Sending a signing request via an email to the signer.
   [Source.](https://github.com/docusign/qs-ruby/blob/master/app/controllers/send_envelope_controller.rb)
3. Listing the envelopes in the user's account, including their status.
   [Source.](https://github.com/docusign/qs-ruby/blob/master/app/controllers/list_envelopes_controller.rb)

These examples do not include authentication. Instead,
use the DocuSign DevCenter's
[OAuth token generator](https://developers.docusign.com/oauth-token-generator)
to create an access token.

For a Ruby on Rails code example launcher, including Omniauth authentication 
via the Authorization Code Grant flow and 14 workflow code examples, see 
the [eg-03-ruby-auth-code-grant](https://github.com/docusign/eg-03-ruby-auth-code-grant)
repository.

For a Ruby JWT authentication example, see the
[eg-01-ruby-jwt](https://github.com/docusign/eg-01-ruby-jwt)
repository. 

For more information, see the
[DocuSign DevCenter Code Examples section](https://developers.docusign.com/esign-rest-api/code-examples).

## Installation

This example uses Ruby version 2.5.3 but will work with many other versions of Ruby.

Download or clone this repository to a file directory.
Then:

````
cd qs-ruby
bundler install
````

### Configure the example's settings
Each quick start example is a standalone file. You will configure
each of the example files by setting the variables at the top of each
file:

 * **Access token:** Use the [OAuth Token Generator](https://developers.docusign.com/oauth-token-generator).
   To use the token generator, you'll need a
   [free DocuSign Developer's account.](https://go.docusign.com/o/sandbox/)

   Each access token lasts 8 hours, you will need to repeat this process
   when the token expires. You can use the same access token for
   multiple examples.

 * **Account Id:** After logging into the [DocuSign Sandbox system](https://demo.docusign.net),
   you can copy your Account Id from the dropdown menu by your name. See the figure:

   ![Figure](https://raw.githubusercontent.com/docusign/qs-python/master/documentation/account_id.png)
 * **Signer name and email:** Remember to try the DocuSign signing ceremony using both a mobile phone and a regular
   email client.
   
 Configure the access token, account id, and your email address in each of the three
 files:
 
 1. [embedded_signing_controller.rb](https://github.com/docusign/qs-ruby/blob/master/app/controllers/embedded_signing_controller.rb)
 1. [send_envelope_controller.rb](https://github.com/docusign/qs-ruby/blob/master/app/controllers/send_envelope_controller.rb)
 1. [list_envelopes_controller.rb](https://github.com/docusign/qs-ruby/blob/master/app/controllers/list_envelopes_controller.rb)
 

## Run the examples launcher

````
rails s
````

Then use your web browser to navigate to http://localhost:3000

## Support, Contributions, License

Submit support questions to [StackOverflow](https://stackoverflow.com). Use tag `docusignapi`.

Contributions via Pull Requests are appreciated.
All contributions must use the MIT License.

This repository uses the MIT license, see the
[LICENSE](https://github.com/docusign/eg-01-Python-jwt/blob/master/LICENSE) file.
