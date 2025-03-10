CREATE TABLE passengers (
	id	BIGINT PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	date_of_birth DATE,
	country_of_citizenship VARCHAR(50),
	country_of_residence VARCHAR(50),
	passport_number VARCHAR(50),
	created_at DATETIME,
	updated_at DATETIME
)

CREATE TABLE security_check (
	id BIGINT PRIMARY KEY,
	check_result VARCHAR(20),
	comments VARCHAR(7000),
	created_at DATETIME,
	updated_at DATETIME,
	passenger_id BIGINT, 
		CONSTRAINT FK_sec_passenger_id FOREIGN KEY (passenger_id)
		REFERENCES passengers(id)
)

CREATE TABLE booking (
	bookingid BIGINT PRIMARY KEY,
	flight_id BIGINT,
	status VARCHAR(20),
	booking_platform VARCHAR(20),
	created_at DATETIME,
	updated_at DATETIME,
	passenger_id BIGINT,
		CONSTRAINT FK_book_passenger_id FOREIGN KEY (passenger_id)
		REFERENCES passengers(id)
)

CREATE TABLE baggage_check (
	id BIGINT PRIMARY KEY,
	check_result VARCHAR(50),
	created_at DATETIME,
	updated_at	DATETIME,
	booking_id BIGINT,
		CONSTRAINT FK_bag_check_booking_id FOREIGN KEY (booking_id)
		REFERENCES booking(bookingid),
	passenger_id BIGINT,
		CONSTRAINT FK_bag_check_passenger_id FOREIGN KEY (passenger_id)
		REFERENCES passengers(id)
)

CREATE TABLE no_fly_list (
	id	BIGINT PRIMARY KEY,
	active_from	DATE,
	active_to DATE,
	no_fly_reason VARCHAR(255),
	created_at DATETIME,
	updated_at DATETIME,
	psngr_id BIGINT,
		CONSTRAINT FK_noflylist_passenger_id FOREIGN KEY (psngr_id)
		REFERENCES passengers(id)
)

CREATE TABLE baggage (
	id BIGINT PRIMARY KEY,
	weight_in_kg DECIMAL(4,2),
	created_date DATETIME,
	updated_date DATETIME,
	booking_id BIGINT,
		CONSTRAINT FK_bag_booking_id FOREIGN KEY (booking_id)
		REFERENCES booking(bookingid)
)

CREATE TABLE boarding_pass (
	id BIGINT PRIMARY KEY,
	qr_code VARCHAR(7000),
	created_at DATETIME,
	updated_at DATETIME,
	booking_id BIGINT,
		CONSTRAINT FK_board_pass_booking_id FOREIGN KEY (booking_id)
		REFERENCES booking(bookingid)
)

CREATE TABLE airline (
	id BIGINT PRIMARY KEY,
	airline_code VARCHAR(20),
	airline_name VARCHAR(50),
	airline_country VARCHAR(50),
	created_at DATETIME,
	updated_at DATETIME
)

CREATE TABLE airport (
	id BIGINT PRIMARY KEY,
	airport_name VARCHAR(50),
	country VARCHAR(50),
	state VARCHAR(50),
	city VARCHAR(50),
	created_at DATETIME,
	updated_at DATETIME
)

CREATE TABLE flights (
	flight_id BIGINT PRIMARY KEY,
	departing_gate VARCHAR(20),
	arriving_gate VARCHAR(20),
	created_at DATETIME,
	updated_at DATETIME,
	airline_id BIGINT,
		CONSTRAINT FK_flights_airline_id FOREIGN KEY (airline_id)
		REFERENCES airport(id),
	departing_airport_id BIGINT,
		CONSTRAINT FK_flights_dep_airline_id FOREIGN KEY (departing_airport_id)
		REFERENCES airport(id),
	arriving_airport_id BIGINT,
		CONSTRAINT FK_flights_arr_airline_id FOREIGN KEY (arriving_airport_id)
		REFERENCES airline(id)
)

CREATE TABLE flight_manifest (
	id BIGINT PRIMARY KEY,
	created_at DATETIME,
	updated_at DATETIME,
	booking_id BIGINT,
		CONSTRAINT FK_manifest_booking_id FOREIGN KEY (booking_id)
		REFERENCES booking(bookingid),
	flight_id BIGINT,
		CONSTRAINT FK_manifest_flight_id FOREIGN KEY (flight_id)
		REFERENCES flights(flight_id)
)