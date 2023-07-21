# frozen_string_literal: true

# class for saving users search requests
class SaveUserSearchHistory
  attr_accessor :user_email, :history_list, :search_request

  include FileProcess

  USER_HISTORY_DB = 'data/user_history.yml'

  def initialize(email)
    @user_email = email
  end

  def save_search_request(search_request_id)
    @search_request_id = search_request_id
    user_history_list = ReadUserSearchHistory.new(@user_email)
    @history_list = user_history_list.read_history_from_db
    users_email_exist? ? update_users_history : add_new_users_history
    update_content(USER_HISTORY_DB, history_list)
  end

  def users_email_exist?
    !@history_list.nil? && !@history_list.find { |history| history[:user_email] == @user_email }.nil?
  end

  def add_new_users_history
    @history_list = [{ user_email: @user_email, history: [{ id: @search_request_id, requests_quantity: 1 }] }]
  end

  def update_users_history
    @history_list.each do |user|
      update_history_request(user[:history]) if user[:user_email] == @user_email
    end
  end

  def update_history_request(users_history)
    users_history.map { |request| request[:requests_quantity] += 1 if request[:id] == @search_request_id }
    users_history << { id: @search_request_id, requests_quantity: 1 } unless history_id_array(users_history).include?(@search_request_id)
  end

  def history_id_array(requests)
    requests.map { |request| request = request[:id] }
  end
end
