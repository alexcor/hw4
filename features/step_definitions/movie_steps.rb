# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
    # debugger
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do |rating|
  	if uncheck=="un" then
  		uncheck "ratings_"+rating
  	else
  		check "ratings_"+rating
  	end
  end
end

When /(?:am on|go to) the ([\w\s+]) page for "([\w\s+])"/ do |page,movie|
  @m = Movie.find_by_title(movie)

  if @m != nil
    case page
      when /edit/
        visit edit_movie_path(@m)
      when /details/
        visit movie_path(@m)
    end
  else
    visit movies_path
  end
end

Then /([\w]+) of "([\s\w]+)" should be "([\s\w]+)"/ do |field,movie,value|
  @movie=Movie.find_by_title (movie)
  # debugger
  if @movie==nil
    assert false
  else
    assert @movie[field]==value
  end
end

