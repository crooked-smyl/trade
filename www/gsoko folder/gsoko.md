---
title: "Untitled"
output: ioslides_presentation
date: "2023-10-04"
runtime: shiny
---



## R Markdown
This is an R Markdown presentation. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document.

## Slide with Bullets

- Bullet 1
- Bullet 2
- Bullet 3

## Slide with R Output


```r
summary(cars)
```

```
##      speed     
##  Min.   : 4.0  
##  1st Qu.:12.0  
##  Median :15.0  
##  Mean   :15.4  
##  3rd Qu.:19.0  
##  Max.   :25.0  
##       dist       
##  Min.   :  2.00  
##  1st Qu.: 26.00  
##  Median : 36.00  
##  Mean   : 42.98  
##  3rd Qu.: 56.00  
##  Max.   :120.00
```

## Slide with Plot


```
## Warning in
## tm_map.SimpleCorpus(.,
## removeNumbers):
## transformation drops
## documents
```

```
## Warning in
## tm_map.SimpleCorpus(.,
## removePunctuation):
## transformation drops
## documents
```

```
## Warning in
## tm_map.SimpleCorpus(.,
## stripWhitespace):
## transformation drops
## documents
```

```
## Warning in
## tm_map.SimpleCorpus(docs,
## content_transformer(tolower)):
## transformation drops
## documents
```

```
## Warning in
## tm_map.SimpleCorpus(docs,
## removeWords,
## stopwords("english")):
## transformation drops
## documents
```

```
##                  word freq
## maize           maize   29
## red               red   11
## sorghum       sorghum    8
## beans           beans    8
## green           green    8
## grams           grams    7
## soybeans     soybeans    6
## millet         millet    6
## soy               soy    6
## peas             peas    5
## bean             bean    5
## finger         finger    4
## yellow         yellow    4
## pigeon         pigeon    4
## white           white    3
## greengrams greengrams    3
## sim               sim    2
## soghurm       soghurm    2
## rosecoco     rosecoco    2
## seeds           seeds    2
## fertilizer fertilizer    2
## kidney         kidney    1
## lentils       lentils    1
## cow               cow    1
## amaranth     amaranth    1
## dolichos     dolichos    1
## meal             meal    1
## yelow           yelow    1
## groundnut   groundnut    1
## mwitemania mwitemania    1
## dill             dill    1
## groundnuts groundnuts    1
## wheat           wheat    1
## meters         meters    1
```

```
## <<TermDocumentMatrix (terms: 41, documents: 93)>>
## Non-/sparse entries: 146/3667
## Sparsity           : 96%
## Maximal term length: 10
## Weighting          : term frequency (tf)
```

```
##      maize        red 
##         29         11 
##    sorghum      beans 
##          8          8 
##      green      grams 
##          8          7 
##   soybeans     millet 
##          6          6 
##        soy       peas 
##          6          5 
##       bean     finger 
##          5          4 
##     yellow     pigeon 
##          4          4 
##      white greengrams 
##          3          3 
##        sim    soghurm 
##          2          2 
##   rosecoco      seeds 
##          2          2 
## fertilizer     kidney 
##          2          1 
##    lentils        cow 
##          1          1 
##   amaranth   dolichos 
##          1          1 
##       meal      yelow 
##          1          1 
##  groundnut mwitemania 
##          1          1 
##       dill groundnuts 
##          1          1 
##      wheat     meters 
##          1          1 
##   moisture tarpaulins 
##          1          1 
##     scales   weighing 
##          1          1 
##        dap        can 
##          1          1 
##  shriveled 
##          1
```

```
##                  word freq
## maize           maize   29
## red               red   11
## sorghum       sorghum    8
## beans           beans    8
## green           green    8
## grams           grams    7
## soybeans     soybeans    6
## millet         millet    6
## soy               soy    6
## peas             peas    5
## bean             bean    5
## finger         finger    4
## yellow         yellow    4
## pigeon         pigeon    4
## white           white    3
## greengrams greengrams    3
## sim               sim    2
## soghurm       soghurm    2
## rosecoco     rosecoco    2
## seeds           seeds    2
## fertilizer fertilizer    2
## kidney         kidney    1
## lentils       lentils    1
## cow               cow    1
## amaranth     amaranth    1
## dolichos     dolichos    1
## meal             meal    1
## yelow           yelow    1
## groundnut   groundnut    1
## mwitemania mwitemania    1
## dill             dill    1
## groundnuts groundnuts    1
## wheat           wheat    1
## meters         meters    1
## moisture     moisture    1
## tarpaulins tarpaulins    1
## scales         scales    1
## weighing     weighing    1
## dap               dap    1
## can               can    1
## shriveled   shriveled    1
```

![plot of chunk pressure](figure/pressure-1.png)

```
## Error in loadNamespace(name): there is no package called 'webshot'
```

