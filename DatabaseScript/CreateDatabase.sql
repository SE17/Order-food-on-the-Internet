--�������ݿ�
CREATE DATABASE OnlineOrderVegetable
   ON  PRIMARY  --Ĭ�Ͼ�����PRIMARY���ļ��飬��ʡ��
(
	 NAME='OnlineOrderVegetable',  --�������ļ����߼���
	 FILENAME='E:\SoftwareProject\teamwork\datafile\OnlineOrderVegetable.mdf', 
				 --�������ļ���������
	 SIZE=50mb,			--�������ļ���ʼ��С 
	 FILEGROWTH=20%		--�������ļ���������
)
LOG ON
(
  NAME='OnlineOrderLog',
  FILENAME='E:\SoftwareProject\teamwork\datafile\OnlineOrderLog.ldf',
  SIZE=10mb,
  MAXSIZE=50MB,
  FILEGROWTH=10MB
)
GO