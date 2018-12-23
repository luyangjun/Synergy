---------------------------------------------------
-- Export file for user KIMS                     --
-- Created by Administrator on 2018/1/3, 9:42:50 --
---------------------------------------------------

spool create_kims_tables.log

DROP TABLE PM_BENCHMARK;
DROP TABLE PM_BENCHMARKDETAIL;
DROP TABLE PM_DAILY_NORM;
DROP TABLE PM_DAILY_NORM_RESULT;
DROP TABLE PM_FUNDBENCHMARK;
DROP TABLE PM_FUNDCUSTOMCLASSIFY;
DROP TABLE PM_GROUP;
DROP TABLE PM_GROUPMEMBER;
DROP TABLE PM_HEDGEFUND_DETAIL_CASH;
DROP TABLE PM_HEDGEFUND_DETAIL_GS;
DROP TABLE PM_HEDGEFUND_DETAIL_QY;
DROP TABLE PM_HEDGEFUND_JGGTC;
DROP TABLE PM_HEDGEFUND_PARAM;
DROP TABLE PM_HEDGEFUND_QY;
DROP TABLE PM_HEDGEFUND_QY_TEMP;
DROP TABLE PM_HEDGEFUND_QY_YIELD;
DROP TABLE PM_HEDGEFUND_SUM;
DROP TABLE PM_HEDGEFUND_SUM_ZCLB;
DROP TABLE PM_HEDGEFUND_TEST_QY;
DROP TABLE PM_HEDGEFUND_TEST_ZCLB;
DROP TABLE PM_HEDGEFUND_ZCLB;
DROP TABLE PM_HEDGEFUND_ZCLB_TEMP;
DROP TABLE PM_INDEX;
DROP TABLE PM_MONETARYFUND;
DROP TABLE PM_MONETARYFUND_DETAIL;
DROP TABLE PM_MONETARYFUND_PARAM;
DROP TABLE PM_MONETARYFUND_RESULT;
DROP TABLE PM_QUOTAINFO;
DROP TABLE PM_QUOTARESULT;

prompt
prompt Creating table PM_BENCHMARK
prompt ===========================
prompt
create table PM_BENCHMARK
(
  benchmarkid   VARCHAR2(32) not null,
  benchmarkname VARCHAR2(256),
  begindate     VARCHAR2(8),
  enddate       VARCHAR2(8),
  runtype       CHAR(1),
  runfred       CHAR(1),
  description   VARCHAR2(256),
  remarks       VARCHAR2(256),
  daynum        CHAR(1),
  default_ben   VARCHAR2(1) default 0 not null,
  create_oper   NUMBER(10),
  create_time   DATE,
  modify_oper   NUMBER(10),
  modify_time   DATE
)
;
alter table PM_BENCHMARK
  add constraint PK_PM_BENCHMARK primary key (BENCHMARKID);

  
prompt
prompt Creating table PM_FUNDRANKRESULT
prompt ===========================
prompt  
create table PM_FUNDRANKRESULT
(
  fundcode   VARCHAR2(32) default '' not null,
  rundate    VARCHAR2(8) default '' not null,
  quotacode  VARCHAR2(32) default '' not null,
  fundrank   VARCHAR2(8) default '' not null,
  remark     VARCHAR2(128) default '',
  updateby   VARCHAR2(64),
  updatetime DATE,
  datasource VARCHAR2(64)
);
comment on table PM_FUNDRANKRESULT
  is '������������';
comment on column PM_FUNDRANKRESULT.fundcode
  is '��ϴ���';
comment on column PM_FUNDRANKRESULT.rundate
  is '��������';
comment on column PM_FUNDRANKRESULT.quotacode
  is 'ָ�����';
comment on column PM_FUNDRANKRESULT.fundrank
  is '���ֵ';
comment on column PM_FUNDRANKRESULT.remark
  is '��ע';
comment on column PM_FUNDRANKRESULT.updateby
  is '������';
comment on column PM_FUNDRANKRESULT.updatetime
  is '����ʱ��';
  comment on column PM_FUNDRANKRESULT.datasource
  is '������Դ';  
alter table PM_FUNDRANKRESULT
  add constraint PK_PM_FUNDRANKRESULT primary key (fundcode,rundate);  
  
prompt
prompt Creating table PM_BENCHMARKDETAIL
prompt =================================
prompt
create table PM_BENCHMARKDETAIL
(
  id          VARCHAR2(32) not null,
  benchmarkid VARCHAR2(32),
  indexid     VARCHAR2(32),
  weight      NUMBER(3,2),
  currency1   VARCHAR2(8),
  currency2   VARCHAR2(8),
  ratesource  NUMBER(2),
  create_oper NUMBER(10),
  create_time DATE,
  modify_oper NUMBER(10),
  modify_time DATE
)
;
alter table PM_BENCHMARKDETAIL
  add constraint PK_PM_BENCHMARKDETAIL primary key (ID);

prompt
prompt Creating table PM_DAILY_NORM
prompt ============================
prompt
create table PM_DAILY_NORM
(
  normcode   VARCHAR2(32) not null,
  normname   VARCHAR2(128) not null,
  normdesc   VARCHAR2(2048),
  remark     VARCHAR2(4000),
  updateby   VARCHAR2(64),
  updatetime DATE
)
;
alter table PM_DAILY_NORM
  add constraint PK_PM_DAILY_NORM primary key (NORMCODE);

