class AddAcceptedAtToCharge < ActiveRecord::Migration[5.2]
  def change
    add_column :charges, :accepted_at, :datetime
  end
end
