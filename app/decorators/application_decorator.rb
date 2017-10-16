class ApplicationDecorator < Draper::Decorator
  def as_json *_args
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
