# hoverfly
Scripts with code for model fitting for MSc Dissertation.

Order of execution
1: hover_exploratory.r - Code for loading in the data and finding which species were most observed.
2: Dataset_Sorting.r - Code for sorting the datasets into individual visit datasets for each species. Adding the list length covariate to the visit datasets and plotting frequency of occurances of the species used in the study. 
3: balt.r, tenax.r, script.r - Code for fitting and comparing models for each species (_Episyrphus balteatus_, _Eristalis tenax_, and _Sphaerophoria scripta_, respectively). 
4: pred.r - Code for obtaining predictions of occupancy and plotting these predictions.
5: Ebalt_predict.Rdata, Etenax_predict.Rdata, Sscripta_predict.Rdata - datasets of predicted occupancy for the corresponding species.
