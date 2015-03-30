class BlogController < ApplicationController
  def index
    @posts = Post.paginate(:page => params[:page])

    if request.xhr? && !request.wiselinks?
      render partial: 'posts'
      return
    end

    render 'index', locals: {subtitle: I18n.t('blog')}
  end

  def show
    @post = Post.friendly.find(params[:id])

  end
end
