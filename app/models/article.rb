class Article < ActiveRecord::Base
  #has_many添加一对多关联和comment.rb中的 belongs_to :article一起构成了关联
  has_many :comments, dependent: :destroy
  #限制每篇文章至少有五个字符
  validates :title, presence: true,length: { minimum: 5 }
end