-- 1) Create DB
CREATE DATABASE MetroDB;
GO

USE MetroDB;
GO

-- 2) dim_time
CREATE TABLE dbo.dim_time (
  time_id BIGINT NOT NULL PRIMARY KEY,
  datetime_ts DATETIME NOT NULL,
  date_day DATE NOT NULL,
  year INT,
  month INT,
  day INT,
  day_of_week VARCHAR(20),
  hour INT,
  is_weekend BIT,
  is_friday BIT,
  period_of_day VARCHAR(50),
  day_type VARCHAR(50),
  season VARCHAR(50),
  is_ramadan BIT,
  is_holiday BIT,
  is_school_holiday BIT
);
CREATE INDEX IX_dim_time_date ON dbo.dim_time(date_day);
CREATE INDEX IX_dim_time_month ON dbo.dim_time(month);
GO

-- 3) dim_station
CREATE TABLE dbo.dim_station (
  station_id INT NOT NULL PRIMARY KEY,
  station_name VARCHAR(200) NOT NULL,
  line_id VARCHAR(100) NULL,
  line_position INT,
  latitude DECIMAL(9,6) NULL,
  longitude DECIMAL(9,6) NULL,
  passenger_base BIGINT NULL,
  is_business_area BIT DEFAULT 0,
  popularity_level VARCHAR(50) NULL,
  is_transfer BIT DEFAULT 0
);
CREATE INDEX IX_dim_station_line ON dbo.dim_station(line_id);
CREATE INDEX IX_dim_station_name ON dbo.dim_station(station_name);
GO

-- 4) dim_pricing
CREATE TABLE dbo.dim_pricing (
  zone_id INT NOT NULL PRIMARY KEY,
  station_range VARCHAR(100),
  price_egp DECIMAL(10,2),
  pricing_date DATE
);
GO

-- 5) dim_weather
CREATE TABLE dbo.dim_weather (
  time_id BIGINT NOT NULL PRIMARY KEY,
  date_day DATE,
  month INT,
  day INT,
  hour INT,
  temp_celsius DECIMAL(5,2),
  weather_desc VARCHAR(100),
  CONSTRAINT FK_dim_weather_time FOREIGN KEY(time_id) REFERENCES dbo.dim_time(time_id)
);
CREATE INDEX IX_dim_weather_temp ON dbo.dim_weather(temp_celsius);
GO

-- 6) fact_passenger_counts
CREATE TABLE dbo.fact_passenger_counts (
  id BIGINT NOT NULL PRIMARY KEY,
  station_id INT NOT NULL,
  time_id BIGINT NOT NULL,
  date_day DATE,
  passenger_count INT,
  period_of_day VARCHAR(50),
  day_type VARCHAR(50),
  created_at DATETIME DEFAULT GETDATE(),
  CONSTRAINT FK_passenger_station FOREIGN KEY(station_id) REFERENCES dbo.dim_station(station_id),
  CONSTRAINT FK_passenger_time FOREIGN KEY(time_id) REFERENCES dbo.dim_time(time_id)
);
CREATE INDEX IX_passenger_time ON dbo.fact_passenger_counts(time_id);
CREATE INDEX IX_passenger_station_time ON dbo.fact_passenger_counts(station_id, time_id);
GO

-- 7) fact_od_trips
CREATE TABLE dbo.fact_od_trips (
  id BIGINT NOT NULL PRIMARY KEY,
  origin_station_id INT NOT NULL,
  destination_station_id INT NOT NULL,
  time_id BIGINT NOT NULL,
  date_day DATE,
  stations_traveled INT,
  zone_id INT NOT NULL,
  passenger_count INT,
  total_revenue_egp DECIMAL(14,2),
  trip_type VARCHAR(50),
  created_at DATETIME DEFAULT GETDATE(),
  CONSTRAINT FK_od_origin_station FOREIGN KEY(origin_station_id) REFERENCES dbo.dim_station(station_id),
  CONSTRAINT FK_od_destination_station FOREIGN KEY(destination_station_id) REFERENCES dbo.dim_station(station_id),
  CONSTRAINT FK_od_time FOREIGN KEY(time_id) REFERENCES dbo.dim_time(time_id),
  CONSTRAINT FK_od_pricing FOREIGN KEY(zone_id) REFERENCES dbo.dim_pricing(zone_id)
  -- CONSTRAINT CHK_od_origin_dest CHECK (origin_station_id <> destination_station_id)
);
CREATE INDEX IX_od_time ON dbo.fact_od_trips(time_id);
CREATE INDEX IX_od_origin_dest ON dbo.fact_od_trips(origin_station_id, destination_station_id);
CREATE INDEX IX_od_zone ON dbo.fact_od_trips(zone_id);
GO

-- 8) fact_service_events
CREATE TABLE dbo.fact_service_events (
  id BIGINT NOT NULL PRIMARY KEY,
  station_id INT NOT NULL,
  time_id BIGINT NOT NULL,
  date_day DATE,
  event_type VARCHAR(100),
  event_duration_min INT,
  reason VARCHAR(200),               
  severity VARCHAR(50),
  month INT,
  period_of_day VARCHAR(50),
  created_at DATETIME DEFAULT GETDATE(),
  CONSTRAINT FK_service_station FOREIGN KEY(station_id) REFERENCES dbo.dim_station(station_id),
  CONSTRAINT FK_service_time FOREIGN KEY(time_id) REFERENCES dbo.dim_time(time_id)
);
CREATE INDEX IX_service_time ON dbo.fact_service_events(time_id);
CREATE INDEX IX_service_station ON dbo.fact_service_events(station_id);
GO