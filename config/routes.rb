Rails.application.routes.draw do
  resources :questions, only: [:index]
  root "home#index"
  get "/result", to: "questions#result"
  get "/analyzing", to: "questions#analyzing"
  get "share/level/:id", to: "share#show", as: :share_level
end
