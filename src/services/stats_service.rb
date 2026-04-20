class StatsService
  def self.stats
    Request.order(hits: :desc).first
  end
end
