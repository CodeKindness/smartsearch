class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  around_filter :user_time_zone, if: :current_user
  before_action :set_locale
  before_action :current_user
  before_action :set_unread_counts

  protected

  def current_user
    @current_user ||= User.order('RANDOM()').first
  end

  # Sets up Internalization
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

  def set_unread_counts
    result = {}
    Message.unread_counts(current_user).each{ |h| result[h['state'].to_sym] = h['count'].to_i }
    @unread_counts ||= result
  end
end
