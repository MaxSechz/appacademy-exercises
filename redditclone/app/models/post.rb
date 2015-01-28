class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many :post_subs
  has_many :comments
  has_many :subs, through: :post_subs, source: :sub

  def comments_by_parent_id
    chash = Hash.new([])

    all_comments = self.comments.includes(:author)

    all_comments.each do |comment|
      chash[comment.parent_comment_id] += [comment]
    end

    chash
  end
end
