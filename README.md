# bbcnews Package


#### _1ed5ff0d_

bbcnews package is used for scrapping article text from [BBC News website](https://www.bbc.com/news/), cleaning, analysing and plotting it 

## Installation

```R
# first install the R package "devtools" if not installed
devtools::install_github('unimi-dse/1ed5ff0d')
```

## Usage

```R
# load the package
require(bbcnews)
```

## Functions

Function             | Description                                                                 | Examples
---------------------|-----------------------------------------------------------------------------|------------------------
`get_text()`         | Scrap BBC News article headline and body text                               | get_text("world-us-canada-51381625")
`clean_text()`       | Clean and transfrom article text (stem text, remove numbers, stopwords etc.)| clean_text("world-us-canada-51381625")
`analyze_text()`     | Build a dataframe with the most frequent words and plot it with a wordcloud | analyze_text("world-us-canada-51381625", 50, TRUE)
`assoc_word()`       | Find associations (terms which are correlated) with the input word          | assoc_word("world-us-canada-51408704", "trump", 0.5)            |
`analyze_sentiment()`| Analyze sentiment distribution across the article and plot it               | analyze_sentiment("world-us-canada-51381625")

Type ?Function for a complete description of the functions (for example, `?get_text()`)

## Arguments

Argument `url_end` is used in all the functions. `url_end` is a character string, an ending part of [BBC News](https://www.bbc.com/news/) particular atricle URL (everything after https://www.bbc.com/news/). For example, article URL is "https://www.bbc.com/news/world-us-canada-51381625". Only "world-us-canada-51381625" should be pasted in the function

**Note**: Please, check that URL (url_end) exists before running the function, otherwise you will get an "Error in open.connection(x, "rb") : HTTP error 404". Please, insert URLs of the **BBC News** (not Sports, Travel etc.) articles in English only.

##Packages Imported
rvest, xml2, tm, SnowballC, wordcloud, sentimentr, ggplot2, RColorBrewer, utils, devtools, dplyr, magrittr

**Author**: Angelina Khatiwada
**Date**: February 2020
