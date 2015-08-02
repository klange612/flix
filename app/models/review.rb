class Review < ActiveRecord::Base

  STARS = [1,2,3,4,5]
  validates :name, presence: true
  validates :stars, inclusion: {in: STARS,
                   messages: "Stars must be beween 1 and 5"}
  validates :comment, length: {minimum: 4, maximum: 125}

  belongs_to :movie

  def review_groups
    @reviews.each do |review|
#      if review.movie_id == (params(:id))
        review
#      end
    end
  end

end
