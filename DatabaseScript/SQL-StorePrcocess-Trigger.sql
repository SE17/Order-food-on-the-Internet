use OnlineOrderVegetable
go 
--�˿Ͳ���
--�洢����:proc_WebUserInsert
--���ܣ�ʵ���û�ע�ᣬ���û����뾭��MD5���ܺ�������ݿ⡣
--����������û��˺š����롢�û������Ա���ϵ�绰
--�����������
--����ֵ��1��ע��ɹ� 2���˺��Ѵ���  
ALTER PROC proc_WebUserInsert
@user_account varchar(50),
@user_pwd varchar(20),
@user_name nvarchar(20),
@user_sex char(2),
@user_tel char(11)
AS
BEGIN
	--����Ƿ���ڸ�ע���
	IF(EXISTS (SELECT *
				FROM webuser
				WHERE user_account = @user_account))
	BEGIN
		PRINT '�˺��Ѵ���!'
		RETURN 2
	END
	ELSE 
	BEGIN
		--DECLARE @counts INT;
		DECLARE @webuser_id CHAR(10)
		DECLARE @maxID char(10)
		SELECT @maxID=max(webuser_id)
		FROM webuser;
		PRINT 'maxID:'+@maxID
		SET @webuser_id ='u'+CAST((SUBSTRING(@maxID,2,9)+1) AS CHAR(9))
		INSERT INTO webuser(webuser_id,usertype_id,user_account,user_pwd,user_name,user_sex,usr_tel) 
			VALUES (@webuser_id,'uty1000001',@user_account,@user_pwd,@user_name,@user_sex,@user_tel)
		PRINT 'ע��ɹ�!'
		RETURN 1		
	END
END
GO
--��������
--�û�ע�Ὺʼ
EXEC proc_WebUserInsert '12389099765','123456','������','��','13909877890'
GO
EXEC proc_WebUserInsert '12389099770','12345678','��˼','��','16389099765'
GO
--�洢����: proc_WebUserSelectLogin
--���ܣ��û���¼��ʹ��PWDCOMPARE�����ȶ���������������ݿ��о������ܵ��Ƿ�һ�¡�
--����������û��˺š�����
--����������û����
--����ֵ��1:��¼�ɹ� 2���û������� 3���������
ALTER PROC proc_WebUserSelectLogin
@account varchar(50),
@pwd varchar(20),
@webuser_id char(10) output
AS
BEGIN
	IF(NOT EXISTS(SELECT *
					FROM webuser
					WHERE @account = user_account))
	BEGIN 
		PRINT '�û�������'
		RETURN 2
	END
	ELSE 
	BEGIN
		IF(EXISTS( SELECT *
					FROM webuser
					WHERE @account = user_account
					AND @pwd = user_pwd
					))
		BEGIN
			SELECT @webuser_id = webuser_id
			FROM webuser 
			WHERE @account = user_account
			PRINT '��¼�ɹ�'
			RETURN 1
		END
		ELSE
		BEGIN	 
			PRINT '�������'
			RETURN 3
		END
	END
END
GO
--��������
declare @result varchar(20)
EXEC proc_WebUserSelectLogin '15606091036','123456',@result output
go
declare @result varchar(20)
EXEC proc_WebUserSelectLogin '16389099765','123456',@result output
go
declare @result varchar(20)
EXEC proc_WebUserSelectLogin '16389099765','1111111',@result output
go
--�洢���̣�proc_ProduceSelect
--���ܣ����������Ʒ 
--�����������Ʒ����š������ֶΡ��������
ALTER PROC proc_ProduceSelect
@protype_id char(10)=NULL,
@order_name varchar(10)=NULL,
@order_type varchar(10)='ASC'
AS
BEGIN
	DECLARE @sql varchar(255)
	IF(@order_name IS NULL)
	BEGIN
		SELECT pro_id ,pro_name ��Ʒ����,protype_name ��Ʒ���,pro_icon ��ƷͼƬ,pro_price ��Ʒ�۸�,pro_disprice ������,pro_amount ��Ʒ����,collect_num �ղش���
		FROM produce INNER JOIN protype 
		ON produce.protype_id = protype.protype_id
		WHERE (@protype_id = produce.protype_id OR @protype_id IS NULL)
	END
	ELSE
	BEGIN
		SET @sql = 'SELECT pro_id ��Ʒ���,pro_name ��Ʒ����,protype_name ��Ʒ���,pro_icon ��ƷͼƬ,pro_price ��Ʒ�۸�,pro_amount ��Ʒ����
		FROM produce INNER JOIN protype '+
		'ON produce.protype_id = protype.protype_id '+
		'WHERE ( produce.protype_id '+'LIKE '+@protype_id +' )'
		+' ORDER BY '+@order_name+' '+@order_type
		EXEC(@sql)
	END