prompt
prompt Creating table PM_DAILY_NORM_RESULT
prompt ===================================
prompt
create table PM_DAILY_NORM_RESULT
(
  rundate         VARCHAR2(8) not null,
  normcode        VARCHAR2(32) not null,
  assistance_col1 VARCHAR2(32) default 'NULL' not null,
  resultvalue     NUMBER(24,6),
  remark          VARCHAR2(128),
  updateby        VARCHAR2(64),
  updatetime      DATE
)
;
alter table PM_DAILY_NORM_RESULT
  add constraint PK_PM_DAILY_NORM_RESULT primary key (RUNDATE, NORMCODE, ASSISTANCE_COL1);

prompt
prompt Creating table PM_FUNDBENCHMARK
prompt ===============================
prompt
create table PM_FUNDBENCHMARK
(
  id            NUMBER(12) not null,
  fundcode      VARCHAR2(32) not null,
  benchmarkid   VARCHAR2(32) not null,
  benchmarktype CHAR(1) not null,
  begindate     VARCHAR2(8) not null,
  enddate       VARCHAR2(8),
  remark        varchar2(1024),
  create_oper   NUMBER(10),
  create_time   DATE,
  modify_oper   NUMBER(10),
  modify_time   DATE
)
;
alter table PM_FUNDBENCHMARK
  add constraint PK_PM_FUNDBENCHMARK primary key (FUNDCODE, BENCHMARKID, BENCHMARKTYPE, BEGINDATE);
alter table PM_FUNDBENCHMARK
  add constraint UQ_PM_FUNDBENCHMARK unique (ID);

prompt
prompt Creating table PM_FUNDCUSTOMCLASSIFY
prompt ====================================
prompt
create table PM_FUNDCUSTOMCLASSIFY
(
  fundcode    VARCHAR2(32) not null,
  type        VARCHAR2(128),
  create_oper NUMBER(10),
  create_time DATE,
  modify_oper NUMBER(10),
  modify_time DATE
)
;
alter table PM_FUNDCUSTOMCLASSIFY
  add constraint PK_PM_FUNDCUSTOMCLASSIFY primary key (FUNDCODE);

prompt
prompt Creating table PM_GROUP
prompt =======================
prompt
create table PM_GROUP
(
  groupid     VARCHAR2(32) not null,
  groupname   VARCHAR2(32),
  description VARCHAR2(128),
  currency    VARCHAR2(8),
  benchmarkid VARCHAR2(32),
  fundmanager VARCHAR2(128),
  begindate   VARCHAR2(8),
  enddate     VARCHAR2(8),
  create_oper NUMBER(10),
  create_time DATE,
  modify_oper NUMBER(10),
  modify_time DATE
)
;
alter table PM_GROUP
  add constraint PK_PM_GROUP primary key (GROUPID);

prompt
prompt Creating table PM_GROUPMEMBER
prompt =============================
prompt
create table PM_GROUPMEMBER
(
  id          NUMBER(12) not null,
  groupid     VARCHAR2(32) not null,
  fundcode    VARCHAR2(32) not null,
  begindate   VARCHAR2(8) not null,
  enddate     VARCHAR2(8),
  create_oper NUMBER(10),
  create_time DATE,
  modify_oper NUMBER(10),
  modify_time DATE
)
;
alter table PM_GROUPMEMBER
  add constraint PK_PM_GROUPMEMBER primary key (GROUPID, FUNDCODE, BEGINDATE);
alter table PM_GROUPMEMBER
  add constraint UQ_PM_GROUPMEMBER unique (ID);

prompt
prompt Creating table PM_HEDGEFUND_DETAIL_CASH
prompt =======================================
prompt
create table PM_HEDGEFUND_DETAIL_CASH
(
  fundcode   VARCHAR2(10),
  type       VARCHAR2(10),
  begin_date VARCHAR2(10),
  end_date   VARCHAR2(10),
  money      NUMBER,
  yield      NUMBER
)
;
comment on table PM_HEDGEFUND_DETAIL_CASH
  is '���ջ���ѹ������-��ȯ��ϸ�ֽ���';
comment on column PM_HEDGEFUND_DETAIL_CASH.fundcode
  is '�������';
comment on column PM_HEDGEFUND_DETAIL_CASH.type
  is '����';
comment on column PM_HEDGEFUND_DETAIL_CASH.begin_date
  is '��ʼ����';
comment on column PM_HEDGEFUND_DETAIL_CASH.end_date
  is '��������';
comment on column PM_HEDGEFUND_DETAIL_CASH.money
  is '���';
comment on column PM_HEDGEFUND_DETAIL_CASH.yield
  is '�껯������';

prompt
prompt Creating table PM_HEDGEFUND_DETAIL_GS
prompt =====================================
prompt
create table PM_HEDGEFUND_DETAIL_GS
(
  fundcode VARCHAR2(10) not null,
  stkid    VARCHAR2(32) not null,
  stkname  VARCHAR2(100),
  grade_zt VARCHAR2(32),
  grade_zx VARCHAR2(32),
  amount   NUMBER,
  mktval   NUMBER,
  gzzz     NUMBER,
  syqx     NUMBER,
  xzjq     NUMBER,
  dqsyl    NUMBER,
  stktype  VARCHAR2(32)
)
;
comment on table PM_HEDGEFUND_DETAIL_GS
  is '���ջ���ѹ������-��ȯ��ϸ_������';
comment on column PM_HEDGEFUND_DETAIL_GS.fundcode
  is '�������';
comment on column PM_HEDGEFUND_DETAIL_GS.stkid
  is '�ֲִ���';
comment on column PM_HEDGEFUND_DETAIL_GS.stkname
  is '����';
