class V1::PostsController < V1::BaseController
  def index
    posts = Post.all

    render json: posts, root: false
  end
end
