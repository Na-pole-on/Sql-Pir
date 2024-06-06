Select city.name_city, Count(*), --задание 1
		ROUND(Sum(book.price) / Count(*), 2) from city
  	join client on city.city_id = client.city_id 
  	join buy on client.client_id = buy.client_id
	join buy_step on buy_step.buy_id = buy.buy_id
	join step on step.step_id = buy_step.step_id
	join buy_book on buy_book.buy_id = buy_step.buy_id
	join book on book.book_id = buy_book.book_id
	where step.name_step = 'Доставка'
group by city.name_city


Select author.name_author, book.title, Count(*) -- задание 2
    from book
  join author on author.author_id = book.author_id
  join buy_book on book.book_id = buy_book.book_id
Group by author.name_author, book.title
Order by length(book.title)


select author.name_author, Sum(buy_book.amount) from author
    join book on author.author_id = book.author_id
    join buy_book on book.book_id = buy_book.book_id
	group by author.name_author
	order by Sum(buy_book.amount) desc
	limit 1;


select name_client, name_genre, Sum(buy_book.amount) from genre -- задание 4
  join book on book.genre_id = genre.genre_id
  join buy_book on buy_book.book_id = book.book_id
  join buy_step on buy_step.buy_id = buy_book.buy_id
  join step on step.step_id = buy_step.step_id
  join buy on buy.buy_id = buy_book.buy_id
  join client on client.client_id = buy.client_id
where step.name_step = 'Оплата' and buy_step.date_step_end is not null
group by name_client, name_genre


select city.name_city, Count(*) from book -- задание 5
  join buy_book on book.book_id = buy_book.book_id
  join buy_step on buy_step.buy_id = buy_book.buy_id
  join step on step.step_id = buy_step.step_id
  join buy on buy.buy_id = buy_book.buy_id
  join client on client.client_id = buy.client_id
  join city on city.city_id = client.city_id
where step.name_step = 'Оплата'
 group by city.name_city
  having count(*) > count(book.title)


select book.title, book.price, -- задание 6
	case 
		when book.price > (select avg(book.price) from book)
			 and book.amount < 5
		then book.price * 0.85
		else NULL
	end as discount_price
from book
ORDER BY discount_price;


Select split_part(client.name_client, ' ', 2) -- задание 7
    From client 
Where client.name_client Like '%я'

select extract(month from buy_step.date_step_beg) as month, -- задание 8
		Round(Sum(book.price * buy_book.amount) / Sum(buy_book.amount), 2) from book
	join buy_book on buy_book.book_id = book.book_id
	join buy_step on buy_step.buy_id = buy_book.buy_id
	join step on step.step_id = buy_step.step_id
where buy_step.date_step_beg is not null and step.name_step = 'Оплата'
group by month