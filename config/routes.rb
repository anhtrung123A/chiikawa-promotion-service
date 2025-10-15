Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/promotions/apply_promotion", to: "promotions#apply_promotion"
      get "/promotions/my_promotions", to: "promotions#get_all_promotions"
    end
  end
end
