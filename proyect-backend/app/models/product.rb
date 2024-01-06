class Product < ApplicationRecord
    has_many :items
    has_many :orders , through: :items
    


    enum category: {ensalada: 1, pizza: 2, hamburguesa: 3, gaseosas: 4, jugos: 5}
end