comment on column PM_HEDGEFUND_DETAIL_GS.grade_zt
  is '��������';
comment on column PM_HEDGEFUND_DETAIL_GS.grade_zx
  is 'ծ������������+����';
comment on column PM_HEDGEFUND_DETAIL_GS.amount
  is '�ֲ���';
comment on column PM_HEDGEFUND_DETAIL_GS.mktval
  is '��ֵ��';
comment on column PM_HEDGEFUND_DETAIL_GS.gzzz
  is '��ֵ��ֵ';
comment on column PM_HEDGEFUND_DETAIL_GS.syqx
  is 'ʣ������';
comment on column PM_HEDGEFUND_DETAIL_GS.xzjq
  is '��������';
comment on column PM_HEDGEFUND_DETAIL_GS.dqsyl
  is '����������';
comment on column PM_HEDGEFUND_DETAIL_GS.stktype
  is '�ʲ����,�ֵ�61004';
alter table PM_HEDGEFUND_DETAIL_GS
  add constraint PK_PM_HEDGEFUND_DETAIL_GS primary key (FUNDCODE, STKID);

prompt
prompt Creating table PM_HEDGEFUND_DETAIL_QY
prompt =====================================
prompt
create table PM_HEDGEFUND_DETAIL_QY
(
  fundcode   VARCHAR2(10) not null,
  stkid      VARCHAR2(32) not null,
  name       VARCHAR2(100),
  ipo_date   VARCHAR2(32),
  suspension VARCHAR2(10),
  cost       NUMBER,
  price      NUMBER,
  beta       NUMBER
)
;
comment on table PM_HEDGEFUND_DETAIL_QY
  is '���ջ���ѹ������-��ȯ��ϸȨ����';
comment on column PM_HEDGEFUND_DETAIL_QY.fundcode
  is '�������';
comment on column PM_HEDGEFUND_DETAIL_QY.stkid
  is '�ֲִ���';
comment on column PM_HEDGEFUND_DETAIL_QY.name
  is '����';
comment on column PM_HEDGEFUND_DETAIL_QY.ipo_date
  is '��������';
comment on column PM_HEDGEFUND_DETAIL_QY.suspension
  is '�Ƿ�ͣ��';
comment on column PM_HEDGEFUND_DETAIL_QY.cost
  is '�ֲֳɱ�';
comment on column PM_HEDGEFUND_DETAIL_QY.price
  is '���̼�';
alter table PM_HEDGEFUND_DETAIL_QY
  add constraint PK_PM_HEDGEFUND_DETAIL_QY primary key (FUNDCODE, STKID);

prompt
prompt Creating table PM_HEDGEFUND_JGGTC
prompt =================================
prompt
create table PM_HEDGEFUND_JGGTC
(
  fundcode VARCHAR2(10) not null,
  type     VARCHAR2(10) not null,
  sum      NUMBER,
  t0       NUMBER,
  t1       NUMBER,
  t2       NUMBER
)
;
comment on table PM_HEDGEFUND_JGGTC
  is '���ջ���ѹ������-���ܸ�ͷ��';
comment on column PM_HEDGEFUND_JGGTC.fundcode
  is '�������';
comment on column PM_HEDGEFUND_JGGTC.type
  is '���';
comment on column PM_HEDGEFUND_JGGTC.sum
  is '�ϼ�';
comment on column PM_HEDGEFUND_JGGTC.t0
  is 'T<=M';
comment on column PM_HEDGEFUND_JGGTC.t1
  is 'M<T<M+1';
comment on column PM_HEDGEFUND_JGGTC.t2
  is 'T>=M+1';
alter table PM_HEDGEFUND_JGGTC
  add constraint PK_PM_HEDGEFUND_JGGTC primary key (FUNDCODE, TYPE);

prompt
prompt Creating table PM_HEDGEFUND_PARAM
prompt =================================
prompt
create table PM_HEDGEFUND_PARAM
(
  name  VARCHAR2(32) not null,
  grade NUMBER not null,
  type  NUMBER not null,
  value NUMBER,
  temp  VARCHAR2(100)
)
;
comment on table PM_HEDGEFUND_PARAM
  is '���ջ���ѹ�����Բ���';
comment on column PM_HEDGEFUND_PARAM.name
  is '������';
comment on column PM_HEDGEFUND_PARAM.grade
  is '����:1-AAA+,AAA;2-AAA-,AA+;3-AA;4-AA-������;5-δ����ծȯ';
comment on column PM_HEDGEFUND_PARAM.type
  is '�̶�:1-���,2-�ж�,3-�ض�';
comment on column PM_HEDGEFUND_PARAM.value
  is 'ֵ';
comment on column PM_HEDGEFUND_PARAM.temp
  is '��ע';
alter table PM_HEDGEFUND_PARAM
  add constraint PK_PM_HEDGEFUND_PARAM primary key (NAME, GRADE, TYPE);

prompt
prompt Creating table PM_HEDGEFUND_QY
prompt ==============================
prompt
create table PM_HEDGEFUND_QY
(
  fundcode VARCHAR2(10) not null,
  type     VARCHAR2(10) not null,
  sum      NUMBER,
  wssxg    NUMBER,
  tpg      NUMBER,
  ssxg     NUMBER,
  beta1    NUMBER,
  cxg      NUMBER,
  beta2    NUMBER,
  cgg      NUMBER,
  beta3    NUMBER
)
;
comment on table PM_HEDGEFUND_QY
  is '���ջ���ѹ������-Ȩ��';
comment on column PM_HEDGEFUND_QY.fundcode
  is '�������';
