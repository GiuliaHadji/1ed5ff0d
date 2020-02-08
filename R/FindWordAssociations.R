#' @title Find associations in BBC News article
#' @description Find terms associated with the input word with at least input correlation value.
#'              Build a dataframe with terms and correlation values in decreasing order
#' @details It's recommended to check the dataframe with the most frequent term (run function analyze_text)
#'          to know which terms might be relevant for the analysis.
#' @param  url_end a character string, an ending part of BBC News particular atricle URL (everything after https://www.bbc.com/news/).
#'                 For example, article URL is "https://www.bbc.com/news/world-us-canada-51381625".
#'                 Only "world-us-canada-51381625" should be pasted
#' @param word_entry character string, one input word to analyze associations (terms which correlate) with it
#' @param corr_entry numeric, correlation value, should be between 0 and 1, otherwise user gets a message to run the function again
#'                  (recommended value is between 0.3 and 0.6)
#' @return assoc - a dataframe with two columns: terms correlated with word input and correlation value in decreasing order
#' @note Please, check that URL (url_end) exists before running the function,
#'       otherwise you will get an "Error in open.connection(x, "rb") : HTTP error 404".
#'       Please, insert URLs of the articles in English only. Only for BBC News, not BBC Sports , Travel, Worklife, etc.
#' @examples assoc_word("world-asia-51427301", "fire", 0.3)
#' @examples assoc_word("world-us-canada-51408704", "trump", 0.5)
#' @export

assoc_word <- function(url_end, word_entry, corr_entry)
{
  #call clean_text function to get cleaned Corpus documents with article text
  art_c <- bbcnews:: clean_text(url_end)

  #building a term-document matrix
  dtm_art <- tm:: TermDocumentMatrix(art_c)

  if (corr_entry >1 | corr_entry <0) {
    return(print ("Wrong value for correlation. Please, run the function again and input value between 0 and 1"))

  } else {
    # find associations with at least corr.entry correlation for the word.entry input and convert results into a dataframe
    assoc <- as.data.frame(tm:: findAssocs(dtm_art, word_entry, corr_entry)) #decreasing order

    #return accoc
    return(assoc)

  }

}
