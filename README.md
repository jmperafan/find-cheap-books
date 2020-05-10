# # Find Cheap Books
## Find cheap books on https://www.bookdepository.com/ 
<p>By <a href="https://www.linkedin.com/in/jmperafan/">Juan Manuel Perafan</a></p>

Book depository has one of the most complete book collection (at least the books I like) and they generally have good prices and generous discounts. However, instead of checking every time if one of the books I want is on discount, I decided to create a script to do it for me. This R script (using Rvest) scrapes data with a search_term provided and then shows me the book that have a discounts equal or better than I search. 

For example, `find_books(search_term = "Learn Python the Hard Way", perc_discount= .3)` will return any version of Learn Python the Hard Way with a discount of 30% or more!

![](https://i1.wp.com/www.chris-callaghan.com/wp-content/uploads/2016/01/book_depository_logo.png?w=1000 1000w, https://i1.wp.com/www.chris-callaghan.com/wp-content/uploads/2016/01/book_depository_logo.png)