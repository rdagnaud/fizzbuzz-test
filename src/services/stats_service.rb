class StatsService
  def self.stats
    Request.order(hits: :desc).first&.as_json(except: [:created_at, :updated_at])
  end
end
