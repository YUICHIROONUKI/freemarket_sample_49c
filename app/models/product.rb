class Product < ApplicationRecord
  belongs_to :user, optional: true
  has_many :likes, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :chats, dependent: :destroy
  belongs_to :brand, optional: true
  belongs_to :category
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :name, :description, :category_id, :condition, :shipping_feeh, :shipping_method, :prefecture_id, :shipping_date, :price, :seller_id, presence: true
  validates :name, length: { maximum: 40 }
  validates :description, length: { maximum: 1000 }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: '300以上9999999以下で入力してください' }
  validates :images, length: { minimum: 1, maximum: 10}

  # scope :parent, -> (count){ Category.find(count)}
  # scope :child, -> { Category.where( parent_id: parent.id )}
  # scope :grandchild, -> { Category.where( parent_id: child.ids )}
  # scope :recent, -> { where(category_id: grandchild ).order(created_at: :DESC).limit(4)}

  scope :recent_category, lambda { |count|
    parent = Category.find(count)
    child = Category.where( parent_id: parent.id )
    grandchild = Category.where( parent_id: child.ids )
    where(category_id: grandchild ).order(created_at: :DESC).limit(4)
  }

  scope :recent_brand, lambda { |count|
    where(brand_id: count ).order(created_at: :DESC).limit(4)
  }
end
