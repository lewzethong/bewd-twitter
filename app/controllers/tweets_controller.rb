class TweetsController < ApplicationController

  def create
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = user.tweets.new(tweet_params)

      if @tweet.save
        render 'tweets/create'
      else
        render json: {success: false}
      end
    else
      render json: {success: false}
    end
  end

  def destroy
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      @tweet = Tweet.find_by(id: params[:id])

      if @tweet.user_id == user.id and @tweet.destroy
        render json: { success: true }
      else
        render json: { success: false }
      end
    else
      render json: {success: false}
    end
  end

  def index
    @tweets = Tweet.all

    render 'tweets/index'
  end

  def index_by_user
    user = User.find_by(username: params[:username])
    @tweets = user.tweets

    render 'tweets/index'
  end

  private 

    def tweet_params
      params.require(:tweet).permit(:message)
    end

end
