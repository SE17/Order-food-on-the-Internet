--ʹ�����ݿ�
use OnlineOrderVegetable
go
--������
--�û�����
CREATE TABLE usertype				
(
	usertype_id char(10) not null,		--�û������uty��ͷ
	usertype_name char(4),			--�û��������
	CONSTRAINT PK_UserType PRIMARY KEY(usertype_id)
)
GO
--��վ�û���
CREATE TABLE webuser					--��վ�û���
(
	webuser_id char(10) not null,		--�û����u��ͷ
	usertype_id char(10),				--�û����id
	user_account varchar(50) not null,			--��¼�˺�
	user_pwd VARBINARY(50)  not null,			--����
	user_name nvarchar(20) null,			--�û��ǳ�
	user_sex char(2) null,			--�û��Ա�
	usr_tel char(11) not null,			--�ĳ��ֻ�,11λ
	user_icon varchar(50),
	user_point int default 0,
	reg_time datetime DEFAULT GETDATE() ,				--ע��ʱ��
	bank_card char(19) null,
	balance money null  DEFAULT 0.0,
	pay_pwd varchar(20) null,			--֧������
	CONSTRAINT PK_webuser PRIMARY KEY(webuser_id),
	CONSTRAINT FK_webuser_usertype FOREIGN KEY (usertype_id) REFERENCES usertype(usertype_id),	
)
GO


--��Ʒ����
CREATE TABLE protype
(
	protype_id char(10) not null, --��Ʒ�����pty��ͷ
	protype_name nvarchar(10) not null,	   --��Ʒ�������
	constraint pk_protype primary key(protype_id)
)
GO
--��Ʒ��
CREATE TABLE produce				
(
	pro_id char(10) not null,	--��Ʒ���pro��ͷ
	pro_name nvarchar(20) not null,		--��Ʒ����
	protype_id char(10) not null,			--��Ʒ�����
	pro_price money not null,			--��Ʒ����
	pro_amount int not null,			--��Ʒ���
	pro_icon varchar(50) null,			--��ƷͼƬ
	pro_info ntext null,				--��Ʒ���
	pro_disprice money null,			--��Ʒ�ۿۼ۸�
	collect_num int null  DEFAULT(0),					--�ղ�����
	constraint pk_produce PRIMARY KEY(pro_id),
	constraint fk_produce_produceType foreign key(protype_id) references protype(protype_id),
)
GO
--   �ջ���ַ��
create table useraddress			
(
	address_id char(10) not null,		--�ջ���ַ���
	webuser_id char(10)  not null,		--�û����
	useraddress  nvarchar(100) not null,	--��ϸ��ַ
	constraint pk_address_id  primary key(address_id),
	constraint fk_useraddress_webuser foreign key(webuser_id) references webuser(webuser_id),
	--constraint UX_user_add UNIQUE(webuser_id,useraddress)
)
go
-- ����Ա
CREATE TABLE deliveryMan
(
	del_id char(10) not null, 	--����Ա���del��ͷ
	del_name varchar(10) ,		--����Ա����
	del_telephone char(11) not null,--����Ա�绰
	del_wage money  DEFAULT(0),			--����ԱԤ�Ƶõ��Ĺ���
	CONSTRAINT PK_DEL PRIMARY KEY (del_id),
)
GO
-- �̼ұ�
CREATE TABLE saler			
(
	saler_id char(10) not null,		--�̼��û����sal��ͷ
	saler_account varchar(50) not null,	--�̼ҵ�¼�˺�
	saler_pwd varchar(20) not null,		--�̼ҵ�¼����
	CONSTRAINT PK_saler PRIMARY KEY (saler_id),
)
GO
--   ������
CREATE table orders		 
(
	order_id  char(10) not null,				--�������ord��ͷ
	webuser_id  char(10)  not null,				--�û����
	order_time datetime not null default (getdate()),				--����ʱ��
	order_sum  money   not null,				--�����ܼ�
	address_id char(10) not null,				--����״̬
	order_state char(6) not null,				--���ͷ�
	del_money money null default(0),			--����Ա���
	del_id char(10) null,					--����ʱ��
	del_time datetime null,					--�ʹ�ʱ��
	rec_time datetime null, 
	constraint pk_order_id primary key(order_id),
	constraint fk_orders_user  foreign key(webuser_id) references webuser(webuser_id),
	constraint fk_orders_address foreign key(address_id) references useraddress(address_id),
	constraint ck_order_state check(order_state in ('������','������','���ջ�','������','������')),
)
go


