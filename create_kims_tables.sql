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
  is '组合排名结果表';
comment on column PM_FUNDRANKRESULT.fundcode
  is '组合代码';
comment on column PM_FUNDRANKRESULT.rundate
  is '计算日期';
comment on column PM_FUNDRANKRESULT.quotacode
  is '指标代码';
comment on column PM_FUNDRANKRESULT.fundrank
  is '结果值';
comment on column PM_FUNDRANKRESULT.remark
  is '备注';
comment on column PM_FUNDRANKRESULT.updateby
  is '更新人';
comment on column PM_FUNDRANKRESULT.updatetime
  is '更新时间';
  comment on column PM_FUNDRANKRESULT.datasource
  is '数据来源';  
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
  is '避险基金压力测试-个券明细现金类';
comment on column PM_HEDGEFUND_DETAIL_CASH.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_DETAIL_CASH.type
  is '类型';
comment on column PM_HEDGEFUND_DETAIL_CASH.begin_date
  is '开始日期';
comment on column PM_HEDGEFUND_DETAIL_CASH.end_date
  is '结束日期';
comment on column PM_HEDGEFUND_DETAIL_CASH.money
  is '金额';
comment on column PM_HEDGEFUND_DETAIL_CASH.yield
  is '年化收益率';

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
  is '避险基金压力测试-个券明细_固收类';
comment on column PM_HEDGEFUND_DETAIL_GS.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_DETAIL_GS.stkid
  is '持仓代码';
comment on column PM_HEDGEFUND_DETAIL_GS.stkname
  is '名称';
comment on column PM_HEDGEFUND_DETAIL_GS.grade_zt
  is '主体评级';
comment on column PM_HEDGEFUND_DETAIL_GS.grade_zx
  is '债项评级：长期+短期';
comment on column PM_HEDGEFUND_DETAIL_GS.amount
  is '持仓数';
comment on column PM_HEDGEFUND_DETAIL_GS.mktval
  is '估值价';
comment on column PM_HEDGEFUND_DETAIL_GS.gzzz
  is '估值增值';
comment on column PM_HEDGEFUND_DETAIL_GS.syqx
  is '剩余期限';
comment on column PM_HEDGEFUND_DETAIL_GS.xzjq
  is '修正久期';
comment on column PM_HEDGEFUND_DETAIL_GS.dqsyl
  is '到期收益率';
comment on column PM_HEDGEFUND_DETAIL_GS.stktype
  is '资产类别,字典61004';
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
  is '避险基金压力测试-个券明细权益类';
comment on column PM_HEDGEFUND_DETAIL_QY.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_DETAIL_QY.stkid
  is '持仓代码';
comment on column PM_HEDGEFUND_DETAIL_QY.name
  is '名称';
comment on column PM_HEDGEFUND_DETAIL_QY.ipo_date
  is '上市日期';
comment on column PM_HEDGEFUND_DETAIL_QY.suspension
  is '是否停牌';
comment on column PM_HEDGEFUND_DETAIL_QY.cost
  is '持仓成本';
comment on column PM_HEDGEFUND_DETAIL_QY.price
  is '收盘价';
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
  is '避险基金压力测试-净杠杆头寸';
comment on column PM_HEDGEFUND_JGGTC.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_JGGTC.type
  is '类别';
comment on column PM_HEDGEFUND_JGGTC.sum
  is '合计';
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
  is '避险基金压力测试参数';
comment on column PM_HEDGEFUND_PARAM.name
  is '参数名';
comment on column PM_HEDGEFUND_PARAM.grade
  is '评级:1-AAA+,AAA;2-AAA-,AA+;3-AA;4-AA-及以下;5-未上市债券';
comment on column PM_HEDGEFUND_PARAM.type
  is '程度:1-轻度,2-中度,3-重度';
comment on column PM_HEDGEFUND_PARAM.value
  is '值';
comment on column PM_HEDGEFUND_PARAM.temp
  is '备注';
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
  is '避险基金压力测试-权益';
comment on column PM_HEDGEFUND_QY.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_QY.type
  is '板块';
comment on column PM_HEDGEFUND_QY.sum
  is '合计';
comment on column PM_HEDGEFUND_QY.wssxg
  is '未上市新股';
comment on column PM_HEDGEFUND_QY.tpg
  is '停牌股';
comment on column PM_HEDGEFUND_QY.ssxg
  is '上市新股';
comment on column PM_HEDGEFUND_QY.beta1
  is 'beta';
comment on column PM_HEDGEFUND_QY.cxg
  is '次新股';
comment on column PM_HEDGEFUND_QY.beta2
  is 'beta';
comment on column PM_HEDGEFUND_QY.cgg
  is '常规股';
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
  is '避险基金压力测试-权益中间表';
comment on column PM_HEDGEFUND_QY_TEMP.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_QY_TEMP.stkid
  is '持仓代码';
