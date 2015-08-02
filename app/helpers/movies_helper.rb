module MoviesHelper

  def recent_reviews(movie)
    movie.reviews.order('created_at desc').limit(2)
  end

  def last_reviews(movie)
    movie.reviews.last(2)
  end

 def format_total_gross(movie)
   if movie.flop?
    content_tag(:strong, 'Flop!')
   else
     number_to_currency(movie.total_gross)
   end
 end
 
 def image_for(movie)
   if movie.image_file_name.blank?
     image_tag('placeholder.png')
   else
     image_tag(movie.image_file_name)
   end
 end

 def average_stars(movie)
   if zero_stars?(movie)
     "No Reviews"
   else
#     pluralize(movie.reviews.average(:stars).round(1), 'star')
     '*' * movie.reviews.average(:stars)
   end
 end

  def zero_stars?(movie)
    movie.reviews.sum(:stars).zero?
  end

end
