class Shop < ActiveRecord::Base

  validates :domain, presence: {allow_blank: false}

end