comment on column PM_HEDGEFUND_QY_TEMP.mktval
  is '市值';
comment on column PM_HEDGEFUND_QY_TEMP.type
  is '类型';
comment on column PM_HEDGEFUND_QY_TEMP.model
  is '板块';
comment on column PM_HEDGEFUND_QY_TEMP.indexval
  is '指数';
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
  is '避险基金压力测试-权益收益率';
comment on column PM_HEDGEFUND_QY_YIELD.stkid
  is '持仓代码';
comment on column PM_HEDGEFUND_QY_YIELD.yield_date
  is '日期';
comment on column PM_HEDGEFUND_QY_YIELD.yield_code
  is '股票收益率';
comment on column PM_HEDGEFUND_QY_YIELD.yield_index
  is '指数收益率';

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
  is '避险基金压力测试-汇总';
comment on column PM_HEDGEFUND_SUM.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_SUM.fundname
  is '基金名称';
comment on column PM_HEDGEFUND_SUM.testdate
  is '查询日期';
comment on column PM_HEDGEFUND_SUM.begin_date
  is '保本起始日';
comment on column PM_HEDGEFUND_SUM.end_date
  is '保本到期日';
comment on column PM_HEDGEFUND_SUM.fundval
  is '组合净值(亿元)';
comment on column PM_HEDGEFUND_SUM.mktval
  is '单位净值';
comment on column PM_HEDGEFUND_SUM.sybbq
  is '剩余保本期';
comment on column PM_HEDGEFUND_SUM.dqtxl
  is '到期贴现率';
comment on column PM_HEDGEFUND_SUM.dwbbe
  is '单位保本额';
comment on column PM_HEDGEFUND_SUM.bbxz
  is '保本现值';
comment on column PM_HEDGEFUND_SUM.aqd
  is '安全垫';
comment on column PM_HEDGEFUND_SUM.aqd1
  is '压力测试安全垫_轻度';
comment on column PM_HEDGEFUND_SUM.aqd2
  is '压力测试安全垫_中度';
comment on column PM_HEDGEFUND_SUM.aqd3
  is '压力测试安全垫_重度';
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
  is '避险基金压力测试-汇总_资产类别';
comment on column PM_HEDGEFUND_SUM_ZCLB.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_SUM_ZCLB.model
  is '资产分类';
comment on column PM_HEDGEFUND_SUM_ZCLB.type
  is '资产类别';
comment on column PM_HEDGEFUND_SUM_ZCLB.sum
  is '合计';
comment on column PM_HEDGEFUND_SUM_ZCLB.t0
  is '分期限占净值比T0';
comment on column PM_HEDGEFUND_SUM_ZCLB.t1
  is '分期限占净值比T1';
comment on column PM_HEDGEFUND_SUM_ZCLB.t2
  is '分期限占净值比T2';
comment on column PM_HEDGEFUND_SUM_ZCLB.fxzc
  is '期末值_风险资产/M';
comment on column PM_HEDGEFUND_SUM_ZCLB.aqdxhb
  is '期末值_安全垫消耗比';
comment on column PM_HEDGEFUND_SUM_ZCLB.aqdxhb1
  is '压力测试下安全垫消耗比_轻度';
comment on column PM_HEDGEFUND_SUM_ZCLB.aqdxhb2
  is '压力测试下安全垫消耗比_中度';
comment on column PM_HEDGEFUND_SUM_ZCLB.aqdxhb3
  is '压力测试下安全垫消耗比_重度';
comment on column PM_HEDGEFUND_SUM_ZCLB.m_now
  is '风险乘数M值_当前值';
comment on column PM_HEDGEFUND_SUM_ZCLB.m_max
  is '风险乘数M值_最高值';
comment on column PM_HEDGEFUND_SUM_ZCLB.jzxdfd1
  is '净值下跌幅度(百分比)_轻度';
comment on column PM_HEDGEFUND_SUM_ZCLB.jzxdfd2
  is '净值下跌幅度(百分比)_中度';
comment on column PM_HEDGEFUND_SUM_ZCLB.jzxdfd3
  is '净值下跌幅度(百分比)_重度';

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
  is '避险基金压力测试-明细_权益类';
comment on column PM_HEDGEFUND_TEST_QY.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_TEST_QY.type
  is '类型';
comment on column PM_HEDGEFUND_TEST_QY.ssxg1
  is '上市新股_轻度';
comment on column PM_HEDGEFUND_TEST_QY.ssxg2
  is '上市新股_中度';
comment on column PM_HEDGEFUND_TEST_QY.ssxg3
  is '上市新股_重度';
comment on column PM_HEDGEFUND_TEST_QY.cxg1
  is '次新股_轻度';
comment on column PM_HEDGEFUND_TEST_QY.cxg2
  is '次新股_中度';