--������ϸ��
create table orderinfo		
(	
	order_id char(10) not null,		--�������ord��ͷ
	pro_id char(10) not null,		--��Ʒ���pro��ͷ
	order_amount int not null,		--����Ʒ����������
	return_goods bit null  default(0) ,		--�Ƿ������˻�
	refund bit null  default(0) ,			--�Ƿ������˿�
	constraint pk_orderinfo primary key(pro_id,order_id),
	constraint fk_orderinfo_order foreign key(pro_id) references produce(pro_id),
	constraint fk_orderinfo_produce foreign key(pro_id) references produce(pro_id),
)
go
--�ղر�
CREATE TABLE collect
(
	collect_id char(10) not null,	--�ղر��col��ͷ
	webuser_id char(10),		--�û����u��ͷ
	pro_id char(10),		--��Ʒ���
	collect_time datetime default (getdate()),		--�ղ�ʱ��
	constraint pk_collect_id primary key(collect_id),
	constraint fk_collect_webuser foreign key (webuser_id) references webuser(webuser_id),
	constraint fk_collect_produce foreign key (pro_id) references produce(pro_id),	
	constraint UX_collect_user_pro UNIQUE(webuser_id,pro_id),
)
GO
drop table comment
go
--���۱�
create table comment
(
	com_id char(10) not null,	--���۱��com��ͷ
	order_id char(10) not null,		--�������
	pro_id char(10) not null,		--��Ʒ���
	webuser_id char(10) not null,	--�û����
	com_time datetime not null default (getdate()) ,	--����ʱ��
	com_message ntext not null default('default review'),	--������Ϣ
	com_pic varchar(50) null,	--����ͼƬ
	com_score int null default(5),		--��Ʒ��֣�Ĭ��5�ǣ�����5�ǡ�
	com_seq int not null,		--���۴���,��Ҫһ�����������ж����״����ۻ���׷�����ۡ�
	constraint pk_comment primary key(com_id),
	constraint fk_comment_webuser foreign key(webuser_id) references webuser(webuser_id),
	constraint fk_comment_produce foreign key(pro_id) references produce(pro_id),
)
go 

-- �̼һظ���
CREATE TABLE saler_reply		
(
	com_id char(10)	not null,	--���۱��com��ͷ
	saler_id char(10) not null,	--�̼��û����sal��ͷ
	reply_time datetime  null DEFAULT(GETDATE()),	--�ظ�ʱ��
	reply_context varchar(200) null  DEFAULT('DEFAULT REPLY '),--�ظ�����
	CONSTRAINT PK_SALER_REPLY PRIMARY KEY(com_id,saler_id),
	CONSTRAINT FK_REPLY_COM FOREIGN KEY (com_id) REFERENCES COMMENT(com_id),
	CONSTRAINT FK_REPLY_SALER FOREIGN KEY (saler_id ) REFERENCES saler(saler_id ),
)
GO
-- �ۺ��
CREATE TABLE sale_back			
(
	saler_id char(10) not null,	--�����ۺ��̼ҵı��
	pro_id char(10) not null,	--��Ʒ���
	order_id char(10) not null,	--�������
	deal_time datetime not null DEFAULT(GETDATE()),	--�������ʱ��
	refund_money money not null,	--�˿���
	CONSTRAINT PK_sale_back PRIMARY KEY(saler_id,pro_id,order_id),
	CONSTRAINT FK_BACK_SALER FOREIGN KEY (saler_id ) REFERENCES saler(saler_id),
	CONSTRAINT FK_BACK_PRODUCE FOREIGN KEY (pro_id ) REFERENCES produce(pro_id ),
	CONSTRAINT FK_BACK_ORDER FOREIGN KEY (order_id ) REFERENCES orders(order_id ),
)
GO
