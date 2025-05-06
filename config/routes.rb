Rails.application.routes.draw do
  resources :questions, only: [:index]
  root "home#index"
  get "/result", to: "questions#result"
end
