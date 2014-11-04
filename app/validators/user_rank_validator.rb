class UserRankValidator < ActiveModel::Validator
  def validate(user)
    # Check Recurring events (need start&end date)
    if user.rank_changed? and user.rank_was == "admin"
      if User.where(rank: 2).count == 1
        user.errors[:rank] << "You can't demote the last admin"
      end
    end
  end
end
