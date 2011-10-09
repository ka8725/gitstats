Rails.application.routes.draw do |map|
  mount  Gitstats::Shitometer => '/gitstats'
end
