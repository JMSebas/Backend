class Table < ApplicationRecord
    has_many :orders
    after_update_commit { broadcast_message }

    enum status: {free: 1, occupied: 2}
 private

    def broadcast_message
        ActionCable.server.broadcast("TableChannel", { action: "updated", table: self })
    end

    
end
