#' @title Analyze BBC News article
#' @description Build a dataframe with the input number of the most frequent words in the article (word frequency in decreasing order)
#'              Plot it with a wordcloud (optional)
#' @param url_end character string, an ending part of BBC News particular atricle URL (everything after https://www.bbc.com/news/).
#'                 For example, article URL is "https://www.bbc.com/news/world-us-canada-51381625".
#'                 Only "world-us-canada-51381625" should be pasted
#' @param num_word numeric, the number of words to be included in dataframe and plot.
#'                 Recommended value for plotting is 50 or 100 (not more than 200) as the plot gets distorted with the larger values
#'                 and the word frequency becomes less significant
#' @param do_plot logical, if TRUE, wordcloud is rendered. By default plot is not rendered as do_plot = FALSE
#' @return h_df_word_freq - a dataframe with the num_words frequent words in the article (two columns: words and frequency of appearance in the text).
#'         Optional: a plot of the dataframe is rendered
#' @note Please, check that URL (url_end) exists before running the function,
#'       otherwise you will get an "Error in open.connection(x, "rb") : HTTP error 404".
#'       Please, insert URLs of the articles in English only. Only for BBC News, not BBC Sports , Travel, Worklife, etc.
#' @examples analyze_text("world-us-canada-51381625", 100, FALSE)
#' @examples analyze_text("entertainment-arts-51398105", 50, TRUE)
#' @export

analyze_text <- function(url_end, num_word, do_plot = FALSE)
{
  #call get_text function to get Corpus documents with article text
  art_c <- bbcnews:: clean_text(url_end)

  #building a term-document matrix
  dtm_art <- tm:: TermDocumentMatrix(art_c)

  #building a dataframe with terms sorted by decreasing frequency
  matr_art <- as.matrix(dtm_art) #building a matrix
  matr_sort <- sort(rowSums(matr_art),decreasing=TRUE) #sorting the columns in decreasing frequency
  df_word_freq <- data.frame(word = names(matr_sort),freq=matr_sort) #building a dataframe with words and their frequency
  h_df_word_freq <- head(df_word_freq, num_word) #num_words most frequent words

  #Generating the wordcloud of num_word most frequent words. By default wordcloud is not rendered (do_plot = FALSE)
  if(do_plot){
  wordcloud:: wordcloud(words = h_df_word_freq$word, freq = h_df_word_freq$freq, min.freq = 1,
                  random.order=FALSE, rot.per=0.1,
                  colors=RColorBrewer:: brewer.pal(5, "Dark2"))
  }

  #return dataframe
  return(h_df_word_freq)

}
