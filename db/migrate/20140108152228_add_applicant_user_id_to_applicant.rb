class AddApplicantUserIdToApplicant < ActiveRecord::Migration
  def change
    add_column :applicants, :applicant_user_id, :integer
  end
end
