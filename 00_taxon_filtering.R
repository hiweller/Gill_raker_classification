library(rfishbase, magrittr)

# Check for overlaps between taxon list and ScanAllFishes ####

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

  
}

# Generate morphospace search CSV with taxon.number and genera
# Each row contains a genus, and the taxon number (between 1 and 102) that that genus could fulfill
morphospace.output <- data.frame(Taxon.number = taxon.list,
           Genus.species = genera)

write.csv(morphospace.output, "Spreadsheets/Morphospace_genera.csv")


