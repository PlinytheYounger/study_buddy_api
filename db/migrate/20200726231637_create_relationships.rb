class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.string :status
      t.string :action_user_id

      t.timestamps
    end
  end
end
