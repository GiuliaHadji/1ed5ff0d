# bbcnews Package

#### _1ed5ff0d_

bbcnews package is used for scrapping article text from BBC News website (https://www.bbc.com/news/), cleaning, analysing and plotting it 

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
`get_text()`         | Scrap BBC News article headline and body (from https://www.bbc.com/news/)   | get_text("world-us-canada-51381625")
`clean_text()`       | Clean and transfrom article text (stem text, remove numbers, stopwords etc.)| clean_text("world-us-canada-51381625")
`analyze_text()`     | Build a dataframe with the most frequent words and plot it with a wordcloud | analyze_text("world-us-canada-51381625", 50, TRUE)
`assoc_word()`       | Find associations (terms which are correlated) with the input word          | assoc_word("world-us-canada-51408704", "trump", 0.5)            |
`analyze_sentiment()`| Analyze sentiment distribution across the article and plot it               | analyze_sentiment("world-us-canada-51381625")

Type ?Function for a complete description of the functions (for example, `?get_text()`)