END
GO
--�������ݣ��������ȱʡ
EXEC proc_ProduceSelect 'pty1000001'
GO
--�������ȱʡΪ����
EXEC proc_ProduceSelect 'pty1000002','pro_price'
GO
--
EXEC proc_ProduceSelect 'pty1000002','pro_price','DESC'
GO

--�洢���̣�proc_ProduceNameSelect
--���ܣ�������Ʒ���֣�ģ��ƥ��
--����������ؼ���
--���������
--����ֵ�������Ʒ��¼
CREATE PROC proc_ProduceNameSelect
@key varchar(20)
AS
BEGIN
	DECLARE @indexWord varchar(20)
	SET @indexWord= '%'+@key+'%'
	IF((not exists (SELECT *
					FROM  produce
					WHERE pro_name LIKE @indexWord)))
	BEGIN
		PRINT '����ؼ�¼��'
		RETURN 0
	END
	ELSE
	BEGIN
		SELECT pro_id,pro_name ��Ʒ����,pro_price ��Ʒ�۸�,pro_icon ��ƷͼƬ,pro_amount ��Ʒ���� 
		FROM produce
		WHERE pro_name LIKE @indexWord
		RETURN 1
	END
END
GO
--��������
EXEC proc_ProduceNameSelect 'Ϻ'
GO
EXEC proc_ProduceNameSelect '1'
GO
EXEC proc_ProduceNameSelect '33'
GO
--�洢���̣�proc_ProduceIdSelect
--���ܣ��鿴��Ʒ����
--�����������Ʒ���
--��������������Ʒ��¼
--����ֵ��0��û�ҵ���1���ҵ�
CREATE PROC proc_ProduceIdSelect
@pro_id char(10)
AS
BEGIN
	IF(NOT EXISTS (SELECT *
					FROM produce
					WHERE pro_id = @pro_id))
	BEGIN
		PRINT 'û�ҵ�'
		RETURN 0
	END
	ELSE
	BEGIN
		SELECT pro_id ��Ʒ���,pro_name ��Ʒ����,pro_price ��Ʒ�۸�,pro_amount ��Ʒ����,pro_info ��Ʒ���,collect_num �ղش���
		FROM produce
		WHERE @pro_id = pro_id
		RETURN 1
	END
END
GO
EXEC proc_ProduceIdSelect pro1000001
GO
EXEC proc_ProduceIdSelect pro1002222
GO
--�洢���̣�proc_OrdersInsert
--���ܣ����ɶ�����Ĭ������Ϊ2Ԫ
--����������û���ţ��ջ���ַ���
--����������������
--����ֵ��0��û���ջ���ַ��1�����ɶ���
ALTER PROC proc_OrdersInsert
@webuser_id char(10)=NULL,
@address_id char(10)=NULL,
@order_id char(10)=NULL OUTPUT
AS
BEGIN	
	IF(@address_id IS NULL)
	BEGIN
		PRINT 'û���ջ���ַ��'
		RETURN 0
	END
	ELSE
	BEGIN
		DECLARE @ord_id CHAR(10)
		DECLARE @maxID char(10)
		SELECT @maxID=ISNULL(max(order_id),1000000)
		FROM orders
		--PRINT 'maxID:'+@maxID
		SET @ord_id ='ord'+CAST((SUBSTRING(@maxID,4,7)+1) AS CHAR(7))
		INSERT INTO orders(order_id,webuser_id,order_sum,address_id,order_state,del_money) values(@ord_id,@webuser_id,2,@address_id,'������',2)	
		SET @order_id = @ord_id
		RETURN 1		
	END	
