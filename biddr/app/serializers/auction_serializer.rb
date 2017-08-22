class AuctionSerializer < ActiveModel::Serializer
  attributes :id, :title, :details
  belongs_to :user, key: :author
  has_many :bids

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name
  end

  class BidSerializer < ActiveModel::Serializer
    attributes :id, :price, :current_price, :author_full_name, :created_at, :updated_at

    def author_full_name
      object.user&.full_name
    end
  end
end
