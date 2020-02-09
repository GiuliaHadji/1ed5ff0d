#' @title Clean Corpus with BBC News article
#' @description Clean documents in Corpus which include BBC News article text
#' @details Transform the symbols like "/", "\\" into space.
#'          Stem text, remove numbers, remove english stopwords, extra spaces and punctuation, convert text to lower case
#' @param  url_end character string, an ending part of BBC News particular atricle URL (everything after https://www.bbc.com/news/).
#'                 For example, article URL is "https://www.bbc.com/news/world-us-canada-51381625".
#'                 Only "world-us-canada-51381625" should be pasted
#' @return art_c - Corpus with cleaned and transformed text documents.
#'         Corpus represents a collection of text documents with an article text (each article paragraph as a single document in Corpus)
#' @note Please, check that URL (url_end) exists before running the function,
#'       otherwise you will get an "Error in open.connection(x, "rb") : HTTP error 404".
#'       Please, insert URLs of articles in English only. Only for BBC News, not BBC Sports , Travel, Worklife, etc.
#' @examples clean_text("world-us-canada-51381625")
#' @examples clean_text("entertainment-arts-35232060")
#' @export

clean_text <- function(url_end)
{
  #call get_text function to get Corpus documents with article text
  art_c <- bbcnews:: get_text(url_end)

  #transform "@", "/" and "\\" to space
  toSpace <- tm:: content_transformer(function (x , pattern ) gsub(pattern, " ", x))
  art_c <- tm:: tm_map(art_c, toSpace, "@")
  art_c <- tm:: tm_map(art_c, toSpace, "/")
  art_c <- tm:: tm_map(art_c, toSpace, "\\|")

  #clean the text in Corpus
  art_c <- tm:: tm_map(art_c, tm:: content_transformer(tolower)) # convert the text to lower case
  art_c <- tm:: tm_map(art_c, tm:: removeNumbers) # remove numbers
  art_c <- tm:: tm_map(art_c, tm:: stemDocument) # text stemming
  art_c <- tm:: tm_map(art_c, tm:: stripWhitespace) # eliminate extra white spaces
  art_c <- tm:: tm_map(art_c, tm:: removeWords, tm:: stopwords("english")) # remove english stopwords
  art_c <- tm:: tm_map(art_c, tm:: removePunctuation, preserve_intra_word_dashes = FALSE) # remove punctuation

  #retun cleaned Corpus
  return(art_c)
}
