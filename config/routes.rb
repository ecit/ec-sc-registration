ActionController::Routing::Routes.draw do |map|
  map.resources :bookings, :except => :destroy
  map.submit '/bookings/:id/submit', :controller => 'bookings', :action => 'submit'
  map.connect '/bookings/:id/show', :controller => 'bookings', :action => 'show'

  map.root :bookings
end
