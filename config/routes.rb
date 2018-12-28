Rails.application.routes.draw do
  get 'list_envelopes/index'
  get 'send_envelope/index'
  get 'embedded_signing/index'
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'welcome#index'
end
