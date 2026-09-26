Rails.application.routes.draw do
  draw :rori

  resources :notes, only: %i[ index show new edit ]
  resources :folders, only: :show

  root "rori/desktops#show"
end
