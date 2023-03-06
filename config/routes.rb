# frozen_string_literal: true

Rails.application.routes.draw do
  get 'vacations/index'
  post 'vacations/create'

  resources :vacation_periods
  resources :collaborators
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
