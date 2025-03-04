class Podcast < ApplicationRecord
  validates :title, presence: true, format: { with: /[a-z]+/i }
  validate :check_author_not_blocked

  belongs_to :author, class_name: "User"
  has_many :subscriptions


  def check_author_not_blocked
    return if author.nil?

    if author.blocked?
      errors.add(:author, "is blocked")
    end
  end

  def subscribe(user)
    subscriptions.build user:
  end

  def unsubscribe(user)
    subscriptions.delete_by user:
  end
end
