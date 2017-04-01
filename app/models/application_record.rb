class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include CommandsExtension
  include FrontUrlExtension
end
