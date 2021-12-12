class Question < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  before_validation :set_titleless_title
  belongs_to :user

  private

    def set_titleless_title
      self.title = 'タイトルなし' if title.blank?
    end
end
