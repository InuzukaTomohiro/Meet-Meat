class Public::UserMeatsController < ApplicationController
  before_action :authenticate_user!
end
