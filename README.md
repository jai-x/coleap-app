# coleap-app

#### about

This is a minimal API-only Ruby on Rails application which serves only the
endpoint `/cars`.

#### requirements

A working Ruby environment with `ruby`, `bundle`, and `gem` present in the path.
Tested only with Ruby 3.0.2 but is likely to work with Ruby >3

#### installation

```shell
# install gem dependencies
$ bundle install

# ensure Rails migrations are run
$ rails db:migrate

# ensure seed data is added to the database
$ rails db:seed
```

#### testing

```shell
$ rspec
```

#### running the app

```shell
$ rails server
```

#### model, database, and schema

The main model is the `Cars` model which is backed by a single table in the
schema. The schema for this table can be found in the `db/schema.rb` but is
paster here for convenience:
```ruby
create_table "cars", force: :cascade do |t|
  t.string "model_id"
  t.string "make"
  t.string "model"
  t.integer "range_num"
  t.string "range_unit"
  t.string "colors"
  t.decimal "price_num"
  t.string "price_currency"
  t.string "photo_url"
  t.datetime "created_at", precision: 6, null: false
  t.datetime "updated_at", precision: 6, null: false
  t.index ["make"], name: "index_cars_on_make"
  t.index ["model_id"], name: "index_cars_on_model_id"
end
```

Most fields are backed by simple nullable string types.

The `range` and `price` fields from the original JSON schema have been flattened
and stored in the main table. This also makes it easier to sort by these fields.

`price_num` is stored as `decimal` type since it is a non-integer that
represents monetary value and using a `float` type will introduce rounding
errors if calculations need to be done on this value.

The `id` field from the JSON schema has become `model_id` to not clash with `id`
in the schema as that is reserved for the primary key. I could have made the
primary key accept the string but I did not to keep things simple.

The `colors` fields is stored as as whitespace separated string of colors.
Ideally it would be better to use an array datatype but the default SQLite
database does not support this as a column type. Alternatively `Colour` could be
normalised into its own table and referenced by the `Cars` table but I did not
do that due to time an d to keep things simple.

#### the `/cars` endpoint

When the app is running, you can access the `/cars` endpoint to receive the
expected JSON data.

Example requests:
```shell
$ curl http://localhost:3000/cars # see all cars
$ curl http://localhost:3000/cars?make=Tesla # see only Tesla make cars
$ curl http://localhost:3000/cars?make=Tesla&order_by=range # see only Tesla make cars ordered by range
$ curl http://localhost:3000/cars/<model_id> # see a single car record by model id
```

The data stored in the table is converted to the expected JSON schema at runtime
on data retrieval. This is done by overriding the `Cars` model `#as_json` method
and a simple unit test added to verify its correctness. Ideally it may be useful
to use a serializer class for this but I did not due to time and for simplicity.

Since the fields `price` and `range` were modified for the scheme, the
controller will try and use the appropriate database fields for when these
fields are request to order by.
