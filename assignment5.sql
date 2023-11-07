create table branch(
bid int,
brname char(30),
brcity char(10)
);

create table customer(
cno int,
cname char(20),
caddr char(35),
city char(20)
);

create table loan_application(
lno int,
lamtrequired_money double,
lamtapproved_money double,
l_date date
);

create table ternary(
bid int,
cno int,
lno int
);

-- Inserting data into BRANCH table
INSERT INTO BRANCH  VALUES (1, 'Branch1', 'Aundh');
INSERT INTO BRANCH  VALUES (2, 'Branch2', 'Deccan');
INSERT INTO BRANCH VALUES (3, 'Branch3', 'M.G.ROAD');

-- Inserting data into CUSTOMER table
INSERT INTO CUSTOMER  VALUES (1, 'XXX', 'Address1', 'City1');
INSERT INTO CUSTOMER  VALUES (2, 'YYY', 'Address2', 'City2');
INSERT INTO CUSTOMER  VALUES (3, 'ZZZ', 'Address3', 'City3');

-- Inserting data into LOAN_APPLICATION table
INSERT INTO LOAN_APPLICATION  VALUES (1, 5000.00, 4000.00, '2023-01-01');
INSERT INTO LOAN_APPLICATION  VALUES (2, 6000.00, 5500.00, '2023-09-01');
INSERT INTO LOAN_APPLICATION  VALUES (3, 7000.00, 7000.00, '2023-09-11');

-- Inserting data into TERNARY table
INSERT INTO TERNARY (BID, CNO, LNO) VALUES (1, 1, 1);
INSERT INTO TERNARY (BID, CNO, LNO) VALUES (2, 2, 2);
INSERT INTO TERNARY (BID, CNO, LNO) VALUES (3, 3, 3);


-- 1
select cname from customer c join ternary t on c.cno = t.cno  join branch b on b.bid = t.bid where t.bid = b.bid and  c.cno = t.cno and b.brname = "aundh";

SELECT CNAME 
FROM CUSTOMER 
WHERE CNO IN (
    SELECT CNO 
    FROM TERNARY 
    WHERE BID IN (
        SELECT BID 
        FROM BRANCH 
        WHERE BRCITY = 'Aundh'
    )
);


SELECT CNAME 
FROM CUSTOMER 
WHERE CNO IN (
    SELECT CNO 
    FROM TERNARY 
    WHERE LNO IN (
        SELECT LNO 
        FROM  LOAN_APPLICATION 
        WHERE lamtrequired_money > lamtapproved_money
    )
);


SELECT LNO 
FROM  LOAN_APPLICATION 
WHERE lamtrequired_money < lamtapproved_money;
