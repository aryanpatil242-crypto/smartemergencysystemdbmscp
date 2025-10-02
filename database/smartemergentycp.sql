create database dbmscpl;
use dbmscpl;
CREATE TABLE Users ( name VARCHAR(100) PRIMARY KEY,contact VARCHAR(15), role VARCHAR(20)
);
CREATE TABLE Incidents (inc_id INT PRIMARY KEY, type VARCHAR(50), severity VARCHAR(20),
    location VARCHAR(150),reported_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP, status VARCHAR(20),
    reported_by VARCHAR(100),
    FOREIGN KEY (reported_by) REFERENCES Users(name)
);
CREATE TABLE Teams (name VARCHAR(100) PRIMARY KEY,
    type VARCHAR(50),location VARCHAR(100), status VARCHAR(20)
);
CREATE TABLE Dispatch (
dispatch_id INT PRIMARY KEY,inc_name VARCHAR(100),team_name VARCHAR(100),
    dispatch_time TIMESTAMP, resolve_time TIMESTAMP, FOREIGN KEY (inc_name) REFERENCES Incidents(type), FOREIGN KEY (team_name) REFERENCES Teams(name)
);
CREATE TABLE Equipment (eq_id INT PRIMARY KEY,
    team_name VARCHAR(100),eq_type VARCHAR(50),status VARCHAR(20),
    FOREIGN KEY (team_name) REFERENCES Teams(name));
insert into users (name, contact, role) values 
('aryan patil', '9876543210', 'citizen'),
('aadit pandit', '9123456780', 'citizen'),
('emergency operator 1', '9000000001', 'operator'),
('system admin', '9000000002', 'admin');
insert into teams (name, type, location, status) values 
('ambulance', 'ambulance', 'sector 12', 'available'),
('fire truck', 'fire truck', 'sector 8', 'available'),
('police unit', 'police unit', 'sector 10', 'available');
insert into equipment (eq_id, team_name, eq_type, status) values 
(201, 'ambulance', 'stretcher', 'available'),
(202, 'ambulance', 'oxygen kit', 'available'),
(203, 'fire truck', 'water pump', 'in use'),
(204, 'police unit', 'handcuffs', 'available');
insert into incidents (inc_id, type, severity, location, reported_time, status, reported_by) values 
(301, 'accident', 'high', 'sector 11', now(), 'reported', 'aryan patil'),
(302, 'fire', 'medium', 'sector 5', now(), 'reported', 'aadit pandit'),
(303, 'medical emergency', 'high', 'sector 9', now(), 'reported', 'aryan patil');
insert into dispatch (dispatch_id, inc_name, team_name, dispatch_time, resolve_time) values 
(401, 'accident', 'ambulance', now(), null),
(402, 'fire', 'fire truck', now(), null);
