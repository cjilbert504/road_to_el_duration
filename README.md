# RoadToElDuration
Like a counter cache but for length in time attributes.

If the duration or length in time of an object needs to be calculated from the
duration or length in time of associated records this gem helps you achieve
that easily.

It handles automatic recalculations as child records are added,
removed, and transferred to other parent records.

It also comes with its own coder class that handles serializing the duration
columns to and from instances of the ActiveSupport::Duration class and the Ruby
Integer class. This is an opt-in feature so you don't have to use it if you
don't want.

## Usage
```ruby
class Episode < ApplicationRecord
  include RoadToElDuration::Calculations

  belongs_to :series

  serialize :duration, coder: RoadToElDuration::DurationCoder
  updates_duration_of :series
end


class Series < ApplicationRecord
  include RoadToElDuration::Calculations

  has_many :episodes

  serialize :duration, coder: RoadToElDuration::DurationCoder
  calculates_duration_from :episodes
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "road_to_el_duration"
```

And then execute:
```bash
$ bundle
```
## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
