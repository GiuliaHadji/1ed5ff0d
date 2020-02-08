#' @title  Get BBC News article
#' @description Scrap article headline and body text from BBC News website (https://www.bbc.com/news/),
#'              merge them together and create a Corpus for text mining.
#' @param  url_end character string, an ending part of BBC News particular atricle URL (everything after https://www.bbc.com/news/).
#'                 For example, article URL is "https://www.bbc.com/news/world-us-canada-51381625".
#'                 Only "world-us-canada-51381625" should be pasted
#' @return art_c - Corpus representing a collection of text documents with an article text (each article paragraph as a single document in Corpus)
#' @note Please, check that URL (url_end) exists before running the function,
#'       otherwise you will get an "Error in open.connection(x, "rb") : HTTP error 404".
#'       Please, insert URLs of the articles in English only. Only for BBC News, not BBC Sports , Travel, Worklife, etc.
#' @examples get_text("world-us-canada-51381625")
#' @examples get_text("entertainment-arts-35232060")
#' @export

get_text <- function(url_end)
{
  # build url
  url <- paste0("https://www.bbc.com/news/", url_end)

  # sanitize url
  url <- URLencode(url)

  # get the headline
  art_header <- xml2:: read_html(url) %>%        # get url
    rvest:: html_nodes("div.story-body h1") %>%   # get the article headline
    rvest:: html_text()                       # extract text

  # get the body
  art_text <- xml2:: read_html(url) %>%          # get url
    rvest:: html_nodes("div.story-body__inner p") %>%   # get the article body
    rvest:: html_text()                       # extract text

  # merge art_header and art_text
  art <- c(art_header, art_text) #create a list
  unlist(art, use.names=FALSE) #create a character by unlisting

  #create a corpus for text mining
  art_c <- tm:: VCorpus(tm::  VectorSource(art))

  #retun the Corpus
  return(art_c)
}
