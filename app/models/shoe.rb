class Shoe < ActiveRecord::Base
    belongs_to :seller, foreign_key: "seller_id", class_name: "User"
    belongs_to :buyer, foreign_key: "buyer_id", class_name: "User"

    validates :name, presence:true, length:{minimum:2}
    validates :price, presence:true, numericality:{greater_than_or_equal_to: 0}
end
