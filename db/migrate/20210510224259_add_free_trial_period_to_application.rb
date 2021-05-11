class AddFreeTrialPeriodToApplication < ActiveRecord::Migration[6.1]
  def change
    add_column :application_instances, :paid_at, :datetime
    add_column :applications, :free_trial_period, :integer, default: 30
  end
end