END
GO
--
DECLARE @order_id char(10) 
EXEC proc_OrdersInsert u100000001,add1000002,@order_id OUTPUT
PRINT '������ţ�'+@order_id
GO
--�������û�2��һ�����������ض�����Ÿ��û�
DECLARE @order_id int 
EXEC proc_OrdersInsert 2,8,@order_id OUTPUT
PRINT '������ţ�'+CAST(@order_id AS VArchar(4))
GO
DECLARE @order_id int 
EXEC proc_OrdersInsert 3,6,@order_id OUTPUT
PRINT '������ţ�'+CAST(@order_id AS VArchar(4))
GO

--�洢���̣�proc_OrdersInfoInsert
--���ܣ����ɶ�����ϸ
--���������������ţ���Ʒ���,��Ʒ����
--���������
--����ֵ��0����治�㣬���ɶ���ʧ�ܣ�1�����ɶ����ɹ�
CREATE PROC proc_OrdersInfoInsert
@order_id char(10),
@pro_id char(10),
@order_amount int
AS
BEGIN
	DECLARE @amount int
	SELECT @amount = pro_amount
	FROM produce 
	WHERE pro_id = @pro_id 
	IF(@order_amount > @amount )
	BEGIN
		PRINT '��治�㣡���ɶ���ʧ�ܣ�'
		DELETE FROM 
		orderinfo
		WHERE order_id = @order_id 
		DELETE FROM
		orders
		WHERE order_id = @order_id 
		RETURN 0
	END
	ELSE
	BEGIN
		INSERT INTO orderinfo(order_id,pro_id,order_amount) VALUES(@order_id,@pro_id,@order_amount)
		RETURN 1
	END
END
GO
--��ѯ��Ʒ
EXEC proc_ProduceSelect
GO
--�ڸ��ݶ�����źͶ����е���Ʒϵͳ�Զ����ɶ�����ϸ
--a.������ĳ����Ʒ��治�㣬��ɾ���ö�����
EXEC proc_OrdersInfoInsert ord1000011,pro1000001,3
GO
--b.��24�Ŷ������1��1����Ʒ��4��2����Ʒ
--����Ʒ���۳�����С��20�������Ա�������ѣ�
EXEC proc_OrdersInfoInsert ord1000028,8,11
GO
EXEC proc_OrdersInfoInsert 29,6,25
GO
EXEC proc_OrdersInfoInsert 30,10,5
GO
--�洢���̣�proc_OrderIdSelect
--���ܣ��û��鿴ĳ������
--����������������
--����������ö�����ϸ��
--����ֵ��0�����Ҷ���ʧ�ܣ�1�����Ҷ����ɹ�
CREATE PROC proc_OrderIdSelect
@order_id char(10)
AS
BEGIN
	IF(NOT EXISTS (SELECT *
					FROM orders
					WHERE order_id= @order_id ))
	BEGIN
		PRINT 'û�иö�����'
	END
	ELSE
	BEGIN
		SELECT a.order_id ,b.pro_id ,pro_name ��Ʒ����,pro_price ��Ʒ����,order_amount ��Ʒ����,order_sum �����ܼ�,order_time ����ʱ��,order_state ����״̬
		FROM orders a INNER JOIN orderinfo b
		ON a.order_id = b.order_id 
		INNER JOIN produce p
		ON b.pro_id = p.pro_id
		WHERE a.order_id = @order_id 
	END
END
GO
--�鿴�ö���
EXEC proc_OrderIdSelect ord1000011
GO
--�����ɸ��û��Ķ���������״̬Ĭ��Ϊ�������
EXEC proc_OrderIdSelect ord1000011
GO
--�洢���̣�proc_OrdersStateSelect
--���ܣ��鿴�û��ĸ���״̬�Ķ����б�
--����������û���š�����״̬
--��������������б�
--����ֵ��0��û����ض�����1�����ڶ���
CREATE PROC proc_OrdersStateSelect
@webuser_id char(10),
@order_state char(6)=NULL
AS
BEGIN
	IF(NOT EXISTS(SELECT *
					FROM orders
					WHERE webuser_id = @webuser_id))
	BEGIN
		PRINT 'û����ض���'
		RETURN 0
	END
	ELSE
	BEGIN		
		SELECT DISTINCT a.order_id �������,pro_name ��Ʒ����,order_amount ��Ʒ���� ,order_sum �����ܼ�, order_state ����״̬
		FROM orders a,orderinfo b,produce p
		WHERE a.order_id = b.order_id
		AND b.pro_id = p.pro_id
		AND	a.webuser_id = @webuser_id
		--Ĭ��@order_stateΪ��ֵ����ʾȫ��������
		AND (order_state = @order_state OR @order_state IS NULL)
		ORDER BY a.order_id
		RETURN 1
	END		
