class RenameReactionsIdSeq < ActiveRecord::Migration[6.1]
  def change
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE reactions_id_seq RENAME TO comments_id_seq;")
  end
end
