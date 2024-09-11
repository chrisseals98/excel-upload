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
insert into Samples (SAMPLE_NUMBER, LOC_ID, SAMPLE_DEPTH, SAMPLE_TIME) values ('2023-12-30T05:51:46.000Z14.1', 'APHFB', 14.1, '2023-12-30 00:51:46');

create table Results (
	LOC_ID VARCHAR(50),
	SAMPLE_NUMBER VARCHAR(50),
	VALUE DECIMAL(5,2),
	RESULT_NAME VARCHAR(50),
	PRIMARY KEY (SAMPLE_NUMBER, LOC_ID, RESULT_NAME),
	CONSTRAINT FK_SampleResult FOREIGN KEY (SAMPLE_NUMBER, LOC_ID) REFERENCES Samples(SAMPLE_NUMBER, LOC_ID),
	CONSTRAINT FK_LocationResult FOREIGN KEY (LOC_ID) REFERENCES Locations(LOC_ID)
);
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-12-30T05:51:46.000Z14.1', 174.31, 'temp');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-12-30T05:51:46.000Z14.1', 36.75, 'ph');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-12-30T05:51:46.000Z14.1', 11.46, 'spCond');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-12-30T05:51:46.000Z14.1', 151.69, 'doPercent');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-12-30T05:51:46.000Z14.1', 33.41, 'do');
insert into Results (LOC_ID, SAMPLE_NUMBER, VALUE, RESULT_NAME) values ('APHFB', '2023-12-30T05:51:46.000Z14.1', 87.94, 'secchi');

commit;