END
GO
--
EXEC proc_OrdersStateSelect u100000001,'������'
GO
EXEC proc_OrdersStateSelect u100000002
GO
EXEC proc_OrdersStateSelect 3,'������'
GO
EXEC proc_OrdersStateSelect u100000003
GO
--�洢���̣�proc_OrderStateUpdatePay
--���ܣ��û�Ϊĳ�������������
--���������������ţ��û����
--�����������
--����ֵ��0������ʧ�ܣ�����״̬�������1������ɹ�������״̬�������͡�
ALTER PROC proc_OrderStateUpdatePay
@order_id char(10),
@webuser_id char(10),
@result varchar(20) OUTPUT
AS
BEGIN
	DECLARE @requireMoney money
	SELECT @requireMoney = order_sum
	FROM orders
	WHERE order_id = @order_id
	IF(@requireMoney > (SELECT balance 
						FROM webuser 
						WHERE webuser_id = @webuser_id))
	BEGIN 
		SET @result = '����'
		PRINT @result
		RETURN 0
	END
	ELSE
	BEGIN
		IF((SELECT order_state
		FROM orders
		WHERE @order_id = order_id
		AND webuser_id = @webuser_id)!='������')
		BEGIN
			PRINT '�ö����Ѹ���!' 
			RETURN 0
		END
		ELSE
		BEGIN
			UPDATE orders
			SET order_state = '���ջ�'
			WHERE order_id = @order_id
			SET @result = '����ɹ�'
			PRINT @result
			RETURN 1
		END		
	END
END
GO
--���û���24�Ŷ�������۳��û����
--����ǰ���û��˺�������
EXEC proc_WebuserSelect '15985700852'
GO
--������
DECLARE @result varchar(20)
EXEC proc_OrderStateUpdatePay ord1000011,u100000001,@result OUTPUT
PRINT @result
GO
--������û��˺�������
EXEC proc_WebuserSelect '15985700852'
GO
DECLARE @result varchar(20)
EXEC proc_OrderStateUpdatePay 17,2,@result OUTPUT
PRINT @result
GO
--�洢���̣�proc_OrderStateUpdateReceive
--���ܣ��ջ��������û���ĳ�����������ջ�
--����������������
--�����������
--����ֵ��
CREATE PROC proc_OrderStateUpdateReceive
@order_id char(10)
AS
BEGIN
	IF((SELECT order_state
		FROM orders 
		WHERE @order_id = order_id )='���ջ�')
	BEGIN
		PRINT '�ɹ��յ�'+ @order_id +'�Ŷ������ö����ȴ���������~'
		UPDATE orders
		SET order_state = '������'
		WHERE order_id = @order_id 	
	END
	ELSE
	BEGIN
		PRINT '�ö��������ڴ��ջ�״̬��'
	END
	
END
GO
--�鿴����
EXEC proc_OrdersStateSelect u100000001
GO
--���û�ȷ���ջ�����24��
EXEC proc_OrderStateUpdateReceive ord1000011
GO
-----------------------------------------------1-���-------------------------------------------------------
--�洢���̣�proc_OrderStateUpdateComment
--���ܣ��û�������Ʒ����
--�����������Ʒ��š�������š���������
--���������
--����ֵ��
ALTER proc proc_OrderStateUpdateComment
@procduce_id char(10),
@order_id char(10),
@webuser_id char(10),
@com_text ntext
as
begin
     declare @counts int;
	 declare @maxID varchar(20)
	 declare @com_id char(10);
	 declare @com_seq int
	 select @maxID=max(com_id)
	 from comment;
	 set @com_id='com'+cast (substring(@maxID,4,7)+1 as char(7)) 
	 IF(EXISTS (SELECT *
				FROM comment
				WHERE order_id =  @order_id
				AND pro_id = @procduce_id
				AND webuser_id = @webuser_id))
	BEGIN
		SET @com_seq = 2;
	END
	ELSE
	BEGIN
		SET @com_seq = 1;
	END
     insert into comment(com_id,order_id,pro_id,webuser_id,com_message,com_seq)
	 values(@com_id,@order_id,@procduce_id,@webuser_id,@com_text,@com_seq)
	  PRINT '��л���ı�������~��ӭ�ع���'
