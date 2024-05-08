class Video < ApplicationRecord
  belongs_to :course, optional: true

  include RoadToElDuration::Calculations

  serialize :length, coder: RoadToElDuration::DurationCoder
  updates_duration_of :course, column: :run_time
end
