class SentencesController < ApplicationController
    
  before_action :move_to_index, except: [:index, :show]
  
  def index
    @sentences = Sentence.all.includes(:user).order("updated_at DESC").page(params[:page]).per(5)
  end
  
  def new
  end
  
  def create
    Sentence.create(text: tweet_params[:text], user_id: current_user.id)
    redirect_to action: 'index'
  end
  

  def edit
    @sentences = Sentence.find(params[:id])
  end
  
  def update
    sentence = Sentence.find(params[:id]) 
    if sentence.user_id == current_user.id
      sentence.update(tweet_params)
    end
    redirect_to action: 'index'
  end
  
  
  def show
    @sentences = Sentence.find(params[:id])
  end
  
  
  
  def destroy
    sentence = Sentence.find(params[:id])
    if sentence.user_id == current_user.id
      sentence.destroy
      redirect_to action: 'index'
    end
  end
  
  def calendar
    @meetings = Sentence.where.not(start_time: nil)

  end

  
  #ここから下はプライベート
  private
  
  def tweet_params
    params.permit(:text)
  end

  def move_to_index
    unless user_signed_in?
    redirect_to action: :index
    end
  end
end
