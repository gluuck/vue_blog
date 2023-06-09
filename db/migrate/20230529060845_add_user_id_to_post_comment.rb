# frozen_string_literal: true

class AddUserIdToPostComment < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
    add_reference :comments, :user, null: false, foreign_key: true
  end
end
