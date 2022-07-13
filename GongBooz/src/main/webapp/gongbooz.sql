------------------------회원가입------------------------------------
--@회원가입 테이블생성
CREATE TABLE GB_MEMBER(
    MEMBERMAIL VARCHAR(50) NOT NULL,
    USERID VARCHAR2(40) NOT NULL,
    USERPASS VARCHAR2(100) NOT NULL,
    USERNAME VARCHAR2(40) NOT NULL,
    REGDATE DATE DEFAULT SYSDATE,
    PRIMARY KEY(USERID)
);


------------------------게시판--------------------------------------
--@게시판 테이블 생성
create table gb_board(
 bno number not null,
 title varchar2(100) not null,
 content clob not null,
 writer varchar2(100) not null,
 regdate date default sysdate,
 primary key(bno),
 HIT NUMBER DEFAULT 0,
 recnt number default 0 not null,
 stored_file_name varchar2(100),
 likecount number default 0 not null
);

--@게시판 시퀀스 생성
CREATE SEQUENCE GB_BOARD_SEQ
START WITH 1
INCREMENT BY 1;

--@게시판 댓글 테이블 생성
create table gb_reply (
    bno number not null,
    rno number not null,
    content varchar2(1000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    primary key(rno),
    CONSTRAINT gb_reply_bno FOREIGN KEY(bno) REFERENCES gb_board(bno) on delete cascade
);

--@게시판 댓글 시퀀스 생성
create sequence gb_reply_seq START WITH 1 MINVALUE 0;

--@게시판 파일 테이블 생성 
CREATE TABLE GB_FILE
(
    FILE_NO NUMBER,                         --파일 번호
    BNO NUMBER NOT NULL,                    --게시판 번호
    ORG_FILE_NAME VARCHAR2(260) NOT NULL,   --원본 파일 이름
    STORED_FILE_NAME VARCHAR2(36) NOT NULL, --변경된 파일 이름
    FILE_SIZE NUMBER,                       --파일 크기
    REGDATE DATE DEFAULT SYSDATE NOT NULL,  --파일등록일
    PRIMARY KEY(FILE_NO)                    --기본키 FILE_NO
);

--@게시판 파일 시퀀스 생성
CREATE SEQUENCE SEQ_GB_FILE_NO
START WITH 1 
INCREMENT BY 1 
NOMAXVALUE NOCACHE;

--@게시판 내용채우기
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, '게시판 테이블 질문입니다.', '내용입니다', 'springQueen');
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, '스프링은 생략이 너무 많아', '어지러워', 'springQueen');
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, '즐거운 개발 생활', '내용무', 'jspking');
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, 'si에서 6개월 정도 일하면 실력 어느정도 늘까요?', '궁금쓰', 'jspking');
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, '초보 비전공자도 si에 적응할 수 있나요?', '내용무', 'helloJava');
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, 'crud는 웹개발의 필수 입니다!', '찐', 'gongboo');
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, '공부는 엉덩이로 하는 것이다!', '진짜루', 'springQueen');
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, '토익도 반영이 되나요?', '??', 'helloJava');
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, '정처기 따신분?', '후기좀 공유요..', 'gongboo');
INSERT INTO GB_BOARD(BNO, TITLE, CONTENT, WRITER)
     VALUES (GB_BOARD_SEQ.NEXTVAL, 'SM, SI, Solution의 차이가 뭔가요?', '아시는 분?', 'gongboo');
COMMIT;
--@게시판 내용 ++ 2~3번 입력
insert into gb_board(bno, title, content, writer,regdate,hit,recnt)
select gb_board_seq.nextval, title, content, writer, regdate, hit, recnt from gb_board;
commit;

--@공지 테이블
create table gz_board(
 gno number not null,
 title varchar2(100) not null,
 content clob not null,
 writer varchar2(100) not null,
 regdate date default sysdate,
 primary key(gno),
 hit number default 0
)

--@공지게시판 시퀀스 생성
CREATE SEQUENCE GZ_BOARD_SEQ
START WITH 1
INCREMENT BY 1;

--@게시판 추천 테이블
create table gb_like(
    bno number not null,
    writer varchar2(100) not null,
    constraint gb_like_bno foreign key(bno) references gb_board(bno) on delete cascade
);

--------------------------------스터디게시판------------------------------------
--@스터디룸 게시판 테이블 생성
create table studyroom1(
    sno number primary key,
    open_id varchar2(40),
    study_member varchar2(200),
    study_name varchar2(50) ,
    study_tag varchar2(30),
    region varchar2(30),
    max_number number(5),
    cur_number number(5) default 1
);

--@스터디룸 시퀀스 생성
CREATE SEQUENCE STUDYROOM_SEQ
START WITH 1
INCREMENT BY 1;
---------------------------------------
create table musicList(
m_name varchar2(10),
m_url varchar2(200)
);

insert into musicList values('rain', './resources/audio/rain.mp3');
insert into musicList values('fire',  './resources/audio/fire.mp3');
insert into musicList values('maemi', './resources/audio/maemi.wav');
insert into musicList values('cafe', './resources/audio/cafe.mp3');

commit;