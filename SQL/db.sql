drop table Results;
drop table Samples;
drop table Locations;
commit;

create table Locations (
	LOC_ID VARCHAR(50),
	STATE VARCHAR(50),
	MAX_DEPTH DECIMAL(4,1),
	PRIMARY KEY (LOC_ID)
);
insert into Locations (LOC_ID, STATE, MAX_DEPTH) values ('BOHFB', 'Iowa', 74.7);
insert into Locations (LOC_ID, STATE, MAX_DEPTH) values ('BOHMRW', 'Pennsylvania', 122.1);
insert into Locations (LOC_ID, STATE, MAX_DEPTH) values ('BOHMRH', 'Washington', 108.4);
insert into Locations (LOC_ID, STATE, MAX_DEPTH) values ('O1HFB', 'Kentucky', 47.9);
insert into Locations (LOC_ID, STATE, MAX_DEPTH) values ('APHFB', 'Pennsylvania', 35.1);
insert into Locations (LOC_ID, STATE, MAX_DEPTH) values ('BRHFB', 'District of Columbia', 72.6);
insert into Locations (LOC_ID, STATE, MAX_DEPTH) values ('NTHMR', 'California', 50.4);
insert into Locations (LOC_ID, STATE, MAX_DEPTH) values ('NTHFB', 'Arizona', 86.2);

create table Samples (
	SAMPLE_NUMBER VARCHAR(50),
	LOC_ID VARCHAR(50),
	SAMPLE_DEPTH DECIMAL(4,1),
	SAMPLE_TIME DATE,
	PRIMARY KEY (SAMPLE_NUMBER, LOC_ID),
	CONSTRAINT FK_LocationSample FOREIGN KEY (LOC_ID) REFERENCES Locations(LOC_ID)
);
insert into Samples (SAMPLE_NUMBER, LOC_ID, SAMPLE_DEPTH, SAMPLE_TIME) values ('2023-10-20T15:44:23Z41.9', 'BOHFB', 41.9, '2023-10-20');
insert into Samples (SAMPLE_NUMBER, LOC_ID, SAMPLE_DEPTH, SAMPLE_TIME) values ('2024-06-27T07:35:43Z71.8', 'BOHMRW', 71.8, '2024-06-27');
insert into Samples (SAMPLE_NUMBER, LOC_ID, SAMPLE_DEPTH, SAMPLE_TIME) values ('2024-03-26T09:41:12Z18.7', 'BOHMRH', 18.7, '2024-03-26');
insert into Samples (SAMPLE_NUMBER, LOC_ID, SAMPLE_DEPTH, SAMPLE_TIME) values ('2024-03-28T21:11:59Z43.9', 'O1HFB', 43.9, '2024-03-28');
insert into Samples (SAMPLE_NUMBER, LOC_ID, SAMPLE_DEPTH, SAMPLE_TIME) values ('2023-10-14T00:44:46Z44.0', 'APHFB', 44, '2023-10-14');
insert into Samples (SAMPLE_NUMBER, LOC_ID, SAMPLE_DEPTH, SAMPLE_TIME) values ('2024-01-28T23:26:08Z11.8', 'BRHFB', 11.8, '2024-01-28');
insert into Samples (SAMPLE_NUMBER, LOC_ID, SAMPLE_DEPTH, SAMPLE_TIME) values ('2024-02-14T17:22:28Z83.0', 'NTHMR', 83, '2024-02-14');
insert into Samples (SAMPLE_NUMBER, LOC_ID, SAMPLE_DEPTH, SAMPLE_TIME) values ('2024-08-25T13:55:25Z97.9', 'NTHFB', 97.9, '2024-08-25');

