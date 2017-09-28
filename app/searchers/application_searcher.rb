class ApplicationSearcher
  include SimpleMathOperations

  def initialize params={}
    @params = params
  end

  def search
    initialize_results

    @params.each do |attribute, value|
      next if attribute == :current_user

      method_name = :"search_by_#{ attribute }"

      send method_name, value if respond_to?(method_name, true)
    end

    @results
  end

  private
  def initialize_results
    @results = []
  end

  class << self
    def search params={}
      new(params).search
    end
  end

  def user
    @user ||= @params[:current_user]
  end
end