comment on column PM_HEDGEFUND_QY.type
  is '���';
comment on column PM_HEDGEFUND_QY.sum
  is '�ϼ�';
comment on column PM_HEDGEFUND_QY.wssxg
  is 'δ�����¹�';
comment on column PM_HEDGEFUND_QY.tpg
  is 'ͣ�ƹ�';
comment on column PM_HEDGEFUND_QY.ssxg
  is '�����¹�';
comment on column PM_HEDGEFUND_QY.beta1
  is 'beta';
comment on column PM_HEDGEFUND_QY.cxg
  is '���¹�';
comment on column PM_HEDGEFUND_QY.beta2
  is 'beta';
comment on column PM_HEDGEFUND_QY.cgg
  is '�����';
comment on column PM_HEDGEFUND_QY.beta3
  is 'beta';
alter table PM_HEDGEFUND_QY
  add constraint PK_PM_HEDGEFUND_QY primary key (FUNDCODE, TYPE);

prompt
prompt Creating table PM_HEDGEFUND_QY_TEMP
prompt ===================================
prompt
create table PM_HEDGEFUND_QY_TEMP
(
  fundcode   VARCHAR2(10) not null,
  stkid      VARCHAR2(32) not null,
  mktval     NUMBER,
  type       VARCHAR2(10),
  model      VARCHAR2(10),
  ration     NUMBER,
  beta       NUMBER,
  indexval   VARCHAR2(10),
  count      NUMBER,
  avg_code   NUMBER,
  avg_index  NUMBER,
  variance   NUMBER,
  covariance NUMBER
)
;
comment on table PM_HEDGEFUND_QY_TEMP
  is '���ջ���ѹ������-Ȩ���м��';
comment on column PM_HEDGEFUND_QY_TEMP.fundcode
  is '�������';
comment on column PM_HEDGEFUND_QY_TEMP.stkid
  is '�ֲִ���';
comment on column PM_HEDGEFUND_QY_TEMP.mktval
  is '��ֵ';
comment on column PM_HEDGEFUND_QY_TEMP.type
  is '����';
comment on column PM_HEDGEFUND_QY_TEMP.model
  is '���';
comment on column PM_HEDGEFUND_QY_TEMP.indexval
  is 'ָ��';
alter table PM_HEDGEFUND_QY_TEMP
  add constraint PK_PM_HEDGEFUND_QY_TEMP primary key (FUNDCODE, STKID);

prompt
prompt Creating table PM_HEDGEFUND_QY_YIELD
prompt ====================================
prompt
create table PM_HEDGEFUND_QY_YIELD
(
  stkid       VARCHAR2(32),
  yield_date  NUMBER,
  yield_code  NUMBER,
  yield_index NUMBER
)
;
comment on table PM_HEDGEFUND_QY_YIELD
  is '���ջ���ѹ������-Ȩ��������';
comment on column PM_HEDGEFUND_QY_YIELD.stkid
  is '�ֲִ���';
comment on column PM_HEDGEFUND_QY_YIELD.yield_date
  is '����';
comment on column PM_HEDGEFUND_QY_YIELD.yield_code
  is '��Ʊ������';
comment on column PM_HEDGEFUND_QY_YIELD.yield_index
  is 'ָ��������';

prompt
prompt Creating table PM_HEDGEFUND_SUM
prompt ===============================
prompt
create table PM_HEDGEFUND_SUM
(
  fundcode   VARCHAR2(32) not null,
  fundname   VARCHAR2(100),
  testdate   VARCHAR2(32),
  begin_date VARCHAR2(32),
  end_date   VARCHAR2(32),
  fundval    NUMBER,
  mktval     NUMBER,
  sybbq      NUMBER,
  dqtxl      NUMBER,
  dwbbe      NUMBER,
  bbxz       NUMBER,
  aqd        NUMBER,
  aqd1       NUMBER,
  aqd2       NUMBER,
  aqd3       NUMBER
)
;
comment on table PM_HEDGEFUND_SUM
  is '���ջ���ѹ������-����';
comment on column PM_HEDGEFUND_SUM.fundcode
  is '�������';
comment on column PM_HEDGEFUND_SUM.fundname
  is '��������';
comment on column PM_HEDGEFUND_SUM.testdate
  is '��ѯ����';
comment on column PM_HEDGEFUND_SUM.begin_date
  is '������ʼ��';
comment on column PM_HEDGEFUND_SUM.end_date
  is '����������';
comment on column PM_HEDGEFUND_SUM.fundval
  is '��Ͼ�ֵ(��Ԫ)';
comment on column PM_HEDGEFUND_SUM.mktval
  is '��λ��ֵ';
comment on column PM_HEDGEFUND_SUM.sybbq
  is 'ʣ�ౣ����';
comment on column PM_HEDGEFUND_SUM.dqtxl
  is '����������';
comment on column PM_HEDGEFUND_SUM.dwbbe
  is '��λ������';
comment on column PM_HEDGEFUND_SUM.bbxz
  is '������ֵ';
comment on column PM_HEDGEFUND_SUM.aqd
  is '��ȫ��';
comment on column PM_HEDGEFUND_SUM.aqd1
  is 'ѹ�����԰�ȫ��_���';
comment on column PM_HEDGEFUND_SUM.aqd2
  is 'ѹ�����԰�ȫ��_�ж�';
comment on column PM_HEDGEFUND_SUM.aqd3
  is 'ѹ�����԰�ȫ��_�ض�';
alter table PM_HEDGEFUND_SUM
  add constraint PK_PM_HEDGEFUND_SUM primary key (FUNDCODE);

