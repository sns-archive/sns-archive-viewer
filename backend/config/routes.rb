Rails.application.routes.draw do
  resources :tests, only: %i[index]
  resources :memos
end
