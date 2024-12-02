DROP DATABASE IF EXISTS wanderwise;

CREATE DATABASE wanderwise;
\c wanderwise;

-- Create Users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,                -- Unique identifier for each user
    username VARCHAR(50) NOT NULL UNIQUE,      -- User's login username
    email VARCHAR(100) NOT NULL UNIQUE,        -- User's email address
    password_hash TEXT NOT NULL,               -- Hashed password for security
    role VARCHAR(20) NOT NULL DEFAULT 'Free',  -- User role: Free, Paid, Admin
    subscription_start DATE,                   -- Start date for paid users
    subscription_end DATE,                     -- End date for paid users
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Account creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Account last update timestamp
);

-- Create Itineraries table
CREATE TABLE itineraries (
    itinerary_id SERIAL PRIMARY KEY,           -- Unique identifier for each itinerary
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, -- User who created the itinerary
    title VARCHAR(255) NOT NULL,              -- Title of the itinerary
    description TEXT,                         -- Description of the itinerary
    is_public BOOLEAN DEFAULT TRUE,           -- Visibility: Public or Private
    stops_count INT DEFAULT 0,                -- Count of stops in the itinerary
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Itinerary creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Last update timestamp
);

-- Create Stops table
CREATE TABLE stops (
    stop_id SERIAL PRIMARY KEY,               -- Unique identifier for each stop
    itinerary_id INT NOT NULL REFERENCES itineraries(itinerary_id) ON DELETE CASCADE, -- Associated itinerary
    stop_order INT NOT NULL,                  -- Order of the stop in the itinerary
    location_name VARCHAR(255) NOT NULL,      -- Name of the location (e.g., city, landmark)
    latitude DECIMAL(9, 6) NOT NULL,          -- Latitude for the location
    longitude DECIMAL(9, 6) NOT NULL,         -- Longitude for the location
    arrival_time TIMESTAMP,                   -- Planned arrival time
    departure_time TIMESTAMP,                 -- Planned departure time
    notes TEXT,                               -- Additional notes about the stop
    weather_forecast JSONB,                   -- Weather data fetched from OpenWeather API (optional JSON field)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Stop creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  -- Stop last updated timestamp
);

-- Create a trigger function to update the `updated_at` column
CREATE OR REPLACE FUNCTION update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach triggers to update `updated_at` for each table
CREATE TRIGGER set_updated_at_users
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER set_updated_at_itineraries
BEFORE UPDATE ON itineraries
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();

CREATE TRIGGER set_updated_at_stops
BEFORE UPDATE ON stops
FOR EACH ROW
EXECUTE FUNCTION update_timestamp();
