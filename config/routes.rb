Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/submit", to: "infections#submit"
  post "/temp_ids", to: "infections#temp_ids"
end
