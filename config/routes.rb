Rails.application.routes.draw do |map|
  mount  Githist::Shitometer => '/s'
end
