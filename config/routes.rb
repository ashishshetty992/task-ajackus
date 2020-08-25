Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :contacts, only: [:new, :create]
  # resources :visitors, only: [:new, :create]
  # root to: 'visitors#new'

  scope "/:locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :contacts, only: [:new, :create]
  	resources :visitors, only: [:new, :create]
  	root to: 'visitors#new'
  end

  root to: redirect("/#{I18n.default_locale}", status: 302), as: :redirected_root

  get "/*path", to: redirect("/#{I18n.default_locale}/%{path}", status: 302), constraints: {path: /(?!(#{I18n.available_locales.join("|")})\/).*/}, format: false
end