end 

--��2���û��Ըղ��յ���24�Ŷ�������Ʒ��������
--��2����Ʒ������
exec proc_OrderStateUpdateComment pro1000001,ord1000011,u100000001,"ʳ��������ζ������ع��ġ�"
GO
--����Ʒ������
exec proc_OrderStateUpdateComment pro1000005,ord1000008,"ζ��һ��ɡ�"
GO
select *
from comment
select *
from orders

go
-------------------------------------------------2--���-------------------------------------------------------
--�洢���̣�proc_CollectInsert
--���ܣ��ղ���Ʒ
--�����������Ʒ��š��û����
--���������
--����ֵ��
ALTER proc proc_CollectInsert
@pro_id char(10),
@webuser_id char(10)
as
begin
	 declare @maxID varchar(20);
	 declare @col_id char(10);
	 select @maxID=ISNULL(MAX(collect_id),'col1000000')
	 from collect;
	 set @col_id='col'+cast(SUBSTRING(@maxID,4,7)+1 as char(7))
     insert into collect(collect_id,pro_id,webuser_id)
	 values(@col_id,@pro_id,@webuser_id)
	 PRINT '�ɹ��ղ�'+@pro_id+'����Ʒ!'
end
go
--�����û�ϲ����һ����Ʒ�����Զ���Ʒ�����ղ�
--2���û���2����Ʒ�������ղ�
exec proc_CollectInsert pro1000006,u100000002
select *
from collect
go
--�洢���̣�proc_CollectSelect
--���ܣ��鿴�û��ղص���Ʒ
--����������û��˺�
--����������û��ղ���Ϣ��ؼ�¼
--����ֵ��
ALTER PROC proc_CollectSelect
@webuser_id char(10)
AS
BEGIN
	SELECT collect.pro_id,pro_name ��Ʒ����,pro_icon ��ƷͼƬ,pro_price ��Ʒ�۸�
	FROM collect INNER JOIN produce
	ON COLLECT.pro_id = produce.pro_id
	WHERE webuser_id = @webuser_id
END
GO
--��������
EXEC proc_CollectSelect 'u100000001'
GO
------------------------------------------------3--���------------------------------------------------
--�洢���̣�proc_WebuserSelect
--���ܣ��鿴�û���Ϣ
--����������û��˺�
--����������û���Ϣ��ؼ�¼
--����ֵ��
CREATE proc proc_WebuserSelect
@account varchar(50)
as
begin
     select webuser_id �û����,user_account ��¼�˺�,user_name �û����� ,usertype_name �û����,user_sex �Ա�,usr_tel �绰,Balance �˻����
	 from webuser INNER JOIN usertype
	 ON webuser.usertype_id = usertype.usertype_id
	 where user_account=@account
end
go
--�û��鿴������Ϣ
exec proc_WebuserSelect "13255900215"


------------------------------------------------4--���--------------------------------------
--�洢���̣�proc_WebuserUpdate
--���ܣ��޸��û���Ϣ
--����������û������Ա���ϵ�绰���û����
--���������
--����ֵ��
ALTER proc proc_WebuserUpdate
@account varchar(50),
@user_name nvarchar(20),
@user_sex char(2),
@user_tel char(11)
as
begin
     update webuser
     set user_name=@user_name,user_sex=@user_sex,Usr_tel=@user_tel
     where user_account=@account
end
go
exec proc_WebuserUpdate '13255900215','����','��','18790987652'
go
exec proc_WebuserSelect '13255900215'
select *
from webuser