comment on column PM_HEDGEFUND_TEST_QY.cxg3
  is '次新股_重度';
comment on column PM_HEDGEFUND_TEST_QY.cgg1
  is '常规股_轻度';
comment on column PM_HEDGEFUND_TEST_QY.cgg2
  is '常规股_中度';
comment on column PM_HEDGEFUND_TEST_QY.cgg3
  is '常规股_重度';
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
  is '避险基金压力测试-明细_资产类别';
comment on column PM_HEDGEFUND_TEST_ZCLB.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_TEST_ZCLB.type
  is '类别';
comment on column PM_HEDGEFUND_TEST_ZCLB.grade
  is '信用评级';
comment on column PM_HEDGEFUND_TEST_ZCLB.t0_1
  is 'T0_轻度';
comment on column PM_HEDGEFUND_TEST_ZCLB.t0_2
  is 'T0_中度';
comment on column PM_HEDGEFUND_TEST_ZCLB.t0_3
  is 'T0_重度';
comment on column PM_HEDGEFUND_TEST_ZCLB.t1_1
  is 'T1_轻度';
comment on column PM_HEDGEFUND_TEST_ZCLB.t1_2
  is 'T1_中度';
comment on column PM_HEDGEFUND_TEST_ZCLB.t1_3
  is 'T1_重度';
comment on column PM_HEDGEFUND_TEST_ZCLB.t2_1
  is 'T2_轻度';
comment on column PM_HEDGEFUND_TEST_ZCLB.t2_2
  is 'T2_中度';
comment on column PM_HEDGEFUND_TEST_ZCLB.t2_3
  is 'T2_重度';

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
  is '避险基金压力测试-资产类别';
comment on column PM_HEDGEFUND_ZCLB.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_ZCLB.type
  is '资产类别';
comment on column PM_HEDGEFUND_ZCLB.grade
  is '信用评级';
comment on column PM_HEDGEFUND_ZCLB.sum
  is '合计';
comment on column PM_HEDGEFUND_ZCLB.t0
  is 'T<=M';
comment on column PM_HEDGEFUND_ZCLB.t0syl
  is 'T0到期收益率';
comment on column PM_HEDGEFUND_ZCLB.t0jq
  is 'T0加权久期';
comment on column PM_HEDGEFUND_ZCLB.t0syqx
  is 'T0加权剩余期限';
comment on column PM_HEDGEFUND_ZCLB.t1
  is 'M<T<M+1';
comment on column PM_HEDGEFUND_ZCLB.t1syl
  is 'T1到期收益率';
comment on column PM_HEDGEFUND_ZCLB.t1jq
  is 'T1加权久期';
comment on column PM_HEDGEFUND_ZCLB.t1syqx
  is 'T1加权剩余期限';
comment on column PM_HEDGEFUND_ZCLB.t2
  is 'T>=M+1';
comment on column PM_HEDGEFUND_ZCLB.t2syl
  is 'T2到期收益率';
comment on column PM_HEDGEFUND_ZCLB.t2jq
  is 'T2加权久期';
comment on column PM_HEDGEFUND_ZCLB.t2syqx
  is 'T2加权剩余期限';

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
  is '避险基金压力测试-资产类别中间表';
comment on column PM_HEDGEFUND_ZCLB_TEMP.fundcode
  is '基金代码';
comment on column PM_HEDGEFUND_ZCLB_TEMP.maketcode
  is '持仓代码';
comment on column PM_HEDGEFUND_ZCLB_TEMP.mktval
  is '市值';
comment on column PM_HEDGEFUND_ZCLB_TEMP.qixian
  is '期限';
comment on column PM_HEDGEFUND_ZCLB_TEMP.type
  is '类别';
comment on column PM_HEDGEFUND_ZCLB_TEMP.grade
  is '评级';
comment on column PM_HEDGEFUND_ZCLB_TEMP.dqsyl
  is '到期收益率';
comment on column PM_HEDGEFUND_ZCLB_TEMP.jiuqi
  is '久期';
comment on column PM_HEDGEFUND_ZCLB_TEMP.syqx
  is '剩余期限';

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
  is '货币基金压力测试汇总';
comment on column PM_MONETARYFUND.fundcode
  is '基金代码';
comment on column PM_MONETARYFUND.marketcode
  is '市场代码';
comment on column PM_MONETARYFUND.fundname
  is '基金名称';
comment on column PM_MONETARYFUND.netvalue
  is '组合当前净值(亿)';
comment on column PM_MONETARYFUND.yzplje
  is '组合当前影子偏离金额(万)';
comment on column PM_MONETARYFUND.fpl
  is '组合当前负偏离';
comment on column PM_MONETARYFUND.pld_1
  is '轻度情景假设下偏离度';
