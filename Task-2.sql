Select city.name_city, ROUND(Sum(book.price) / Count(*), 2) -- задание 1
from city, client, buy, buy_book, book
Where city.city_id = client.city_id 
and client.client_id = buy.client_id
and buy.buy_id = buy_book.buy_id
and book.book_id = buy_book.book_id
group by city.name_city;


Select author.name_author, book.title, Count(*) -- задание 2
from book, author, buy_book
Where author.author_id = book.author_id
and book.book_id = buy_book.book_id
Group by author.name_author, book.title
Order by length(book.title)


select * from -- задание 3
  (select authorBook.name_author, Sum(authorBook.amount) from
    (select author.name_author, buy_book.amount from author
    join book on author.author_id = book.author_id
    join buy_book on book.book_id = buy_book.book_id) as authorBook
  group by authorBook.name_author
  order by Sum(authorBook.amount) desc) authorWithBook
limit 1


select name_client, name_genre, Sum(buy_book.amount) -- задание 4
from client
join buy on buy.client_id = client.client_id
join buy_book on buy_book.buy_id = buy.buy_id
join book on book.book_id = buy_book.book_id
join genre on genre.genre_id = book.genre_id
group by name_client, name_genre


select * from -- задание 5
(select books.title, Count(*) from
(select city.name_city, book.title, Count(*) from city
join client on city.city_id = client.city_id
join buy on buy.client_id = client.client_id
join buy_book on buy_book.buy_id = buy.buy_id
join book on book.book_id = buy_book.book_id
group by city.name_city, book.title) as books
group by books.title
having count(*) > count(books.name_city))


select book.title, book.price, -- задание 6
Round(book.price * 0.85, 2) as discount_price from book,
  (select Round(Sum(book.price) / Count(*), 2) as price from book) averagePrice
where book.price > averagePrice.price
and book.amount < 5


Select split_part(client.name_client, ' ', 2) -- задание 7
From client 
Where client.name_client Like '%я'


select EXTRACT(MONTH FROM buy_step.date_step_end) as month, -- задание 8
Sum(book.price) from book
join buy_book on buy_book.book_id = book.book_id
join buy_step on buy_step.buy_id = buy_book.buy_id
where buy_step.date_step_end is not null
group by month