prompt
prompt Creating table PM_HEDGEFUND_SUM_ZCLB
prompt ====================================
prompt
create table PM_HEDGEFUND_SUM_ZCLB
(
  fundcode VARCHAR2(32),
  model    VARCHAR2(32),
  type     VARCHAR2(32),
  sum      NUMBER,
  t0       NUMBER,
  t1       NUMBER,
  t2       NUMBER,
  fxzc     NUMBER,
  aqdxhb   NUMBER,
  aqdxhb1  VARCHAR2(64),
  aqdxhb2  VARCHAR2(64),
  aqdxhb3  VARCHAR2(64),
  m_now    NUMBER,
  m_max    NUMBER,
  jzxdfd1  NUMBER,
  jzxdfd2  NUMBER,
  jzxdfd3  NUMBER
)
;
comment on table PM_HEDGEFUND_SUM_ZCLB
  is '���ջ���ѹ������-����_�ʲ����';
comment on column PM_HEDGEFUND_SUM_ZCLB.fundcode
  is '�������';
comment on column PM_HEDGEFUND_SUM_ZCLB.model
  is '�ʲ�����';
comment on column PM_HEDGEFUND_SUM_ZCLB.type
  is '�ʲ����';
comment on column PM_HEDGEFUND_SUM_ZCLB.sum
  is '�ϼ�';
comment on column PM_HEDGEFUND_SUM_ZCLB.t0
  is '������ռ��ֵ��T0';
comment on column PM_HEDGEFUND_SUM_ZCLB.t1
  is '������ռ��ֵ��T1';
comment on column PM_HEDGEFUND_SUM_ZCLB.t2
  is '������ռ��ֵ��T2';
comment on column PM_HEDGEFUND_SUM_ZCLB.fxzc
  is '��ĩֵ_�����ʲ�/M';
comment on column PM_HEDGEFUND_SUM_ZCLB.aqdxhb
  is '��ĩֵ_��ȫ�����ı�';
comment on column PM_HEDGEFUND_SUM_ZCLB.aqdxhb1
  is 'ѹ�������°�ȫ�����ı�_���';
comment on column PM_HEDGEFUND_SUM_ZCLB.aqdxhb2
  is 'ѹ�������°�ȫ�����ı�_�ж�';
comment on column PM_HEDGEFUND_SUM_ZCLB.aqdxhb3
  is 'ѹ�������°�ȫ�����ı�_�ض�';
comment on column PM_HEDGEFUND_SUM_ZCLB.m_now
  is '���ճ���Mֵ_��ǰֵ';
comment on column PM_HEDGEFUND_SUM_ZCLB.m_max
  is '���ճ���Mֵ_���ֵ';
comment on column PM_HEDGEFUND_SUM_ZCLB.jzxdfd1
  is '��ֵ�µ�����(�ٷֱ�)_���';
comment on column PM_HEDGEFUND_SUM_ZCLB.jzxdfd2
  is '��ֵ�µ�����(�ٷֱ�)_�ж�';
comment on column PM_HEDGEFUND_SUM_ZCLB.jzxdfd3
  is '��ֵ�µ�����(�ٷֱ�)_�ض�';

prompt
prompt Creating table PM_HEDGEFUND_TEST_QY
prompt ===================================
prompt
create table PM_HEDGEFUND_TEST_QY
(
  fundcode VARCHAR2(32) not null,
  type     VARCHAR2(32) not null,
  ssxg1    NUMBER,
  ssxg2    NUMBER,
  ssxg3    NUMBER,
  cxg1     NUMBER,
  cxg2     NUMBER,
  cxg3     NUMBER,
  cgg1     NUMBER,
  cgg2     NUMBER,
  cgg3     NUMBER
)
;
comment on table PM_HEDGEFUND_TEST_QY
  is '���ջ���ѹ������-��ϸ_Ȩ����';
comment on column PM_HEDGEFUND_TEST_QY.fundcode
  is '�������';
comment on column PM_HEDGEFUND_TEST_QY.type
  is '����';
comment on column PM_HEDGEFUND_TEST_QY.ssxg1
  is '�����¹�_���';
comment on column PM_HEDGEFUND_TEST_QY.ssxg2
  is '�����¹�_�ж�';
comment on column PM_HEDGEFUND_TEST_QY.ssxg3
  is '�����¹�_�ض�';
comment on column PM_HEDGEFUND_TEST_QY.cxg1
  is '���¹�_���';
comment on column PM_HEDGEFUND_TEST_QY.cxg2
  is '���¹�_�ж�';
comment on column PM_HEDGEFUND_TEST_QY.cxg3
  is '���¹�_�ض�';
comment on column PM_HEDGEFUND_TEST_QY.cgg1
  is '�����_���';
comment on column PM_HEDGEFUND_TEST_QY.cgg2
  is '�����_�ж�';
comment on column PM_HEDGEFUND_TEST_QY.cgg3
  is '�����_�ض�';
alter table PM_HEDGEFUND_TEST_QY
  add constraint PK_PM_HEDGEFUND_TEST_QY primary key (FUNDCODE, TYPE);

prompt
prompt Creating table PM_HEDGEFUND_TEST_ZCLB
prompt =====================================
prompt
create table PM_HEDGEFUND_TEST_ZCLB
(
  fundcode VARCHAR2(32),
  type     VARCHAR2(32),
  grade    VARCHAR2(32),
  t0_1     NUMBER,
  t0_2     NUMBER,
  t0_3     NUMBER,
  t1_1     NUMBER,
  t1_2     NUMBER,
  t1_3     NUMBER,
  t2_1     NUMBER,
  t2_2     NUMBER,
  t2_3     NUMBER
)
;
comment on table PM_HEDGEFUND_TEST_ZCLB
  is '���ջ���ѹ������-��ϸ_�ʲ����';
