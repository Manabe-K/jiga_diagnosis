Rails.application.routes.draw do
  resources :questions, only: [:index]
  root "home#index"
  get "/result", to: "questions#result"
  get "/analyzing", to: "questions#analyzing"
  get 'ogp/:level', to: 'questions#ogp', as: :ogp_image
end
