class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_picture, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def new
    if params[:back]
      @picture = Picture.new(pictures_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = Picture.new(pictures_params)
    @picture.user_id = current_user.id
    if @picture.save
     redirect_to pictures_path, notice:"写真を投稿しました！"
     #NoticeMailer.sendmail_blog(@blog).deliver
    else
     render 'new'
    end
  end

  def edit
  end

  def update
    if @picture.update(pictures_params)
      redirect_to pictures_path, notice:"写真を編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to pictures_path, notice: "ブログを削除しました！"
  end

  private
    def pictures_params
      params.require(:picture).permit(:img,:content,:img_cache)
    end

    def set_picture
      @picture = Picture.find(params[:id])
    end
end