comment on column PM_HEDGEFUND_TEST_ZCLB.fundcode
  is '�������';
comment on column PM_HEDGEFUND_TEST_ZCLB.type
  is '���';
comment on column PM_HEDGEFUND_TEST_ZCLB.grade
  is '��������';
comment on column PM_HEDGEFUND_TEST_ZCLB.t0_1
  is 'T0_���';
comment on column PM_HEDGEFUND_TEST_ZCLB.t0_2
  is 'T0_�ж�';
comment on column PM_HEDGEFUND_TEST_ZCLB.t0_3
  is 'T0_�ض�';
comment on column PM_HEDGEFUND_TEST_ZCLB.t1_1
  is 'T1_���';
comment on column PM_HEDGEFUND_TEST_ZCLB.t1_2
  is 'T1_�ж�';
comment on column PM_HEDGEFUND_TEST_ZCLB.t1_3
  is 'T1_�ض�';
comment on column PM_HEDGEFUND_TEST_ZCLB.t2_1
  is 'T2_���';
comment on column PM_HEDGEFUND_TEST_ZCLB.t2_2
  is 'T2_�ж�';
comment on column PM_HEDGEFUND_TEST_ZCLB.t2_3
  is 'T2_�ض�';

prompt
prompt Creating table PM_HEDGEFUND_ZCLB
prompt ================================
prompt
create table PM_HEDGEFUND_ZCLB
(
  fundcode VARCHAR2(10) not null,
  type     VARCHAR2(20) not null,
  grade    VARCHAR2(20),
  sum      NUMBER,
  t0       NUMBER,
  t0syl    NUMBER,
  t0jq     NUMBER,
  t0syqx   NUMBER,
  t1       NUMBER,
  t1syl    NUMBER,
  t1jq     NUMBER,
  t1syqx   NUMBER,
  t2       NUMBER,
  t2syl    NUMBER,
  t2jq     NUMBER,
  t2syqx   NUMBER
)
;
comment on table PM_HEDGEFUND_ZCLB
  is '���ջ���ѹ������-�ʲ����';
comment on column PM_HEDGEFUND_ZCLB.fundcode
  is '�������';
comment on column PM_HEDGEFUND_ZCLB.type
  is '�ʲ����';
comment on column PM_HEDGEFUND_ZCLB.grade
  is '��������';
comment on column PM_HEDGEFUND_ZCLB.sum
  is '�ϼ�';
comment on column PM_HEDGEFUND_ZCLB.t0
  is 'T<=M';
comment on column PM_HEDGEFUND_ZCLB.t0syl
  is 'T0����������';
comment on column PM_HEDGEFUND_ZCLB.t0jq
  is 'T0��Ȩ����';
comment on column PM_HEDGEFUND_ZCLB.t0syqx
  is 'T0��Ȩʣ������';
comment on column PM_HEDGEFUND_ZCLB.t1
  is 'M<T<M+1';
comment on column PM_HEDGEFUND_ZCLB.t1syl
  is 'T1����������';
comment on column PM_HEDGEFUND_ZCLB.t1jq
  is 'T1��Ȩ����';
comment on column PM_HEDGEFUND_ZCLB.t1syqx
  is 'T1��Ȩʣ������';
comment on column PM_HEDGEFUND_ZCLB.t2
  is 'T>=M+1';
comment on column PM_HEDGEFUND_ZCLB.t2syl
  is 'T2����������';
comment on column PM_HEDGEFUND_ZCLB.t2jq
  is 'T2��Ȩ����';
comment on column PM_HEDGEFUND_ZCLB.t2syqx
  is 'T2��Ȩʣ������';

prompt
prompt Creating table PM_HEDGEFUND_ZCLB_TEMP
prompt =====================================
prompt
create table PM_HEDGEFUND_ZCLB_TEMP
(
  fundcode  VARCHAR2(32),
  maketcode VARCHAR2(32),
  mktval    NUMBER,
  qixian    VARCHAR2(32),
  type      VARCHAR2(32),
  grade     VARCHAR2(32),
  ration    NUMBER,
  ration2   NUMBER,
  dqsyl     NUMBER,
  jiuqi     NUMBER,
  syqx      NUMBER
)
;
comment on table PM_HEDGEFUND_ZCLB_TEMP
  is '���ջ���ѹ������-�ʲ�����м��';
comment on column PM_HEDGEFUND_ZCLB_TEMP.fundcode
  is '�������';
comment on column PM_HEDGEFUND_ZCLB_TEMP.maketcode
  is '�ֲִ���';
comment on column PM_HEDGEFUND_ZCLB_TEMP.mktval
  is '��ֵ';
comment on column PM_HEDGEFUND_ZCLB_TEMP.qixian
  is '����';
comment on column PM_HEDGEFUND_ZCLB_TEMP.type
  is '���';
comment on column PM_HEDGEFUND_ZCLB_TEMP.grade
  is '����';
comment on column PM_HEDGEFUND_ZCLB_TEMP.dqsyl
  is '����������';
comment on column PM_HEDGEFUND_ZCLB_TEMP.jiuqi
  is '����';
comment on column PM_HEDGEFUND_ZCLB_TEMP.syqx
  is 'ʣ������';

