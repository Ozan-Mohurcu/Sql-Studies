CREATE TABLE project1 (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate TIMESTAMP,
    UnitPrice DECIMAL(10,2),
    Country VARCHAR(50),
    Year INT,
    Month INT,
    Day INT,
    Hour INT
);

SELECT * FROM project1 p 

SELECT * FROM project1 p LIMIT 10;

-- 1. Satış Analizi;
-- En çok satılan  ürün hangisi?

SELECT description , sum(quantity) AS total_sold
FROM project1 p 
GROUP BY description 
ORDER BY total_sold
LIMIT 1;

--  Her ürün için toplam satış miktarı nedir? 

SELECT description, sum(quantity) AS total_sold
FROM project1 p 
GROUP BY description 
ORDER BY total_sold DESC;

-- Toplam satış gelirine göre ilk 5 ürün nedir? 

SELECT description , sum(quantity * unitprice) AS total_revenue 
FROM project1 p 
GROUP BY description 
ORDER BY total_revenue
LIMIT 5;

--Bir günde en çok gelir elde edilen tarih nedir?

SELECT invoicedate::date AS sale_date , sum(quantity * unitprice) AS daily_revenue 
FROM project1 p 
GROUP BY sale_date
ORDER BY daily_revenue DESC
LIMIT 1;

-- 2. Müşteri Analizi
-- En çok alışveriş yapan müşteri kim?

SELECT country , sum(quantity * unitprice) AS total_spent 
FROM project1 p 
GROUP BY country 
ORDER BY total_spent DESC 
LIMIT 1;

-- Her müşterinin toplam harcama miktarını listeleyin.

SELECT country , sum(quantity * unitprice) AS total_spent 
FROM project1 p 
GROUP BY country 
ORDER  BY total_spent DESC;

-- Bir müşterinin ortalama satın alma tutarını nasıl bulabilirsiniz?

SELECT avg(quantity * unitprice) AS avg_purschase 
FROM project1 p 
GROUP BY country 
ORDER BY avg_purschase DESC ;

-- 3. Zaman Analizi
-- Satışların en yoğun olduğu saatler nelerdir?

SELECT "hour" , count(*) AS sales_count
FROM project1 p 
GROUP BY "hour" 
ORDER BY sales_count DESC;

-- Hangi ayda en fazla gelir elde edilmiştir?

SELECT "month" , sum(quantity * unitprice) AS total_month 
FROM project1 p 
GROUP BY "month" 
ORDER BY total_month
LIMIT 1;

-- Hafta içi ve hafta sonu satışlarını karşılaştırın.

SELECT 
    CASE 
        WHEN EXTRACT(DOW FROM InvoiceDate) IN (0, 6) THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS day_type,
    SUM(Quantity * UnitPrice) AS total_revenue
FROM project1 p 
GROUP BY day_type;

-- 4. Ülke Analizi
-- Hangi ülkeden en fazla satış yapılmış?

SELECT country , count(*) AS total_sales
FROM project1 p 
GROUP BY country 
ORDER BY total_sales DESC 
LIMIT 1;

-- Ülkelere göre toplam gelir dağılımını listeleyin.

SELECT country , sum(quantity * unitprice) AS total_country
FROM project1 p 
GROUP BY country 
ORDER BY total_country DESC;

-- Hangi ülkede ürün başına ortalama fiyat daha yüksektir?

SELECT country , avg(unitprice) AS avg_price 
FROM project1 p 
GROUP BY country 
ORDER BY avg_price DESC
LIMIT 1;

-- 5. Fiyat ve Kar Analizi
-- Fiyatı en yüksek olan 5 ürün hangileri?

SELECT description , unitprice 
FROM project1 p 
GROUP BY description , unitprice 
ORDER BY unitprice DESC 
LIMIT 5;

-- Her ürünün toplam gelirini hesaplayın.

SELECT description , sum(quantity * unitprice) AS total_revenue 
FROM project1 p 
GROUP BY description 
ORDER BY total_revenue DESC;

-- İndirimli satış senaryosu: Eğer tüm ürünlere %10 indirim yapılırsa toplam gelir ne olur?

SELECT sum(quantity * unitprice * 0.9) AS discounted_sales 
FROM project1 p 

-- 6. Problem Tespiti ve Çözüm Önerileri
--  Hangi ürünlerde sıklıkla negatif miktarlar (iade) bulunuyor?
-- Bu soruya uygun bir veri olmamakta çünkü genellikle iade miktarları negatif olur ve bu verinin tabloya nasıl kaydedildiğini bilmek gerekiyor. Eğer negatif satışlar varsa:

SELECT description , count(*) AS return_count
FROM project1 p 
WHERE quantity  < 0
GROUP BY description 
ORDER BY return_count DESC;

-- Satışı olmayan ürünleri listeleyin.

SELECT description 
FROM project1 p 
GROUP BY description 
HAVING sum(quantity) = 0;

-- Stok koduna göre satılmamış veya az satılmış ürünleri belirleyin.

SELECT stockcode, description, sum(quantity) AS total_stok
FROM project1 p 
GROUP BY stockcode, description 
HAVING sum(quantity)  < 5;

-- Ek Sorgular
-- Her müşterinin hangi ülkeden alışveriş yaptığına dair bir özet oluşturun.

SELECT country, count(DISTINCT invoiceNo) AS total_transcations
FROM project1 p 
GROUP BY country 
ORDER BY total_transcations DESC;

-- Saat bazında günlük satış eğilimlerini analiz edin.

SELECT "hour" , count(*) AS sales_count
FROM project1 p 
GROUP BY "hour"
ORDER BY "hour";


-- Satış miktarı ve gelir arasındaki ilişkiyi incelemek için hangi sorgular çalıştırılabilir?

SELECT quantity, sum(quantity * unitprice) AS total_sales_day
FROM project1 p 
GROUP BY quantity 
ORDER BY quantity;








SELECT *
FROM project1 p 



