class AppError < StandardError; end

class BadRequestError < AppError
  def status = 400
end
