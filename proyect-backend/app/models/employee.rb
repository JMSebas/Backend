class Employee < ApplicationRecord
    has_many :orders

    enum role:  { waiter: 1, chef: 2 }
end
