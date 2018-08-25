library(rfishbase, magrittr)

# Filtering morphosource ####

# Read in the morphospace genera spreadsheet
morphosource <- read.csv("Spreadsheets/Morphospace_genera.csv") 

# Subset out all the rows which have at least one entry on morphosource
on.ms <- morphosource[which(morphosource$On.morphosource. == "Y"), ]

# We're going to make two dataframes: 

# 1) Things we can get from morphosource + their diet data

# 2) Things we can't get from morphosource and their highest taxon level

# This is because the morphosource pull list will be much narrower,
# whereas the non-morphosource one would require pulling diet data for every
# single species within the missing taxa

# It makes more sense to do manual inspection of the missing taxa, see if they're on ScanAllFishes, see if we want to narrow the search, etc

# Initialize empty list for morphosource, including Order/Family/Genus/Species

# Initialize empty list for non-morphosource, including same columns

for (i in 1:nrow(taxon.sample)) {
  
  # for every taxon:
  # if there are no morphosource resources:
  # Copy row over to non-morphosource and leave it alone
  
  # If there are morphosource resources:
  # For each genus on morphosource, make new rows of Order/Family/Genus 
  # Number of rows of that genus = How.many. column
  # These will be filled in manually, then searched on fishbase
  
  
}
