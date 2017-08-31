class ApplicationSearcher
  def self.search params
    queries = params.map do |k, v|
      if v.is_a? String 
        ".where(#{ { k => v } })"
      elsif v.is_a? Array
        arg1 = "'#{ k } @> ARRAY[?]::varchar[]'"
        ".where(#{ arg1 }, #{ v })"
      else
        ""
      end
    end

    eval "#{ self.to_s[0..-9] }#{ queries.join }"
  end
end