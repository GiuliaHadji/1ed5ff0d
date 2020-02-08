#' @title BBC News article Sentiment analysis
#' @description Analyze sentiment distribution across the article and plot it
#' @details Use Corpus with article text without cleaning it as punctuation and stopwords should be preserved.
#'          Transform Corpus into a dataframe with one row for each article paragraph.
#'          Calculate sentiment score for each dataframe row and summary statistics for the entire article sentiment (mean, median, min, max).
#'          Build a dataframe with sentiment disrtibution and plot it
#' @param  url_end a character string, an ending part of BBC News particular atricle URL (everything after https://www.bbc.com/news/).
#'                 For example, article URL is "https://www.bbc.com/news/world-us-canada-51381625".
#'                 Only "world-us-canada-51381625" should be pasted
#' @return gg_plot with sentiment distibution across the article (sentiment > 0 positive and blue in color;
#'         sentiment < 0 negative and red in color)
#' @note Please, check that URL (url_end) exists before running the function,
#'       otherwise you will get an "Error in open.connection(x, "rb") : HTTP error 404".
#'       Please, insert URLs of the articles in English only. Only for BBC News, not BBC Sports , Travel, Worklife, etc.
#' @examples analyze_sentiment("world-us-canada-51381625")
#' @examples analyze_sentiment("entertainment-arts-35232060")
#' @export

analyze_sentiment <- function(url_end)
{
  #call get_text function to get Corpus documents with article text (not cleaned, all the sentences and words are preserved) )
  art_c <- get_text(url_end)

  #transform Coprus into a dataframe with one row for each document in Corpus(paragraph)
  art_df <- data.frame(text = sapply(art_c, as.character), stringsAsFactors = FALSE)

  #calculate sentiment score for each dataframe row
  art_df %>%
    sentimentr:: get_sentences() %>% #check where the sentences end
    sentimentr:: sentiment() %>% #calculate sentiment
    dplyr:: mutate(characters = nchar(tm::stripWhitespace(text))) %>% #eliminate extra white spaces, count the number of characters and create a variable
    dplyr:: filter(characters >1 ) -> bounded_sentences #create bounded_sentences with sentiments score for each dataframe row

  #provide statistics for bounded_sententeces sentiments (min, median, mean, max, etc.)
  bs_summ <- summary(bounded_sentences$sentiment)

  #summarize the dataframe with sentiment score and density by extrapolation
  sent_df <- with(density(bounded_sentences$sentiment), data.frame(sent_scor=x, dens=y))

  #plot the sentiment distribution
  ggplot2::ggplot(sent_df, ggplot2::aes(x=sent_scor, y = dens)) +
    ggplot2::geom_line() +
    ggplot2::geom_area(mapping = ggplot2::aes(x = ifelse(sent_scor >=0, sent_scor, 0)), fill = "blue") +
    ggplot2::geom_area(mapping = ggplot2::aes(x = ifelse(sent_scor <=0, sent_scor, 0)), fill = "red") +
    ggplot2::scale_y_continuous(limits = c(0,7.5)) +
    ggplot2::theme_minimal(base_size = 15) +
    ggplot2::labs(x = "sentiment",
         y = "density",
         title = "Sentiment Distribution Across The Article") +
    ggplot2::theme(plot.title = ggplot2::element_text(size = 15, hjust = 0.4),
          axis.text.y=ggplot2::element_blank()) -> gg_plot
?get
  #return plot
  return(gg_plot)
}
