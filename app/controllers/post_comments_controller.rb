class PostCommentsController < ApplicationController
	before_action :ensure_correct_user, only: [:destroy]

	def create
		@book = Book.find(params[:book_id])
		@post_comment = PostComment.new
		comment = current_user.post_comments.new(post_comment_params)
		comment.book_id = @book.id
		comment.save
	end

	def  destroy
		@book = Book.find(params[:book_id])
		@post_comment = PostComment.new
		comment = PostComment.find_by(id: params[:id], book_id: params[:book_id])
		comment.destroy
	end

	private

  def  post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def ensure_correct_user
    @post_comment = PostComment.find_by(id: params[:id], book_id: params[:book_id])
    unless @post_comment.user == current_user
      redirect_to request.referer
    end
  end

end
