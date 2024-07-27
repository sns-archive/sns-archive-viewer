Rails.application.routes.draw do
  resources :memos, only: %i[index show create update destroy]
end
