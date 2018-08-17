library(rfishbase, magrittr)

taxon.sample <- read.csv("Spreadsheets/taxon_sampling_list.csv")
saf <- read.csv("Spreadsheets/scan_all_fishes.csv")

fishbase <- as.data.frame(fishbase)

temp <- c()

genera <- c()
taxon.list <- c()


for (i in 1:nrow(taxon.sample)) {
  
  # Find the narrowest taxonomic classification
  taxon <- taxon.sample[i, ]
  taxon.idx <- taxon[tail(which(taxon[1:4] != ""), 1)]
  taxon.level <- names(taxon.idx)
  
  taxon.idx <- taxon.idx[[1]]
  
  # If "Order", pull down all families
  # If "Family" or "Genus", search scanallfishes for matches
  # If "species", list out genus and species
  if (taxon.level == "Species") {
    sp <- paste(taxon[[3]], taxon[[4]], collapse = " ")
    idx <- which(saf$Species %in% sp)
    
    if (length(idx) > 0) {
      temp <- c(temp, idx)
      #print(saf$Species[idx])
      
    }
    
    taxon.list <- c(taxon.list, i)
    genera <- c(genera, sp)
    
  } else if(taxon.level == "Genus") {
    
    taxon.list <- c(taxon.list, i)
    genera <- c(genera, as.vector(taxon.idx))
    
  } else {
    
    # saf.idx <- which(as.vector(saf[ , 
    #                which(tolower(names(saf)) %in%
    #                        tolower(taxon.level))]) == taxon.idx)
    fishbase.idx <- which(as.vector(fishbase[ , 
                                         which(tolower(names(fishbase)) %in%
                                                 tolower(taxon.level))]) == taxon.idx)
    fishbase.genera <- unique(fishbase$Genus[fishbase.idx])
    genera <- c(genera, fishbase.genera)
    taxon.list <- c(taxon.list, rep(i, length(fishbase.genera)))
  }
    #saf.level <- which(colnames(fishbase) == taxon.level)
  
  #saf.match <- fishbase[ , saf.level]
  
  # Pull down all species that fall within that group
  #taxon.matches <- fishbase[which(saf.match %in% taxon.idx), 2]
  
  # Find all overlaps of those species with scan all fishes
  
  
  
}
morphospace.output <- data.frame(Taxon.number = taxon.list,
           Genus.species = genera)

saf.pull.list <- saf[temp, ]

# Columns:
# Order
# Family
# Genus
# Species
# Corresponding row on taxon list
# Trophic niche (fishbase class)
# Trophic niche (comments)

# For every row in taxon.sample:



# If there is only one match:
# Enter it onto the Single.matches dataframe

# If there are no matches:
# Enter it onto the No.matches dataframe

# If there are multiple matches:
# Enter onto multiple.matches dataframe