class CreateUserSpecs < ActiveRecord::Migration[6.1]
  def change
    create_table :user_specs do |t|

      t.timestamps
    end
  end
end
