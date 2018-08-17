library(rfishbase, magrittr)

taxon.sample <- read.csv("Spreadsheets/taxon_sampling_list.csv")
saf <- read.csv("Spreadsheets/scan_all_fishes.csv")
colnames(saf)
head(saf$Species)

for (i in 1:nrow(taxon.sample)) {
  
  taxon <- taxon.sample[i, ]
  
  
  
}


# Columns:
# Order
# Family
# Genus
# Species
# Corresponding row on taxon list
# Trophic niche (fishbase class)
# Trophic niche (comments)

# For every row in taxon.sample:


# Find the narrowest taxonomic classification
# Pull down all species that fall within that group
# Find all overlaps of those species with scan all fishes

# If there is only one match:
# Enter it onto the Single.matches dataframe

# If there are no matches:
# Enter it onto the No.matches dataframe

# If there are multiple matches:
# Enter onto multiple.matches dataframe