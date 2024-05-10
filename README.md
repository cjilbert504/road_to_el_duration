# RoadToElDuration
Like a counter cache but for length in time attributes.

If the duration or length in time of an object needs to be calculated from the
duration or length in time of associated records this gem helps you achieve
that easily.

It handles automatic recalculations as child records are added,
removed, and transferred to other parent records.

It also comes with its own coder class that handles serializing and
deserializing the duration columns to and from instances of the
ActiveSupport::Duration class and the Ruby Integer class. This is an opt-in
feature so you don't have to use it if you don't want.

## Usage

The gem provides two modules that you can include in your models. One named
`RoadToElDuration::Calculations` which provides the `calculates_duration_from`
and `updates_duration_of` methods and the other named `RoadToElDuration::Coder`
which provides the `coder` class that is used to serialize and deserialize the
duration columns.

Let's look at a simple example.

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

Here we have two models, `Episode` and `Series`. The `Series` model has its
`duration` column serialized with the `RoadToElDuration::DurationCoder` coder and
the `Episode` model has its `duration` column serialized with the
`RoadToElDuration::DurationCoder` coder as well. The `Series` model also
has its `duration` attribute populated from the sum of episode `duration` that
belongs to a series.

This setup assumes that both the `Episode` and `Series` models have an integer
column on their tables named `duration` that is used to store the duration in
seconds.

If your columns are named differently you can specify the column names in both
the `calculates_duration_from` and `updates_duration_of` methods by passing
the column name as a symbol or a string as the `column` keyword argument.

For example:
```ruby
class Episode < ApplicationRecord
  include RoadToElDuration::Calculations

  belongs_to :series

  serialize :duration, coder: RoadToElDuration::DurationCoder
  updates_duration_of :series, column: :total_length
end


class Series < ApplicationRecord
  include RoadToElDuration::Calculations

  has_many :episodes

  serialize :duration, coder: RoadToElDuration::DurationCoder
  calculates_duration_from :episodes, column: :length
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
If you would like to contribute something, go for it. 👍

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
