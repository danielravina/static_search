class CreateStaticContent < ActiveRecord::Migration
  def change
    create_table :static_content do |t|
      t.text :content
      t.timestamps
    end
  end
end
