class CreateAudios < ActiveRecord::Migration[7.0]
  def change
    create_table :audios do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid
      t.binary :audio_data

      t.timestamps
    end
    add_index :audios, :uuid, unique: true
  end
end
