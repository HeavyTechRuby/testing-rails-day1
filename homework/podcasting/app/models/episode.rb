class Episode < ApplicationRecord
  validates :title, presence: true, format: { with: /[a-z]+/i }
  validate :podcast_not_archived

  belongs_to :podcast
  has_many :likes
  has_many :comments
  has_many :stats

  scope :published, -> { where(status: :published) }
  scope :popular, -> { joins(:likes) }

  def publish
    self.status = "published"
  end

  def unpublish
    self.status = "draft"
  end

  def published?
    self.status == "published"
  end

  def draft
    self.status = "draft"
  end

  def draft?
    self.status == "draft"
  end

  def podcast_not_archived
    return if podcast.nil?

    if podcast.archived?
      errors.add(:podcast, "is archived")
    end
  end

  def like_by(user)
    likes.create(user:)
  end

  def unliked_by(user)
    likes.find_by(user:).destroy
  end

  def play_by(user)
    stats.create(user:)
  end

  def pause_by(user, position)
    stat = stats.find_by(user:)
    stat.update(position:)
  end
end
