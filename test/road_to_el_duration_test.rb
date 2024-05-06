require "test_helper"

class RoadToElDurationTest < ActiveSupport::TestCase
  setup do
    # @episode = episodes(:one)
    # @series = series(:ruby_strings)
    @episode_one = Episode.create(name: "Episode 1", duration: 10.minutes)
    @series_one = Series.create(name: "Series 1")
  end

  test "it has a version number" do
    assert RoadToElDuration::VERSION
  end

  test "it updates the parent record duration_column when child records are added or removed" do
    @episode_one.update(series: @series_one)
    assert_equal 10.minutes, @series_one.reload.duration

    @episode_one.update(series: nil)
    assert_equal 0.minutes, @series_one.reload.duration
  end

  test "when moving a child record from one parent to another both parents are updated accordingly" do
    @episode_one.update(series: @series_one)

    @series_two = Series.create(name: "Series 2")

    @episode_one.update(series: @series_two)
    assert_equal 0.minutes, @series_one.reload.duration
    assert_equal 10.minutes, @series_two.reload.duration
  end

  test "the duration_coder is used to serialize and deserialize the duration column" do
    episode = Episode.create(name: "Episode 1", duration: 10.minutes)
    series = Series.create(name: "Series 1")
    episode.update(series: series)

    assert_instance_of ActiveSupport::Duration, series.reload.duration
  end
end
