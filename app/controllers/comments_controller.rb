class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.article_id = params[:article_id]
        if current_user
            @comment.author_name = current_user.username;
            @comment.save
            redirect_to article_path(@comment.article)
        else
            flash[:alert] = "You need to login to comment in the post"
            redirect_to article_path(@comment.article)
        end
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy
        flash[:notice] = "Comment deleted successfully"
        redirect_to article_path(@comment.article)
    end
    

    def comment_params
      params.require(:comment).permit(:body)
    end
    
end
