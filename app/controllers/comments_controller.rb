class CommentsController < ApplicationController
  http_basic_authenticate_with name: "233", password: "666", only: :destroy
  def create
    #首先通过article_id找到创建评论的具体文章
    @article = Article.find(params[:article_id])
	#在具体文章中通过.comments.create来创建文章所属的评论
    @comment = @article.comments.create(comment_params)
	#这里使用redirect重新加载article对应show动作
    redirect_to article_path(@article)
  end
  
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end