---------------------------------------------------5--���--------------------------------
--�洢���̣�proc_AddressForWebuserIdSelect
--���ܣ��û��鿴���˵��ջ���ַ
--����������û����
--�����������ַ�б�
--����ֵ��0��û���ջ���ַ��������ʾ��1�����ջ���ַ
drop proc proc_AddressForWebuserIdSelect
create proc proc_AddressForWebuserIdSelect
@webuser_id char(10)
as
begin
   if exists (select addresss  from useraddress where webuser_id=@webuser_id )
      begin
        select address_id as �ջ���ַ���,addresss as �ջ���ַ
        from useraddress
        where webuser_id=@webuser_id
        return 1 
      end
   else
      begin 
		print'û���ջ���ַ'
        return 0
      end
end
GO
--���û��鿴���˵��ջ���ַ
exec proc_AddressForWebuserIdSelect  'u000000001'
GO
exec proc_AddressForWebuserIdSelect  'u000000002'
GO

------------------------------------------------------6--���-----------------------------------
--�洢���̣�proc_AddressIdSelect
--���ܣ��鿴ĳһ�������ջ���ַ��Ϣ
--����������������
--�����������ַ��Ϣ
--����ֵ��
alter proc proc_AddressIdSelect
@order_id char(10)
as
begin
     select addresss �ջ���ַ
	 from orders , useraddress
	 where useraddress.address_id=orders.address_id and order_id=@order_id 
end
GO
exec proc_AddressIdSelect "ord0000001"
GO

-------------------------------------------------------7--���-----------------------------------------------------

--�洢���̣�proc_AddressInsert
--���ܣ�����ջ���ַ
--����������û���š���ַ��Ϣ
--�����������
--����ֵ��0����ַ�ظ����޷����룬1����ӳɹ�
alter proc proc_AddressInsert
@webuser_id char(10),@addresss nvarchar(100)
as
begin
     declare @counts int;
	 declare @add_id char(10);
	 select @counts=(count(address_id)+1)
	 from useraddress;
	 set @add_id='add'+cast (@counts as char(7))

    if exists( select * from useraddress where webuser_id=@webuser_id and addresss=@addresss)
	begin
	   print '�õ�ַ�ظ����޷�����'
	   return 0
	end 
	else
	begin
	    insert into useraddress(address_id,webuser_id,addresss)
		values(@add_id,@webuser_id,@addresss)
		print'����ջ���ַ�ɹ�'
		return 1
	end
end
GO
--��������
--���û�������Ϊ�Լ�����ջ���ַ�����ǲ���Ϊ�Լ�����ظ��ĵ�ַ��
EXEC proc_AddressInsert 'u000000001','����ʡ�����м�����ѧ�ֻ�����ѧԺ'
GO
select *
from useraddress

-------------------------------------------8--���-----------------------------------------------------------

--�洢���̣�proc_AddressUpdate
--���ܣ�ĳһ�û��޸���ĳһ��ַ����
--�����������ַ���,��ַ��Ϣ
--�����������
--����ֵ��0��û���޸ģ�1���޸ĳɹ�
alter proc proc_AddressUpdate
@address_id char(10),@addresss nvarchar(100)
as
  begin
  if exists (select * from useraddress where address_id=@address_id and addresss=@addresss)
     begin
	 print 'û���޸�!'
	 return 0
	 end
  else 
     begin 
	 update useraddress
	 set addresss=@addresss
	 where address_id=@address_id
	end 
  end
  go
exec proc_AddressUpdate "add0000001","�����г�����"
select *
from useraddress
----------------------------------------------------9--���----------------------------------------------------
--�洢���̣�proc_AddressDelete
--���ܣ�ɾ���ջ���ַ
--�����������ַ���
--���������
--����ֵ��0���޷�ɾ�� 1��ɾ���ɹ�
create proc proc_AddressDelete
@address_id char(10)
as
begin
     if exists (select * from useraddress as a,orders as o where a.address_id=@address_id and a.address_id=o.address_id)
	BEGIN
		 print '�õ�ַ����ʹ�ã��޷�ɾ��!'
		 RETURN 0
	 END
	 else
	 begin 
		delete from useraddress where address_id=@address_id
		Print 'ɾ���ɹ���'
		RETURN 1
	 end
