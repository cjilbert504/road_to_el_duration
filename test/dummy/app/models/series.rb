class Series < ApplicationRecord
  include RoadToElDuration::Calculations

  has_many :episodes

  serialize :duration, coder: RoadToElDuration::DurationCoder
  calculates_duration_from :episodes
end
