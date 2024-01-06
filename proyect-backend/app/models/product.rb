class Product < ApplicationRecord
    has_many :items
    has_many :orders , through: :items
    
    # validates :name, :description, :price, :category, presence: true
    
    enum status: { available: 1, unavailable: 2 }

    enum category: {ensalada: 1, pizza: 2, hamburguesa: 3, gaseosas: 4, jugos: 5}
end
