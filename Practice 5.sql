--Hien thi cac sach co ngay muon la nam 2026
select * from borrows where extract(year from borrow_date)=2026

--TRUY VAN NANG CAO
SELECT * FROM authors;

SELECT author_id,author_name,CASE gender WHEN true THEN 'Nam' WHEN false THEN 'Nữ' END AS gender, birthday,address
FROM authors;

--Su dung count de dem
SELECT COUNT(*) AS "Số tác giả"
FROM authors;

--Su dung inner join (hay join): Goi la join bang
--Gia tri phai bang nhau o cot chung cua hai bang lien ket
/*
	Syntax: 
	
	SELECT tb1.column1, tb1.column2, tb2.column1, tb2.column2
	FROM table1 AS tb1 JOIN table2 AS tb2
	ON tb1.column_join = tb2.column_join;

*/

/*Yeu cau truy van: Hien thi thong tin cac sach muon cua tat ca moi nguoi, thong tin gom:
Ma nguoi muon, ho ten nguoi muon, ngay muon, ten sach muon, so luong , tinh trang sach, ngay hen tra 
*/

select u.user_id as "Ma nguoi muon", u.full_name as "Ho ten nguoi muon", b.borrow_date as "Ngay muon", bs.title as "Ten sach muon", bd.quantity as "So luong", bd.book_status as "Tinh trang sach", b.return_date as "Ngay hen tra"
from users u join borrows b on u.user_id =b.user_id join borrows_details bd
on b.borrow_id=bd.borrow_id join books bs on bd.book_id=bs.isbn;

/*Yeu cau truy van: Hien thi thong tin cac sach viet cua cac tac gia, thong tin gom:
Ma tac gia, Ten tac gia, Ten sach viet,The loai, Nam xuat ban, Nha xuat ban, So luong xuat ban
*/

select a.author_id as "Ma tac gia", a.author_name as "Ten tac gia", bs.title as "Ten sach viet", c.cate_name as "The loai", 
bs.year_publish as "Nam xuat ban", p.publisher_name as "Nha xuat ban", bs.quantity as "So luong xuat ban"
from authors a join author_book ab on a.author_id = ab.author_id join books bs on ab.book_id = bs.isbn join categories c on c.cate_id = bs.cate_id join publishers p on bs.publisher_id = p.publisher_id;

/*
Yeu cau truy van: Hien thi thong tin cac sach xuat ban cua cac nha xuat ban: 
Ma nha xuat ban, Ten nha xuat ban, Dia chi, Ma sach xuat ban, Ten sach xuat ban, The loai sach, So luong xuat ban
*/

select p.publisher_id as "Ma nha xuat ban", p.publisher_name as "Ten nha xuat ban", p.address as "Dia chi",
bs.isbn as "Ma sach xuat ban", bs.title as "Ten sach xuat ban", c.cate_name as "The loai sach", bs.quantity as "So luong xuat ban"
from publishers p join books bs on p.publisher_id = bs.publisher_id join categories c on c.cate_id = bs.cate_id;

--Su dung left join

/*
	Syntax:Thay vi join ta viet left join
*/

/*
	Hien thi thong tin sach xuat ban cua tat ca cac nha xuat ban, nha xuat ban nao chua xuat ban cuon sach nao thi thong tin de null
	Ma nha xuat ban, ten nha xuat ban, Dia chi, Ma sach xuat ban, Ten sach.
*/

select * from publishers;
select * from books;

select p.publisher_id as "Ma nha xuat ban", p.publisher_name as "Ten nha xuat ban", 
p.address as "Dia chi", b.isbn as "Ma sach xuat ban", b.title as "Ten sach xuat ban"
from publishers p left join books b on p.publisher_id = b.publisher_id;

--Su dung right join 
--Syntax: Thay vi join ta viet right join
--Lay het giu lieu bang ben phai, bang ben trai khong co thi de null
select b.*
from books b right join publishers p on p.publisher_id = b.publisher_id;

--Su dung full join: Lay het du lieu o ca hai bang, bang khong co thi de null

/*
	Hien thi tong so loai sach xuat ban cua moi nha xuat ba, thong tin bao gom:
	Ma nha xuat ban, Ten nha xuat ban, Tong so loai sach xuat ban
	Phan tich: Phai lien ket giua bang publishers va bang books 
	sau do nhom nha xuat ban lai va dem so loai sach xuat ban (sd han count)
*/

select p.publisher_id as "Ma nha xuat ban", p.publisher_name as "Ten nha xuat ban",
count(*) as "Tong so loai sach xuat ban"
from publishers p join books b on p.publisher_id = b.publisher_id
group by p.publisher_id;

/*
	Hien thi tong so sach xuat ban cua moi nha xuat ba, thong tin bao gom:
	Ma nha xuat ban, Ten nha xuat ban, Tong so sach xuat ban
*/

select p.publisher_id as "Ma nha xuat ban", p.publisher_name as "Ten nha xuat ban",
sum(b.quantity) as "Tong so sach xuat ban"
from publishers p join books b on p.publisher_id = b.publisher_id
group by p.publisher_id;

-- Hien thi tong so sach muon cua nhung nguoi muon
-- Ma nguoi muon, Ten nguoi muon, Tong so sach muon

select u.user_id as "Ma nguoi muon", u.full_name as "Ten nguoi muon",
sum(bd.quantity) as "Tong so sach muon"
from users u join borrows b on u.user_id = b.user_id join borrows_details bd on bd.borrow_id = b.borrow_id
group by u.user_id;

--Su dung Having: DIEU KIEN NHOM
/*
	Hien thi tong so sach muon cua moi nguoi, chi hien thi nguoi co tong so sach muon lon hon 6
*/

select u.user_id as "Ma nguoi muon", u.full_name as "Ten nguoi muon",
sum(bd.quantity) as "Tong so sach muon"
from users u join borrows b on u.user_id = b.user_id join borrows_details bd on bd.borrow_id = b.borrow_id
group by u.user_id
having sum(bd.quantity) > 6;

/*
	Su dung truy van long thuc hien yeu cau:
	Hien thi thong tin cua nhung nguoi muon sach it nhat thong tin gom:
	Ma nguoi muon, Ho ten, Tong so sach muon

	Phan tich: 
		1. Tim ra duoc tong so muon it nhat
		2. Tao truy van tong so muon
		3. Dieu kien cua nhom la tong so do = so muon it nhat
*/

select u.user_id as "Ma nguoi muon", u.full_name as "Ten nguoi muon",
sum(bd.quantity) as "Tong so sach muon"
from users u join borrows b on u.user_id = b.user_id join borrows_details bd on bd.borrow_id = b.borrow_id
group by u.user_id
having sum(bd.quantity) = (
	select sum(bd.quantity) as "Tong so sach muon"
	from users u join borrows b on u.user_id = b.user_id join borrows_details bd on bd.borrow_id = b.borrow_id
	group by u.user_id
	order by sum(bd.quantity) asc limit 1
);


