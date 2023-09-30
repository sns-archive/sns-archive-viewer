Rails.application.routes.draw do
  resources :tests, only: %i[index]
end
