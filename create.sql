create table department (
    id SERIAL PRIMARY KEY ,
    name varchar(256) ,
    balance money not null
);

create table ambulance (
    id SERIAL PRIMARY KEY ,
    availability bool not null      -- true - available, false - not available
);

create table account (
    id SERIAL PRIMARY KEY ,
    login varchar(32) not null UNIQUE,
    password varchar(32) not null
);

create table "user" (
    ssn SERIAL PRIMARY KEY ,
    first_name varchar(256) not null,
    last_name varchar(256) not null,
    gender char(1) not null,            -- 0 - MALE, 1 - FEMALE
    role varchar(256) not null,
    works_for_department_id int REFERENCES department(id),
    works_in_ambulance_id int REFERENCES ambulance(id),
    address varchar(256) ,
    phone int ,
    age int not null,
    account_id int not null UNIQUE REFERENCES account(id)
);


create table notification (
    id SERIAL PRIMARY KEY ,
    created_by_user_ssn int not null REFERENCES "user"(ssn),
    message varchar(500) not null
);

create table is_for (
    for_user_ssn int not null REFERENCES  "user"(ssn),
    is_notification_id int not null REFERENCES notification(id)
);

create table report (
    id SERIAL PRIMARY KEY ,
    created_by_user_ssn int not null REFERENCES "user"(ssn),
    description varchar(10000) not null
);

create table patient (
    id SERIAL PRIMARY KEY ,
    user_ssn int not null UNIQUE REFERENCES "user"(ssn) ,
    history varchar(1000000) not null ,
    registration_date date not null
);

create table medical_report (
    id SERIAL PRIMARY KEY ,
    assigned_by_user_ssn int not null REFERENCES "user" (ssn),
    linked_to_patient_id int not null REFERENCES patient (id),
    content varchar(10000) not null
);

create table appointment (
    id SERIAL PRIMARY KEY ,
    appointed_by_user_ssn int not null REFERENCES "user" (ssn),
    for_patient_id int not null REFERENCES patient (id),
    date timestamp not null
);

create table medical_certificate (
    id SERIAL PRIMARY KEY ,
    by_user_ssn int not null REFERENCES "user" (ssn),
    for_patient_id int not null REFERENCES patient (id),
    description varchar (1000) not null
);

create table invoice (
    id SERIAL PRIMARY KEY ,
    by_user_ssn int not null REFERENCES "user" (ssn),
    to_patient_id int not null REFERENCES patient (id),
    balance_due money not null ,
    reason varchar(1000) not null
);

create table request (
    id SERIAL PRIMARY KEY ,
    description varchar(1000) not null,
    completed bool not null     -- true - completed, false - not completed
);

create table approved_request (
    request_id  int not null REFERENCES request(id),
    user_ssn int not null REFERENCES "user" (ssn)
);

create table required_request (
    request_id  int not null REFERENCES request(id),
    user_ssn int not null REFERENCES "user" (ssn)
);

create table chat (
    id SERIAL PRIMARY KEY ,
    name varchar(100) not null
);

create table message (
    id SERIAL PRIMARY KEY ,
    in_chat_id int not null REFERENCES chat (id),
    from_user_ssn int not null REFERENCES "user" (ssn),
    text varchar(5000) not null
);

create table member_of_chat (
    member_user_ssn int not null REFERENCES "user" (ssn) ,
    of_chat_id int null REFERENCES chat (id)
);

create table web_page (
    id SERIAL PRIMARY KEY ,
    maintained_by_user_ssn int not null REFERENCES "user" (ssn)
);

create table "content" (
    id SERIAL PRIMARY KEY ,
    in_page_id int not null REFERENCES page_of_hospital_information_portal(id),
    text varchar (1000000) not null
);

create table salary (
    id SERIAL PRIMARY KEY ,
    amount int not null,
    assigned_to_user_ssn int not null UNIQUE REFERENCES "user" (ssn)
);

create table medicament (
    serial_number int PRIMARY KEY ,
    mpid varchar(32) not null,
    name varchar(256) not null,
    belongs_to_department_id int not null REFERENCES department(id)
);

create table supply (
    serial_number int PRIMARY KEY ,
    name varchar(256) not null,
    belongs_to_department_id int not null REFERENCES department(id)
);


INSERT INTO department VALUES (1, 'General Surgery', 1000000);
INSERT INTO department VALUES (2, 'Managers', 20000);
INSERT INTO ambulance VALUES (1, true);
INSERT INTO account VALUES (1, 'i_am_alfiya', 'my_password');
INSERT INTO account VALUES (2, 'i_am_mike', '11223344');
INSERT INTO account VALUES (3, 'i_am_jam', '1234567890');
INSERT INTO "user" VALUES (1, 'Alfiya', 'Musabekova', 1, 'patient', null, null, 'Universitetskaya 1', 89961211204, 18, 1);
INSERT INTO "user" VALUES (2, 'Mike', 'Kuskov', 0, 'doctor', 1, 1, 'Sadovaya 15a', 87778889900, 28, 2);
INSERT INTO "user" VALUES (3, 'Jameel', 'Mukha', 0, 'manager', 2, null, 'Luiz Street 12', 85552220011, 35, 3);
INSERT INTO notification VALUES (1, 2, 'I need more collegues');
INSERT INTO is_for VALUES (3, 1);
INSERT INTO report VALUES (1, 3, '5000 for advertising to find new doctors');
INSERT INTO patient VALUES (1, 1, 'was bitten by crocodile', '12.03.2017');
INSERT INTO medical_report VALUES (1, 2, 1, 'paracetamol 2 times every day during one week');
INSERT INTO appointment VALUES (1, 2, 1, '15.03.2017 15:30:00');
INSERT INTO medical_certificate VALUES (1, 2, 1, '2 weeks free from job');
INSERT INTO invoice VALUES (1, 2, 1, '1000', 'visit to doctor + paracetamol');
INSERT INTO request VALUES (1, 'I need paracetamol', false);
INSERT INTO required_request VALUES (1, 2);
INSERT INTO approved_request VALUES (1, 3);
UPDATE request SET completed = true;
INSERT INTO chat VALUES (1, 'Mike+Jameel=love forever');
INSERT INTO message VALUES (1, 1, 2, 'I love you my darling');
INSERT INTO member_of_chat VALUES (2, 1);
INSERT INTO member_of_chat VALUES (3, 1);
INSERT INTO web_page VALUES (1, 3);
INSERT INTO content VALUES (1, 1, 'This first draft of hospital`s website');
INSERT INTO salary VALUES (1, 50000, 2);
INSERT INTO salary VALUES (2, 50000, 3);
INSERT INTO medicament VALUES (1, '001122', 'paracetomol', 1);
INSERT INTO supply VALUES  (1, 'table', 2);