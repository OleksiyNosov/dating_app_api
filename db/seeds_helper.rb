def gen_rating
  rand 1..5
end

def gen_quote
  eval "Faker::#{ SeedsData.quote_settings.sample }.quote"
end

class SeedsData
  class << self
    def quote_settings
      %w[Overwatch HitchhikersGuideToTheGalaxy HowIMetYourMother Witcher StarWars Friends]
    end
  end
end
