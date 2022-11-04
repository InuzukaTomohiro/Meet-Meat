class Public::SearchesController < ApplicationController

  def index
    @tweets = Tweet.search(params[:keyword])
  end

end
