class Relationship < ApplicationRecord
  belongs_to :follower,class_name: "User"
  #たくさんのユーザーにフォローされている1人のユーザー
  belongs_to :followed,class_name: "User"
end
