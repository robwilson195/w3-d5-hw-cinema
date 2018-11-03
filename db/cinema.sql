DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS customers;

CREATE TABLE films (
  id SERIAL4 PRIMARY KEY,
  title TEXT,
  price INT
);

CREATE TABLE customers (
  id SERIAL4 PRIMARY KEY,
  name TEXT,
  funds INT
);

-- CREATE TABLE screenings (
--   id SERIAL4 PRIMARY KEY,
--   film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
--   film_title TEXT REFERENCES films(title) ON DELETE CASCADE,
--   show_time TEXT
);

CREATE TABLE tickets (
  id SERIAL4 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT4 REFERENCES films(id) ON DELETE CASCADE,
  -- screening_id INT4 REFERENCES screenings(id) ON DELETE CASCADE
);
