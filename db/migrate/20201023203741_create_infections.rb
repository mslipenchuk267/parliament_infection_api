class CreateInfections < ActiveRecord::Migration[6.0]
  def change
    create_table :infections do |t|
      t.string :temp_id

      t.timestamps
    end
  end
end