end  
--��ɾ��������Ҫ�ĵ�ַ������õ�ַ����ʹ�ã����޷�ɾ����
exec proc_AddressDelete add0000001
GO
exec proc_AddressDelete add0000011
GO
SELECT *
FROM useraddress
GO 
-------------------------------------------------------10--���-------------------------------------------
--�洢���̣�proc_WebuserAccountMoneyUpdate
--���ܣ��û���ֵ
--����������û���š���ֵ���
--�����������
--����ֵ��0����ֵʧ�ܣ�1����ֵ�ɹ�
alter proc proc_WebuserAccountMoneyUpdate
@webuser_id char(10),@money money
as
begin
	DECLARE @account_money money
	if exists (select * from webuser where webuser_id=@webuser_id)
	begin
		update webuser
		set Balance=Balance+@money,@account_money = Balance
		where webuser_id=@webuser_id
		print '��ֵ�ɹ�!'
		print '��ֵǰ�˻����Ϊ��'+CAST(@account_money AS VARCHAR(8))
		return 1
		end
	else
	BEGIN
		print '���û������ڣ���ֵʧ��!'
		RETURN 0
	END  
end
go

--��2���û��˺ų�ֵ1000Ԫ
exec proc_WebuserAccountMoneyUpdate "u000000007","1000"
--
exec proc_WebuserAccountMoneyUpdate "u000000005","2000"
--�鿴���
select *
from webuser


---------------------------------------------------������-----------------------------------------------------------
--������tri_orderinfoInsert_UpdateOrders
--����orderinfo
--�����¼�������
--����:���붩����ϸʱ�����¶����ܽ�� 
CREATE TRIGGER tri_orderinfoInsert_UpdateOrders
ON orderinfo FOR INSERT
AS
BEGIN
	DECLARE @usertype_id char(10)  
	--�����û����
	SELECT @usertype_id = usertype_id
	FROM webuser w INNER JOIN orders o
	ON w.webuser_id = o.webuser_id
	INNER JOIN inserted i
	ON  i.order_id = o.order_id	
	--���¶������,�����û������㶩�����
	UPDATE orders
	SET order_sum = CASE @usertype_id
					WHEN 'uty1000001' THEN ISNULL(order_sum,0) + pro_price*order_amount 
					WHEN 'uty1000002' THEN ISNULL(order_sum,0) + pro_price*order_amount*0.85
					END 
	FROM inserted i INNER JOIN produce p
	ON i.pro_id = p.pro_id	
	INNER JOIN orders o
	ON o.order_id = i.order_id
END
GO
--������tri_orderinfoInsert_UpdateProduce
--����orderinfo
--�����¼������롢
--����:���붩����ϸʱ��������Ʒ��档
CREATE TRIGGER tri_orderinfoInsert_UpdateProduce
ON orderinfo FOR INSERT
AS
BEGIN
	--������Ʒ�Ŀ��
	UPDATE produce
	SET pro_amount = pro_amount - order_amount
	FROM inserted INNER JOIN produce
	ON inserted.pro_id = produce.pro_id
END
GO
--������tri_produceUpdate
--����produce
--�����¼������¿��
--����:������Ʒ��棬�����Ʒ����Ƿ�С������20,С��20�������̼ҽ�����
ALTER TRIGGER tri_produceUpdate
ON  produce FOR UPDATE
AS
BEGIN
	DECLARE @pro_amount INT
	IF(UPDATE(pro_amount))
	BEGIN
		SELECT @pro_amount = pro_amount
		FROM inserted 
		IF(@pro_amount<20)
		BEGIN
			PRINT '��治����20�����뾡�����'
		END	
		IF(@pro_amount>500)	
		BEGIN
			PRINT '������500������ע����Ʒ�����ڣ�'
		END
	END		
