class SentencesController < ApplicationController
    
  before_action :move_to_index, except: [:index, :show, :calendar]
  
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
    @meetings = Sentence.where(start_time: nil)
    @youbi = Time.current

    @first_date = params[:start_date]

    if @first_date == nil then
      @first_date = Date.current
    else
      @first_date = Date.strptime( @first_date,'%Y-%m-%d')
    end
    @n_week = mweek(@first_date)
    
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
  
def mweek(date)
  first_week = (date - (date.day - 1)).cweek
  this_week = date.cweek

  # 年末は暦週が 1 になったり、逆に年始に暦週が 53 に
  # なることがあるため、その対処を以下でする
  if this_week < first_week
    
    if date.month == 12
      # 年末の場合は、前週同曜日の週番号を求めて + 1 してあげればよい
      # ここを通ることがあるのは、大晦日とその前の数日となる
      return mweek(date - 7) + 1
      
    else
      # 年始の場合は、月初の数日が 53 週目に組み込まれてしまっている
      # 二週目以降にここを通ることがある
      return this_week + 1
    end
  end
  
  return this_week - first_week + 1
end
  #https://gist.github.com/komiya-atsushi/3269033
  #http://kiyorin-net.blogspot.com/2011/03/ruby.html
  
end
