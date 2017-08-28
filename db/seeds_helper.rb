def gen_gender
  %w[male female].sample
end

def gen_lat
  rand * 180 - 90
end

def gen_lng
  rand * 360 - 180
end

def gen_place_tags
  SeedsData.place_tags.sample(rand(3..5))
end

def gen_place_id
  ""
end

def gen_rating
  rand 1..5
end

def gen_quote
  eval "Faker::#{ SeedsData.quote_settings.sample }.quote"
end

class SeedsData
  def self.place_tags
    %w[food fresh pizza ravioli spaghetti hamburger cafe restaurant bar grill pub saloon bistro 
       cafeteria coffee lemonade biscuit juice icecream cocktail music movie meal drink ale alcohol 
       martini soda dinner beer family sweet sherbet]
  end

  def self.quote_settings
    %w[Overwatch HitchhikersGuideToTheGalaxy HowIMetYourMother Witcher StarWars Friends]
  end
end
