class BlogsController < ApplicationController


  def index
    @friend = Friend.find params[:friend_id]
    @blogs = @friend.blogs.sort_by &:id

  end

  def new
    @friend = Friend.find params[:friend_id]
    @blog = Blog.new
  end

  def create
    user = Friend.find params[:friend_id]
    bg_params = params.require(:blog)
    blog = user.blogs.create(title: bg_params[:title], content: bg_params[:content], status: 0)

    if blog.save
      redirect_to friend_blogs_path, notice: "Blog create Successfully.."
    else
      render :new, notice: "Oh No.."
    end
  end

  def edit
    @friend = Friend.find params[:friend_id]
    @blog = Blog.find params[:id]

    user_id = params[:friend_id]
    blog_id = Blog.find params[:id]
    if Friend.exists? id: user_id
      @friend = Friend.find user_id
      if Blog.exists? id: blog_id, friend_id: user_id
        @blog = Blog.find params[:id]
      else
        redirect_to error_path, alert: "No blog found of the user: #{user_id} with the blog id: #{blog_id}"
      end
    else
      redirect_to error_path, alert: "No user found with the user id #{user_id}"
    end


  end


  def update
    user = user_exist params[:friend_id]
    blog_id = Blog.find params[:id]
    bg_params = params.require(:blog)
    blog = user.blogs.find params[:id]
    blog.title = bg_params[:title]
    blog.content = bg_params[:content]
    if blog.save
      redirect_to friend_blogs_path(user, blog_id), notice: "Updated Successfully"
    else
      redirect_to edit_friend_blog_path(params[:friend_id], blog_id), notice: "Failed to Update"
    end
  end



  def show

    @blog = Blog.find params[:id]

  end

  def destroy

      blog = Blog.find params[:id]
      if blog
        blog.destroy
        redirect_to friend_blogs_path, notice: "Blog Deleted successfully..."
      else
        redirect_to friend_blogs_path, notice: "Blog is not found to delete"
      end
  end

  def publish
    user = user_exist params[:friend_id]
    blog = user.blogs.find params[:id]

    if blog.update(status: 1)
      redirect_to friend_blogs_path(user, blog), alert: 'User/Blog id error'
      end

  end

  private

  def user_exist(friend_id)
    if Friend.exists? friend_id
      return Friend.find friend_id
    else
      redirect_to error_path, alert: "No user exits with user id: #{friend_id}"
    end
  end


end
