module UsersHelper
  def invitation_status(user)
    if user.invitation_accepted?
      " Accepted at #{user.invitation_accepted_at}"
    else
      " Pending since #{user.invitation_sent_at}"
    end
  end
end
