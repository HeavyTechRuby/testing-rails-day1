class Episode < ApplicationRecord
  validates :title, presence: true, format: { with: /[a-z]+/i }
  validate :podcast_not_archived

  belongs_to :podcast
  has_many :likes
  has_many :comments
  has_many :play_stats

  scope :published, -> { where(status: :published) }
  scope :popular, -> { joins(:likes) }
  scope :played, -> { joins(:play_stats).where(play_stats: { is_finished: true }) }

  def like(user)
    Like.create(user: user, episode: self)
  end

  def unlike(user)
    Like.delete_by(user: user, episode: self)
  end

  def add_comment(user, text)
    Comment.create(user: user, text: text, episode: self)
  end

  def del_comment(user)
    Comment.delete_by(user: user, episode: self)
  end

  def publish
    self.status = "published"
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

  def unpublish
    self.status = "unpublished"
  end

  def unpublished?
    self.status == "unpublished"
  end

  def podcast_not_archived
    return if podcast.nil?

    if podcast.archived?
      errors.add(:podcast, "is archived")
    end
  end
end
