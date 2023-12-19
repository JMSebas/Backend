class Table < ApplicationRecord
    has_many :orders

    enum status: {free: 1, occupied: 2}
end