prompt
prompt Creating table PM_INDEX
prompt =======================
prompt
create table PM_INDEX
(
  indexid   VARCHAR2(32) not null,
  market    VARCHAR2(8),
  indexcode VARCHAR2(64),
  indexname VARCHAR2(64),
  indextype VARCHAR2(2),
  related_table varchar2(128),
  related_term varchar2(1024),
  rateval   NUMBER(16,8),
  taxtype   varchar2(1),
  date_type varchar2(1),
  pricetype varchar2(32),
  remark    varchar2(1024)
)
;
alter table PM_INDEX
  add constraint PK_PM_INDEX primary key (INDEXID);

prompt
prompt Creating table PM_MONETARYFUND
prompt ==============================
prompt
create table PM_MONETARYFUND
(
  fundcode       VARCHAR2(10) not null,
  marketcode     VARCHAR2(10) not null,
  fundname       VARCHAR2(200),
  netvalue       NUMBER default 0,
  yzplje         NUMBER default 0,
  fpl            NUMBER default 0,
  pld_1          NUMBER default 0,
  pld_2          NUMBER default 0,
  pld_3          NUMBER default 0,
  jgtzzzb        NUMBER default 0,
  qsdtzzzb       NUMBER default 0,
  tzzhpjsyts     NUMBER default 0,
  jjtzzhpjsycxts NUMBER default 0,
  ldxzczb        NUMBER default 0,
  zhggl          NUMBER default 0
)
;
comment on table PM_MONETARYFUND
  is '���һ���ѹ�����Ի���';
comment on column PM_MONETARYFUND.fundcode
  is '�������';
comment on column PM_MONETARYFUND.marketcode
  is '�г�����';
comment on column PM_MONETARYFUND.fundname
  is '��������';
comment on column PM_MONETARYFUND.netvalue
  is '��ϵ�ǰ��ֵ(��)';
comment on column PM_MONETARYFUND.yzplje
  is '��ϵ�ǰӰ��ƫ����(��)';
comment on column PM_MONETARYFUND.fpl
  is '��ϵ�ǰ��ƫ��';
comment on column PM_MONETARYFUND.pld_1
  is '����龰������ƫ���';
comment on column PM_MONETARYFUND.pld_2
  is '�ض��龰������ƫ���';
comment on column PM_MONETARYFUND.pld_3
  is '�����ض��龰������ƫ���';
comment on column PM_MONETARYFUND.jgtzzzb
  is '����Ͷ����ռ��';
comment on column PM_MONETARYFUND.qsdtzzzb
  is 'ǰ10��Ͷ����ռ��';
comment on column PM_MONETARYFUND.tzzhpjsyts
  is 'Ͷ�����ƽ��ʣ������';
comment on column PM_MONETARYFUND.jjtzzhpjsycxts
  is '����Ͷ�����ƽ��ʣ���������';
comment on column PM_MONETARYFUND.ldxzczb
  is '�������ʲ�ռ��';
comment on column PM_MONETARYFUND.zhggl
  is '��ϸܸ���';
alter table PM_MONETARYFUND
  add constraint PK_PM_MONETARYFUND primary key (FUNDCODE);

prompt
prompt Creating table PM_MONETARYFUND_DETAIL
prompt =====================================
prompt
create table PM_MONETARYFUND_DETAIL
(
  fundcode   VARCHAR2(10) not null,
  fundname   VARCHAR2(200),
  marketcode VARCHAR2(20) not null,
  marketname VARCHAR2(200),
  count      NUMBER,
  cost       NUMBER,
  yzjzjz     NUMBER,
  yzjzzjzbl  NUMBER,
  gzzz       NUMBER,
  fxlx       NUMBER,
  zclb       VARCHAR2(10),
  ztpj       NUMBER,
  xzjq       NUMBER,
  jldqts     NUMBER
)
;
comment on table PM_MONETARYFUND_DETAIL
  is '���һ���ֲ�ѹ��������ϸ';
comment on column PM_MONETARYFUND_DETAIL.fundcode
  is '�������';
comment on column PM_MONETARYFUND_DETAIL.fundname
  is '��������';
comment on column PM_MONETARYFUND_DETAIL.marketcode
  is '�г�����';
comment on column PM_MONETARYFUND_DETAIL.marketname
  is '�г�����';
comment on column PM_MONETARYFUND_DETAIL.count
  is '����';
comment on column PM_MONETARYFUND_DETAIL.cost
  is '�ɱ���̯��ɱ���';
comment on column PM_MONETARYFUND_DETAIL.yzjzjz
  is 'Ӱ�Ӽ�ֵ��ֵ';
comment on column PM_MONETARYFUND_DETAIL.yzjzzjzbl
  is 'Ӱ�Ӽ�ֵռ��ֵ����';
comment on column PM_MONETARYFUND_DETAIL.gzzz
  is '��ֵ��ֵ';
comment on column PM_MONETARYFUND_DETAIL.fxlx
  is '��Ϣ���ͣ��ֵ�77014';
comment on column PM_MONETARYFUND_DETAIL.zclb
  is '�ʲ�����ֵ�77015';
comment on column PM_MONETARYFUND_DETAIL.ztpj
  is '�����������ֵ�77016';
comment on column PM_MONETARYFUND_DETAIL.xzjq
  is '��������';
comment on column PM_MONETARYFUND_DETAIL.jldqts
  is '���뵽������';
alter table PM_MONETARYFUND_DETAIL
  add constraint PK_PM_MONETARYFUND_DETAIL primary key (FUNDCODE, MARKETCODE);

