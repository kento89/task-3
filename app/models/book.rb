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
	
	
	
	scope :created_today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
  # または
  # scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
 
  # 昨日投稿された Post を取得
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
 
  # 3日前に投稿された Post を取得
  scope :created_three_days_ago, -> { where(created_at: 2.days.ago.all_day) }
  scope :created_force_days_ago, -> { where(created_at: 3.days.ago.all_day) }
  scope :created_five_days_ago, -> { where(created_at: 4.days.ago.all_day) }
  scope :created_six_days_ago, -> { where(created_at: 5.days.ago.all_day) }
  
  
 
  # 一週間前に投稿された Post を取得
  scope :created_a_week_ago, -> { where(created_at: 1.week.ago.all_day) }
 
  # 一ヶ月前に投稿された Post を取得
  scope :created_a_month_ago, -> { where(created_at: 1.month.ago.all_day) }
 
 
 
 def index
    @articles = Book.all

    @article_by_day = @articles.group_by_day(:created_at).size
    # groupdateのgroup_by_dayメソッドで投稿日(created_at)に基づくグルーピングして個数計上。 
    # => {Wed, 05 May 2021=>23, Thu, 06 May 2021=>20, Fri, 07 May 2021=>3, Sat, 08 May 2021=>0, Sun, 09 May 2021=>12, Mon, 10 May 2021=>2}

    @chartlabels = @article_by_day.map(&:first).to_json.html_safe
    # 投稿日付の配列を格納。文字列を含んでいると正しく表示されないので.to_json.html_safeでjsonに変換。
    # => "[\"2021-05-05\",\"2021-05-06\",\"2021-05-07\",\"2021-05-08\",\"2021-05-09\",\"2021-05-10\"]"

    @chartdatas = @article_by_day.map(&:second)
    # 日別投稿数の配列を格納。
    # => [23, 20, 3, 0, 12, 2]
    
    @cumulative = [ ]
    sum=0
    @chartdatas.each do |a|
      sum = sum + a
    @cumulative<<sum
    
  end
 end
 
	
end
