class Movie < ActiveRecord::Base

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :rating, inclusion: {in: RATINGS,
                   message: "Must have valid rating #{RATINGS}"
              }
  validates :title, :released_on, presence: true
  validates :description, length: {maximum: 200}
  validates :total_gross, numericality: {greater_than_or_equal_to: 0}
  validates :image_file_name, allow_blank: true, format: {
                                with:    /\w+\.(gif|jpg|png)\z/i,
                                message: "must reference a GIF, JPG, or PNG image"
                            }
  has_many :reviews, dependent: :destroy

  def self.released
    where("released_on <= ?", Time.now).order("released_on desc")
  end
  
  def self.hits
    where('total_gross >= 300000000').order('total_gross desc')
  end
  
  def self.flops
    where('total_gross < 10000000').order('total_gross asc')
  end
  
  def self.recently_added
    order('created_at desc').limit(3)
  end

  def flop?
    total_gross.blank? || total_gross < 50000000 && reviews.average(:stars) < 4
  end
end