prompt
prompt Creating table PM_MONETARYFUND_PARAM
prompt ====================================
prompt
create table PM_MONETARYFUND_PARAM
(
  name  VARCHAR2(32) not null,
  type  NUMBER not null,
  value NUMBER,
  temp  VARCHAR2(100)
)
;
comment on table PM_MONETARYFUND_PARAM
  is '���һ���ѹ�����Բ���';
comment on column PM_MONETARYFUND_PARAM.name
  is '����';
comment on column PM_MONETARYFUND_PARAM.type
  is '�̶�:1-���,2-�ض�,3-�����ض�';
comment on column PM_MONETARYFUND_PARAM.value
  is 'ֵ';
comment on column PM_MONETARYFUND_PARAM.temp
  is '��ע';
alter table PM_MONETARYFUND_PARAM
  add constraint PK_PM_MONETARYFUND_PARAM primary key (NAME, TYPE);

prompt
prompt Creating table PM_MONETARYFUND_RESULT
prompt =====================================
prompt
create table PM_MONETARYFUND_RESULT
(
  fundcode       VARCHAR2(10) not null,
  fundname       VARCHAR2(200),
  typecode       NUMBER not null,
  yzjz           NUMBER,
  zjjzcjzdbz     NUMBER,
  xzjq           NUMBER,
  dqyzplje       NUMBER,
  gsss_1         NUMBER,
  ylcshdyzplje_1 NUMBER,
  gsss_2         NUMBER,
  ylcshdyzplje_2 NUMBER,
  gsss_3         NUMBER,
  ylcshdyzplje_3 NUMBER
)
;
comment on table PM_MONETARYFUND_RESULT
  is '���һ���ѹ�����Խ��';
comment on column PM_MONETARYFUND_RESULT.fundcode
  is '�������';
comment on column PM_MONETARYFUND_RESULT.fundname
  is '��������';
comment on column PM_MONETARYFUND_RESULT.typecode
  is '�ʲ�����ֵ�77012';
comment on column PM_MONETARYFUND_RESULT.yzjz
  is 'Ӱ�Ӽ�ֵ��Ԫ��';
comment on column PM_MONETARYFUND_RESULT.zjjzcjzdbz
  is 'ռ�����ʲ���ֵ�ı���';
comment on column PM_MONETARYFUND_RESULT.xzjq
  is '�������ڣ��꣩';
comment on column PM_MONETARYFUND_RESULT.dqyzplje
  is '��ǰӰ��ƫ���Ԫ��';
comment on column PM_MONETARYFUND_RESULT.gsss_1
  is '������ʧ��Ԫ��_��ȼ���';
comment on column PM_MONETARYFUND_RESULT.ylcshdyzplje_1
  is 'ѹ�����Ժ��Ӱ��ƫ���ܶԪ��_��ȼ���';
comment on column PM_MONETARYFUND_RESULT.gsss_2
  is '������ʧ��Ԫ��_�ضȼ���';
comment on column PM_MONETARYFUND_RESULT.ylcshdyzplje_2
  is 'ѹ�����Ժ��Ӱ��ƫ���ܶԪ��_�ضȼ���';
comment on column PM_MONETARYFUND_RESULT.gsss_3
  is '������ʧ��Ԫ��_�����ضȼ���';
comment on column PM_MONETARYFUND_RESULT.ylcshdyzplje_3
  is 'ѹ�����Ժ��Ӱ��ƫ���ܶԪ��_�����ضȼ���';
alter table PM_MONETARYFUND_RESULT
  add constraint PK_PM_MONETARYFUND_RESULT primary key (FUNDCODE, TYPECODE);

prompt
prompt Creating table PM_QUOTAINFO
prompt ===========================
prompt
create table PM_QUOTAINFO
(
  quotacode  VARCHAR2(32) default '' not null,
  quotaname  VARCHAR2(128) default '',
  quotadesc  VARCHAR2(2048) default '',
  formulaid  VARCHAR2(12) default '',
  remark     VARCHAR2(4000) default '',
  datetype   VARCHAR2(2)  default '' not null,
  updateby   VARCHAR2(64),
  updatetime DATE
)
;
comment on table PM_QUOTAINFO
  is '����-��׼ָ����Ϣ��';
alter table PM_QUOTAINFO
  add constraint PK_PM_QUOTAINFO primary key (QUOTACODE,datetype);

prompt
prompt Creating table PM_QUOTARESULT
prompt =============================
prompt
create table PM_QUOTARESULT
(
  benchmarkid VARCHAR2(32) default '' not null,
  rundate     VARCHAR2(8) default '' not null,
  quotacode   VARCHAR2(32) default '' not null,
  resultvalue number(24,14) default 0.0 not null,
  remark      VARCHAR2(128) default '',
  updateby    VARCHAR2(64),
  updatetime  DATE
)
;
comment on table PM_QUOTARESULT
  is '����-��׼ָ�������';
comment on column PM_QUOTARESULT.benchmarkid
  is '��׼ID';
comment on column PM_QUOTARESULT.rundate
  is '��������';
comment on column PM_QUOTARESULT.quotacode
  is 'ָ�����';
comment on column PM_QUOTARESULT.resultvalue
  is '���ֵ';
comment on column PM_QUOTARESULT.remark
  is '��ע';
comment on column PM_QUOTARESULT.updateby
  is '������';
comment on column PM_QUOTARESULT.updatetime
  is '����ʱ��';
alter table PM_QUOTARESULT
  add constraint PK_PM_QUOTARESULT primary key (BENCHMARKID, RUNDATE, QUOTACODE);


spool off
