class Question < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  before_validation :set_titleless_title
  belongs_to :user
  has_many :answers, dependent: :destroy
  scope :recent, -> { order(created_at: :desc) }

  private

    def set_titleless_title
      self.title = 'タイトルなし' if title.blank?
    end
end