create table Results (
	LOC_ID VARCHAR(50),
	SAMPLE_NUMBER VARCHAR(50),
	VALUE DECIMAL(5,2),
	RESULT_NAME VARCHAR(50),
	PRIMARY KEY (SAMPLE_NUMBER, LOC_ID, RESULT_NAME),
	CONSTRAINT FK_SampleResult FOREIGN KEY (SAMPLE_NUMBER, LOC_ID) REFERENCES Samples(SAMPLE_NUMBER, LOC_ID),
	CONSTRAINT FK_LocationResult FOREIGN KEY (LOC_ID) REFERENCES Locations(LOC_ID)
);
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHFB', '2023-10-20T15:44:23Z41.9', 76.46, 'temp');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHFB', '2023-10-20T15:44:23Z41.9', 165.91, 'ph');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHFB', '2023-10-20T15:44:23Z41.9', 107.71, 'spCond');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHFB', '2023-10-20T15:44:23Z41.9', 114.07, 'doPercent');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHFB', '2023-10-20T15:44:23Z41.9', 70.74, 'do');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHFB', '2023-10-20T15:44:23Z41.9', 130.42, 'secchi');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRW', '2024-06-27T07:35:43Z71.8', 105.61, 'temp');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRW', '2024-06-27T07:35:43Z71.8', 7.15, 'ph');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRW', '2024-06-27T07:35:43Z71.8', 164.6, 'spCond');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRW', '2024-06-27T07:35:43Z71.8', 58.11, 'doPercent');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRW', '2024-06-27T07:35:43Z71.8', 118.82, 'do');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRW', '2024-06-27T07:35:43Z71.8', 116.16, 'secchi');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRH', '2024-03-26T09:41:12Z18.7', 52.66, 'temp');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRH', '2024-03-26T09:41:12Z18.7', 148.64, 'ph');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRH', '2024-03-26T09:41:12Z18.7', 55.92, 'spCond');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRH', '2024-03-26T09:41:12Z18.7', 130.84, 'doPercent');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRH', '2024-03-26T09:41:12Z18.7', 105.57, 'do');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BOHMRH', '2024-03-26T09:41:12Z18.7', 51.99, 'secchi');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('O1HFB', '2024-03-28T21:11:59Z43.9', 40.83, 'temp');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('O1HFB', '2024-03-28T21:11:59Z43.9', 141.98, 'ph');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('O1HFB', '2024-03-28T21:11:59Z43.9', 28.69, 'spCond');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('O1HFB', '2024-03-28T21:11:59Z43.9', 31.69, 'doPercent');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('O1HFB', '2024-03-28T21:11:59Z43.9', 180.73, 'do');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('O1HFB', '2024-03-28T21:11:59Z43.9', 42.65, 'secchi');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-10-14T00:44:46Z44.0', 37.97, 'temp');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-10-14T00:44:46Z44.0', 162.27, 'ph');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-10-14T00:44:46Z44.0', 182.93, 'spCond');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-10-14T00:44:46Z44.0', 194.44, 'doPercent');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-10-14T00:44:46Z44.0', 121.76, 'do');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-10-14T00:44:46Z44.0', 107.29, 'secchi');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BRHFB', '2024-01-28T23:26:08Z11.8', 65.65, 'temp');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BRHFB', '2024-01-28T23:26:08Z11.8', 108.29, 'ph');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BRHFB', '2024-01-28T23:26:08Z11.8', 15.54, 'spCond');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BRHFB', '2024-01-28T23:26:08Z11.8', 90.49, 'doPercent');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BRHFB', '2024-01-28T23:26:08Z11.8', 92.84, 'do');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('BRHFB', '2024-01-28T23:26:08Z11.8', 99.08, 'secchi');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHMR', '2024-02-14T17:22:28Z83.0', 132.92, 'temp');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHMR', '2024-02-14T17:22:28Z83.0', 95.94, 'ph');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHMR', '2024-02-14T17:22:28Z83.0', 62.26, 'spCond');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHMR', '2024-02-14T17:22:28Z83.0', 139.93, 'doPercent');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHMR', '2024-02-14T17:22:28Z83.0', 120.01, 'do');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHMR', '2024-02-14T17:22:28Z83.0', 55.67, 'secchi');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHFB', '2024-08-25T13:55:25Z97.9', 116.21, 'temp');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHFB', '2024-08-25T13:55:25Z97.9', 151.32, 'ph');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHFB', '2024-08-25T13:55:25Z97.9', 50.33, 'spCond');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHFB', '2024-08-25T13:55:25Z97.9', 15.83, 'doPercent');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHFB', '2024-08-25T13:55:25Z97.9', 153.46, 'do');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('NTHFB', '2024-08-25T13:55:25Z97.9', 35.24, 'secchi');

commit;

