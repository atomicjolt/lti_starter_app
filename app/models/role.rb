class Role < ApplicationRecord

  has_many :permissions, dependent: :destroy
  has_many :users, through: :permissions

  validates :name, presence: true, uniqueness: true

  def self.by_alpha
    order("roles.name ASC")
  end

  def self.by_nil_or_context(context_id)
    where("context_id=? OR context_id IS NULL", context_id)
  end

  # roles can be defined as symbols.  We want to store them as strings in the database
  def name=(val)
    write_attribute(:name, val.to_s)
  end

end
