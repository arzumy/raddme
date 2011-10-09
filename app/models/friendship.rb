class Friendship < ActiveRecord::Base
  belongs_to :user
  class FriendshipNotCreated < ActiveRecord::Rollback ; end

  def include?(friend_id)
    friend_ids.include?(friend_id)
  end

  def friend_ids
    JSON.parse(self[:friend_ids] || '[]')
  end

  def append(friend)
    raise FriendshipNotCreated if friend.nil? || (user == friend || friend_ids.include?(friend.id))

    begin
      self.update_attributes!(friend_ids: (friend_ids << friend.id).sort!.to_json)
    rescue ActiveRecord::StaleObjectError
      self.reload
      retry
    end

    self
  end

  def delete(friend)
    begin
      self.update_attributes!(friend_ids: (friend_ids.reject { |id| id == friend.id }).sort!.to_json)
    rescue ActiveRecord::StaleObjectError
      self.reload
      retry
    end
    self
  end
end
