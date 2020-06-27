class Book < ApplicationRecord
  belongs_to :series, optional: true
end
