Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/promotions/apply_promotion", to: "promotions#apply_promotion"
    end
  end
end
