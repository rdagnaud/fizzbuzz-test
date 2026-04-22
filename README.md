# FizzBuzz REST API

A REST API implementing the classic FizzBuzz algorithm with configurable parameters. The API accepts custom divisors and replacement strings, making it a generalized FizzBuzz engine. It also tracks request statistics to expose which parameter combination has been called the most.

## Requirements

- Ruby (tested with the versions listed in `Gemfile.lock`)
- Bundler (`gem install bundler`)
- SQLite3

## Installation

1. Clone the repository:

```bash
git clone https://github.com/rdagnaud/fizzbuzz-test.git
cd fizzbuzz-test
```

2. Install dependencies:

```bash
bundle install
```

3. Set up the database:

```bash
bundle exec rake db:create db:migrate
```

## Running the Server

```bash
bundle exec rackup
```

The server starts on `http://localhost:9292` by default.

```bash
bundle exec rackup -p PORT
```

To specify another port.

## API Documentation

### POST /fizzbuzz

Generates a FizzBuzz sequence from 1 to `limit` using the provided parameters.

**Request body (JSON):**

| Parameter | Type    | Description                                        | Constraints          |
|-----------|---------|----------------------------------------------------|----------------------|
| `int1`    | integer | First divisor — multiples are replaced by `str1`   | 1 – 1,000,000        |
| `int2`    | integer | Second divisor — multiples are replaced by `str2`  | 1 – 1,000,000        |
| `limit`   | integer | Upper bound of the sequence (inclusive)            | 1 – 1,000,000        |
| `str1`    | string  | Replacement string for multiples of `int1`         | 1 – 100 characters   |
| `str2`    | string  | Replacement string for multiples of `int2`         | 1 – 100 characters   |

Numbers that are multiples of both `int1` and `int2` are replaced by the concatenation `str1str2`.

**Example — classic FizzBuzz (limit 15):**

```bash
curl -X POST http://localhost:9292/fizzbuzz \
  -H "Content-Type: application/json" \
  -d '{"int1": 3, "int2": 5, "limit": 15, "str1": "fizz", "str2": "buzz"}'
```

```json
["1","2","fizz","4","buzz","fizz","7","8","fizz","buzz","11","fizz","13","14","fizzbuzz"]
```

**Example — custom parameters:**

```bash
curl -X POST http://localhost:9292/fizzbuzz \
  -H "Content-Type: application/json" \
  -d '{"int1": 2, "int2": 10, "limit": 10, "str1": "even", "str2": "tens"}'
```

```json
["1","even","3","even","5","even","7","even","9","eventens"]
```

**Error responses:**

| Status | Condition                                         |
|--------|---------------------------------------------------|
| `400`  | Missing parameter, integer out of range, empty or too-long string |
| `422`  | Database constraint violation                     |
| `500`  | Unexpected server error                           |

```json
{
  "error": "bad_request",
  "message": "Missing keys int1, str2"
}
```

---

### GET /stats

Returns the parameter combination that has been requested the most, along with its hit count.

```bash
curl http://localhost:9292/stats
```

**Response when requests exist (200):**

```json
{
  "int1": 3,
  "int2": 5,
  "limit": 100,
  "str1": "fizz",
  "str2": "buzz",
  "hits": 42
}
```

**Response when no requests have been made (204):** empty body.

## Running Tests

The test suite uses RSpec. The test database is reset automatically before each test.

```bash
bundle exec rspec
```

Run a specific file:

```bash
bundle exec rspec spec/services/fizzbuzz_service_spec.rb
```

## Resetting the Development Database

To clear all data without dropping or re-migrating the database:

```bash
bundle exec ruby tasks/reset_db.rb
```

## Project Structure

```
.
├── app.rb                        # Sinatra application — route definitions
├── config.ru                     # Rack entry point
├── Gemfile                       # Gem dependencies
├── Rakefile                      # Rake tasks (db:migrate, db:create, …)
│
├── config/
│   ├── database.rb               # ActiveRecord connection setup
│   └── loader.rb                 # Bundler + auto-require for src/
│
├── db/
│   ├── migrate/                  # ActiveRecord migrations
│   └── schema.rb                 # Current database schema
│
├── src/
│   ├── errors/
│   │   └── error_handler.rb      # Sinatra error handler (422, 500)
│   ├── models/
│   │   └── request.rb            # ActiveRecord model with validations
│   ├── services/
│   │   ├── fizzbuzz_service.rb   # Core FizzBuzz logic + hit tracking
│   │   └── stats_service.rb      # Most-requested parameters query
│   └── validators/
│       └── fizzbuzz_validator.rb # Input validation before DB/service call
│
├── spec/
│   ├── app_spec.rb               # Integration tests for routes
│   ├── spec_helper.rb            # RSpec config + DB reset before each test
│   ├── errors/                   # ┒
│   ├── models/                   # │
│   ├── services/                 # ├── Unit tests
│   └── validators/               # ┙
│
└── tasks/
    └── reset_db.rb               # Development utility to clear all rows
```

## Environment Variables

| Variable      | Default                  | Description                   |
|---------------|--------------------------|-------------------------------|
| `APP_ENV`     | `development`            | Runtime environment           |
| `DB_ADAPTER`  | `sqlite3`                | ActiveRecord adapter          |
| `DB_NAME`     | `db/development.sqlite3` | Path to the SQLite3 database  |

The test suite sets `APP_ENV=test` automatically, which isolates it to a separate database file (`db/test.sqlite3`).