END
GO
--������tri_ordersUpdate1
--����orders
--�����¼����޸�
--����:�޸Ķ���״̬ʱ��ͳ���û����Ǵ�����״̬�����������޸��û�����
ALTER TRIGGER tri_ordersUpdate1
ON orders FOR UPDATE
AS
BEGIN
	DECLARE @orderCnt int
	IF(UPDATE(order_state))
	BEGIN
		--����Ӵ�����״̬��ɸ���״̬����ͳ�Ƹ��û��Ķ�������
		IF((SELECT order_state
			FROM inserted)='������' AND (SELECT order_state
										FROM deleted)='������')
		BEGIN
			SELECT @orderCnt = (SELECT COUNT(*)
								FROM orders o INNER JOIN inserted i
								ON o.webuser_id = i.webuser_id
								WHERE o.order_state !='������')
			--����û�����������10�����������û��ȼ�
			IF(@orderCnt >=10)
			BEGIN
				UPDATE webuser
				SET usertype_id = 'uty0000002'
				FROM inserted i INNER JOIN webuser w
				ON i.webuser_id  = W.webuser_id
			END				
		END
	END	
END
GO
--������tri_orderStateUpdate2
--����orders
--�����¼����޸ġ�
--����:����֮���޸Ķ���״̬Ϊ������ʱ���޸��û���
ALTER TRIGGER tri_orderStateUpdate2
ON orders FOR UPDATE
AS
BEGIN
	IF(UPDATE(order_state))
	BEGIN
		--����Ӵ�����״̬��ɴ�����״̬���޸��û���
		IF((SELECT order_state
			FROM inserted)='������' AND (SELECT order_state
										FROM deleted)='������')
		BEGIN
			UPDATE webuser
			SET account_money = account_money - order_sum
			FROM webuser w INNER JOIN inserted i
			ON 	w.webuser_id = i.webuser_id 
		END
	END	
END
GO
-----------------------------------------------------1----���----------------------------------------------------------
--������tri_commentInsert
--����comment
--�����¼�������
--����:�������ۼ�¼ʱ���޸ĸö���״̬��
alter trigger tri_commentInsert
on comment after insert
as
begin
     declare @order_id char(10)
     select @order_id=order_id
	 from inserted

     update orders
	 set order_state='������'
	 where order_id=@order_id
end
go
----------------------------------------------------2----------------------------------------------------
--������tri_collectInsert
--����collect
--�����¼������롢
--����:�����ղؼ�¼ʱ��ͳ����Ʒ�ղش������޸�collect_num��ֵ��
alter trigger tri_collectInsert
on collect after insert
as
begin
     declare @pro_id char(10),@count int
	 select @pro_id=pro_id
	 from inserted
	 select @count=count(*)
	 from collect
	 group by pro_id
	 having pro_id=@pro_id
	 update produce
	 set collect_num=@count
	 where pro_id=@pro_id
end
go
-----------------------------------------------------3-------------------------------------------------------
--������tri_orderStateUpdate3
--����orders
--�����¼�������
--����:�޸Ķ���״̬Ϊ������ʱ����������Ա�Ĺ��ʡ�
alter trigger tri_orderStateUpdate3
on orders after update
as
begin
     declare @orders_id char(10),@del_money money,@del_id char(10)
	 select @orders_id=order_id,@del_money=del_money,@del_id=del_id
	 from inserted
	 IF((SELECT order_state
			FROM inserted)='������' AND (SELECT order_state
										FROM deleted)='���ջ�')
	 BEGIN
		 update deliveryman
		 set del_wage=del_wage+@del_money
		 where del_id=@del_id
	 END
end 
GO
------------------------------------------------------------4---------------------------------------------
--������tri_recommand_produce
--����: orders
--�����¼�������
--����:�鿴���ж�����¼���ҳ����ж�����ϸ��,�ҳ�������ϸ�й�������ǰ2����Ʒ�����࣬���û������Ƽ�
alter trigger tri_recommand_produce
on orders after UPDATE
as
begin
	declare @webuser_id char(10)
	select @webuser_id=webuser_id
	from inserted
	IF(UPDATE(order_state))
	BEGIN
	--����Ӵ�����״̬��ɴ�����״̬�����û��Ƽ���Ʒ
		IF((SELECT order_state
			FROM inserted)='������' AND (SELECT order_state
										FROM deleted)='������')
		begin
			select '�Ƽ�������Щ��Ʒ��',produce.*
			from produce
			where protype_id in (select top 2 protype_id
								from  orders as a,orderinfo as b,produce as c
								where a.order_id=b.order_id 
								and webuser_id=@webuser_id  
								and b.pro_id =c.pro_id
								group by b.pro_id,protype_id
								order by sum(order_amount) desc)
		end
	end
end 
go

