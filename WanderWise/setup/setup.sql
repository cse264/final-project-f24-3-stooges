DROP DATABASE IF EXISTS wanderwise;

CREATE DATABASE wanderwise;
\c wanderwise;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,               -- Unique identifier for each user
    username VARCHAR(50) NOT NULL UNIQUE,    -- User's login username
    email VARCHAR(100) NOT NULL UNIQUE,      -- User's email address
    password_hash TEXT NOT NULL,             -- Hashed password for security
    role VARCHAR(20) NOT NULL DEFAULT 'Free',-- User role: Free, Paid, Admin
    subscription_start DATE,                 -- Start date for paid users
    subscription_end DATE,                   -- End date for paid users
);

CREATE TABLE itineraries (
    itinerary_id SERIAL PRIMARY KEY,          
    user_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE, 
    title VARCHAR(255) NOT NULL,             
    description TEXT,                        
    is_public BOOLEAN DEFAULT TRUE,          
    stops_count INT DEFAULT 0,                -- New: Count of stops
    start_location_name VARCHAR(255),         -- Optional: Start stop
    start_latitude DECIMAL(9, 6),             
    start_longitude DECIMAL(9, 6),            
    end_location_name VARCHAR(255),           -- Optional: End stop
    end_latitude DECIMAL(9, 6),               
    end_longitude DECIMAL(9, 6),              
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);


CREATE TABLE stops (
    stop_id SERIAL PRIMARY KEY,              
    itinerary_id INT NOT NULL REFERENCES itineraries(itinerary_id) ON DELETE CASCADE, 
    stop_order INT NOT NULL,                 
    location_name VARCHAR(255) NOT NULL,     
    latitude DECIMAL(9, 6) NOT NULL,         
    longitude DECIMAL(9, 6) NOT NULL,        
    arrival_time TIMESTAMP,                  
    departure_time TIMESTAMP,                
    notes TEXT,                              
    weather_forecast JSONB,                  
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
);





