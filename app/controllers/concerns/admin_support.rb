module Concerns
  module AdminSupport
    extend ActiveSupport::Concern

    included do
      before_action :only_admins!
    end

    private

    def only_admins!
      user_not_authorized unless current_user.admin?
    end

  end
end
