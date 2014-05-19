class MessageTaskSerializer < TaskSerializer
  embed :ids
  attributes :unread_comments_count
  has_many :comments, include: true
  has_many :participants, serializer: UserSerializer, include: true, root: :users

  def unread_comments_count
    CommentLook.where(user_id: current_user.id,
                      comment_id: object.comments.pluck(:id),
                      read_at: nil).count if defined? current_user
  end
end
