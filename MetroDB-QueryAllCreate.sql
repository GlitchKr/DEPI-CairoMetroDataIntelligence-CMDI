-- Create new database
CREATE DATABASE MetroDB;
GO

USE MetroDB;
GO

-- ==========================
-- Table: Station
-- ==========================
CREATE TABLE Station (
    station_id INT IDENTITY(1,1) NOT NULL,
    station_name NVARCHAR(50) NOT NULL,
    line_id NVARCHAR(50) NOT NULL,
    line_position INT NOT NULL,
    latitude FLOAT NOT NULL,
    longitude FLOAT NOT NULL,
    passenger_base INT NOT NULL,
    is_business_area BIT NOT NULL,
    popularity_level NVARCHAR(50) NOT NULL,
    is_transfer BIT NOT NULL,
    CONSTRAINT PK_Station PRIMARY KEY CLUSTERED (station_id ASC)
);
GO

-- ==========================
-- Table: Time
-- ==========================
CREATE TABLE Time (
    time_id INT IDENTITY(1,1) NOT NULL,
    datetime DATETIME2(7) NOT NULL,
    date DATE NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    day_of_week NVARCHAR(50) NOT NULL,
    hour INT NOT NULL,
    is_weekend BIT NOT NULL,
    is_friday BIT NOT NULL,
    period_of_day NVARCHAR(50) NOT NULL,
    special_event NVARCHAR(50) NOT NULL,
    day_type NVARCHAR(50) NOT NULL,
    season NVARCHAR(50) NOT NULL,
    is_ramadan INT NOT NULL,
    is_holiday BIT NOT NULL,
    is_school_holiday INT NOT NULL,
    CONSTRAINT PK_Time PRIMARY KEY CLUSTERED (time_id ASC)
);
GO

-- ==========================
-- Table: Passenger
-- ==========================
CREATE TABLE Passenger (
    passenger_id INT IDENTITY(1,1) NOT NULL,
    station_id INT NOT NULL,
    time_id INT NOT NULL,
    date DATE NOT NULL,
    passenger_count INT NOT NULL,
    period_of_day NVARCHAR(50) NOT NULL,
    day_type NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Passenger PRIMARY KEY CLUSTERED (passenger_id ASC),
    CONSTRAINT FK_Passenger_Station FOREIGN KEY (station_id) REFERENCES Station(station_id),
    CONSTRAINT FK_Passenger_Time FOREIGN KEY (time_id) REFERENCES Time(time_id)
);
GO

-- ==========================
-- Table: Service
-- ==========================
CREATE TABLE Service (
    service_id INT IDENTITY(1,1) NOT NULL,
    station_id INT NOT NULL,
    time_id INT NOT NULL,
    date DATE NOT NULL,
    event_type NVARCHAR(50) NOT NULL,
    event_duration_min INT NOT NULL,
    reason NVARCHAR(50) NOT NULL,
    severity NVARCHAR(50) NOT NULL,
    month INT NOT NULL,
    period_of_day NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Service PRIMARY KEY CLUSTERED (service_id ASC),
    CONSTRAINT FK_Service_Station FOREIGN KEY (station_id) REFERENCES Station(station_id),
    CONSTRAINT FK_Service_Time FOREIGN KEY (time_id) REFERENCES Time(time_id)
);
GO

-- ==========================
-- Table: Trips
-- ==========================
CREATE TABLE Trips (
    trips_id INT IDENTITY(1,1) NOT NULL,
    origin_station_id INT NOT NULL,
    destination_station_id INT NOT NULL,
    time_id INT NOT NULL,
    date DATE NOT NULL,
    stations_traveled INT NOT NULL,
    ticket_price_egp DECIMAL(8,2) NOT NULL,
    passenger_count INT NOT NULL,
    total_revenue_egp DECIMAL(8,2) NOT NULL,
    trip_type NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Trips PRIMARY KEY CLUSTERED (trips_id ASC),
    CONSTRAINT FK_Trips_Station1 FOREIGN KEY (origin_station_id) REFERENCES Station(station_id),
    CONSTRAINT FK_Trips_Station2 FOREIGN KEY (destination_station_id) REFERENCES Station(station_id),
    CONSTRAINT FK_Trips_Time FOREIGN KEY (time_id) REFERENCES Time(time_id)
);
GO

-- ==========================
-- Table: Weather
-- ==========================
CREATE TABLE Weather (
    time_id INT NOT NULL,
    date DATE NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    hour INT NOT NULL,
    temp_celsius DECIMAL(6,2) NOT NULL,
    weather_desc NVARCHAR(50) NOT NULL,
    CONSTRAINT FK_Weather_Time FOREIGN KEY (time_id) REFERENCES Time(time_id)
);
GO
