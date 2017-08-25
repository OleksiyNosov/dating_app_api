class ApplicationDecorator < Draper::Decorator
  def as_json *args
    super only: _only, methods: _methods
  end

  private
  def _only
    [] 
  end

  def _methods 
    [] 
  end
end
