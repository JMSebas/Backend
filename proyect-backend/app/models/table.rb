class Table < ApplicationRecord
    has_many :orders

    enum status: {occupied: 2, free: 1}
end
