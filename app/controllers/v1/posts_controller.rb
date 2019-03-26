class V1::PostsController < V1::BaseController
  def index
    posts = Post.all

    render json: posts, root: false
  end

  def show
    post = Post.find(params[:id])

    render json: { news_head: post,
                   news_body: post.news_content}, root: false

  end

end