comment on column PM_MONETARYFUND.pld_2
  is '重度情景假设下偏离度';
comment on column PM_MONETARYFUND.pld_3
  is '极端重度情景假设下偏离度';
comment on column PM_MONETARYFUND.jgtzzzb
  is '机构投资者占比';
comment on column PM_MONETARYFUND.qsdtzzzb
  is '前10大投资者占比';
comment on column PM_MONETARYFUND.tzzhpjsyts
  is '投资组合平均剩余天数';
comment on column PM_MONETARYFUND.jjtzzhpjsycxts
  is '基金投资组合平均剩余存续天数';
comment on column PM_MONETARYFUND.ldxzczb
  is '流动性资产占比';
comment on column PM_MONETARYFUND.zhggl
  is '组合杠杆率';
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
  is '货币基金持仓压力测试明细';
comment on column PM_MONETARYFUND_DETAIL.fundcode
  is '基金代码';
comment on column PM_MONETARYFUND_DETAIL.fundname
  is '基金名称';
comment on column PM_MONETARYFUND_DETAIL.marketcode
  is '市场代码';
comment on column PM_MONETARYFUND_DETAIL.marketname
  is '市场名称';
comment on column PM_MONETARYFUND_DETAIL.count
  is '数量';
comment on column PM_MONETARYFUND_DETAIL.cost
  is '成本（摊余成本）';
comment on column PM_MONETARYFUND_DETAIL.yzjzjz
  is '影子价值净值';
comment on column PM_MONETARYFUND_DETAIL.yzjzzjzbl
  is '影子价值占净值比例';
comment on column PM_MONETARYFUND_DETAIL.gzzz
  is '估值增值';
comment on column PM_MONETARYFUND_DETAIL.fxlx
  is '付息类型，字典77014';
comment on column PM_MONETARYFUND_DETAIL.zclb
  is '资产类别，字典77015';
comment on column PM_MONETARYFUND_DETAIL.ztpj
  is '主体评级，字典77016';
comment on column PM_MONETARYFUND_DETAIL.xzjq
  is '修正久期';
comment on column PM_MONETARYFUND_DETAIL.jldqts
  is '距离到期天数';
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
  is '货币基金压力测试参数';
comment on column PM_MONETARYFUND_PARAM.name
  is '参数';
comment on column PM_MONETARYFUND_PARAM.type
  is '程度:1-轻度,2-重度,3-极端重度';
comment on column PM_MONETARYFUND_PARAM.value
  is '值';
comment on column PM_MONETARYFUND_PARAM.temp
  is '备注';
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
  is '货币基金压力测试结果';
comment on column PM_MONETARYFUND_RESULT.fundcode
  is '基金代码';
comment on column PM_MONETARYFUND_RESULT.fundname
  is '基金名称';
comment on column PM_MONETARYFUND_RESULT.typecode
  is '资产类别，字典77012';
comment on column PM_MONETARYFUND_RESULT.yzjz
  is '影子价值（元）';
comment on column PM_MONETARYFUND_RESULT.zjjzcjzdbz
  is '占基金资产净值的比重';
comment on column PM_MONETARYFUND_RESULT.xzjq
  is '修正久期（年）';
comment on column PM_MONETARYFUND_RESULT.dqyzplje
  is '当前影子偏离金额（元）';
comment on column PM_MONETARYFUND_RESULT.gsss_1
  is '估算损失（元）_轻度假设';
comment on column PM_MONETARYFUND_RESULT.ylcshdyzplje_1
  is '压力测试后的影子偏离总额（元）_轻度假设';
comment on column PM_MONETARYFUND_RESULT.gsss_2
  is '估算损失（元）_重度假设';
comment on column PM_MONETARYFUND_RESULT.ylcshdyzplje_2
  is '压力测试后的影子偏离总额（元）_重度假设';
comment on column PM_MONETARYFUND_RESULT.gsss_3
  is '估算损失（元）_极端重度假设';
comment on column PM_MONETARYFUND_RESULT.ylcshdyzplje_3
  is '压力测试后的影子偏离总额（元）_极端重度假设';
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
  is '公共-基准指标信息表';
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
  is '公共-基准指标计算结果';
comment on column PM_QUOTARESULT.benchmarkid
  is '基准ID';
comment on column PM_QUOTARESULT.rundate
  is '计算日期';
comment on column PM_QUOTARESULT.quotacode
  is '指标代码';
comment on column PM_QUOTARESULT.resultvalue
  is '结果值';
comment on column PM_QUOTARESULT.remark
  is '备注';
comment on column PM_QUOTARESULT.updateby
  is '更新人';
comment on column PM_QUOTARESULT.updatetime
  is '更新时间';
alter table PM_QUOTARESULT
  add constraint PK_PM_QUOTARESULT primary key (BENCHMARKID, RUNDATE, QUOTACODE);


spool off
