# This function searches for books on bookdepository.com
# It takes two arguments 
# 1. search_term = term to search
# 2. percent discount = only show books with this discount or more
find_books <- function(search_term, perc_discount=0) {
  
  # Here we create the URL using the search_term 
  site <- paste("https://www.bookdepository.com/search?searchTerm="
                , search_term
                , "&search=Find+book"
                , sep = "")
  
  # Fun to scrape XPATH nodes using Rvest
  scrape <- function(site, node) {
    xml2::read_html(site) %>%
      rvest::html_nodes(node)%>%
      rvest::html_text() %>%
      stringr::str_trim() 
  }
  
  # DF with all of the information of the books
  books <- dplyr::data_frame(
    title = scrape(site, ".title")
    , author = scrape(site, ".author")
    , published = scrape(site, ".published")
    , price = scrape(site, ".price")
  ) %>%
    dplyr::mutate(
      `original price` = str_extract(price, "([0-9]+,[0-9]+).€$") 
      , 	`discounted price` = str_extract(price, "^([0-9]+,[0-9]+).€")
    ) %>% 
    dplyr::mutate_at(
      vars('original price', 'discounted price')
      , ~ as.numeric(
        stringr::str_remove(
          # With the comma and €, these cannot be casted to numeric
          stringr::str_replace_all(., ",", "."), "€"))) %>%
    dplyr::mutate(discount = 1 - `discounted price`/`original price`) %>%
    # Irrelevant column, see original price and discounted price
    dplyr::select(-price) %>%
    dplyr::arrange(desc(discount))
  
  # This is the output after filtering on perc_discount
  books %>%
    dplyr::filter(discount, discount >= perc_discount) %>%
    dplyr::arrange(desc(discount))
  
}
