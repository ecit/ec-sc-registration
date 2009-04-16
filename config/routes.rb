ActionController::Routing::Routes.draw do |map|
  map.resources :bookings, :except => :destroy
  map.root :bookings
end
