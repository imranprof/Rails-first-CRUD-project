class FriendsController < ApplicationController
  before_action :set_friend, only: %i[ show edit update destroy ]

  # GET /friends or /friends.json
  def index
    @friends = Friend.all

  end

  # GET /friends/1 or /friends/1.json
  def show
  end

  # GET /friends/new
  def new
    @friend = Friend.new()
    @friend.blogs.build
  end

  def new1
    @friend = Friend.new()
    @friend.blogs.build
    render 'friends/new1'

  end

  # GET /friends/1/edit
  def edit
    @friend.blogs.build

  end

  # POST /friends or /friends.json

  def create
    @friend = Friend.new(friend_params)
      if @friend.save
        #new code here
          blogs = params[:blogs]
          if blogs ==nil
            redirect_to friends_path, notice: "User create without blogs........"
            #return
          else

              blogs = params.require(:blogs)
              #raise blogs.inspect
              blogs.each do
              |blog|
                @friend.blogs.create(title: blog[1][:title], content: blog[1][:content], status: 0)
              end
              redirect_to friend_blogs_path(@friend), notice: "User add with blogs.."

          end

        else
          render :new1, notice: "User create Successfully without blogs.."
        end


    end

  #my create method


  # PATCH/PUT /friends/1 or /friends/1.json
  def update
    respond_to do |format|
      if @friend.update(friend_params)
        format.html { redirect_to friend_url(@friend),  notice: "User Details Update Successfully.."}
        format.json { render :show, status: :ok, location: @friend }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @friend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friends/1 or /friends/1.json
  def destroy
    user = Friend.find params[:id]

    user.destroy

    respond_to do |format|
      format.html { redirect_to friends_url, notice: "User Delete Successfully.."}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend
      @friend = Friend.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_params
      params.require(:friend).permit(:first_name, :last_name, :email, :twitter)
    end
end
