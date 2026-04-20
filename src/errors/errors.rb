class BadRequestError < StandardError
    def status = 400
end
