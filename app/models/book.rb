class Book < ApplicationRecord
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :book_comments, dependent: :destroy
    # is_impressionable counter_cache: true
    
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
	
	def favorited_by?(user)
	    favorites.where(user_id: user.id).exists?
	end
	
	def showcount
	      counts=Book.find_by(count: params[count])
	      @showcount=counts += 1
	end
	
	def bookcount
		@book=Book.find(params[:id])
		
		# 当日の投稿
		# book=Book.where(create_at: (1.days.ago)..(Time.now))
		# @todayBook=book.count
		@todayBooks=User.where(created_at: 1.day.ago.all_day)
		
		# 昨日の投稿数
		range = Date.yesterday.beginning_of_day..Date.yesterday.end_of_day
		@yesterdayBook=@book.where(create_at: range)
		
		# User.where("created_at between '#{Date.1.weeks.ago} 0:00:00' and '#{Date.2.weeks.ago} 23:59:59'")
		# Book.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day)
	end
	
	scope :created_today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
  # または
  # scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
 
  # 昨日投稿された Post を取得
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
 
  # 3日前に投稿された Post を取得
  scope :created_three_days_ago, -> { where(created_at: 3.days.ago.all_day) }
 
  # 一週間前に投稿された Post を取得
  scope :created_a_week_ago, -> { where(created_at: 1.week.ago.all_day) }
 
  # 一ヶ月前に投稿された Post を取得
  scope :created_a_month_ago, -> { where(created_at: 1.month.ago.all_day) }
 
 
 
	
end
