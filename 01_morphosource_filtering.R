library(rfishbase, magrittr)

# Filtering morphosource ####

# Read in the morphospace genera spreadsheet
morphosource <- read.csv("Code/Spreadsheets/Morphospace_genera.csv", 
                         stringsAsFactors = FALSE)
taxon.sample <- read.csv("Code/Spreadsheets/taxon_sampling_list.csv",
                         stringsAsFactors = FALSE)


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
morphosource.list <- data.frame(Taxon = numeric(),
                                Order = character(),
                                Family = character(),
                                Genus = character(),
                                Species = character())

# Initialize empty list for non-morphosource, including same columns
missing.list <- data.frame(Taxon = numeric(),
                                Order = character(),
                                Family = character(),
                                Genus = character(),
                                Species = character())

# for every taxon:
for (i in 1:nrow(taxon.sample)) {
  
  # Find overlaps with morphosource
  ms.rows <- which(on.ms$Taxon.number == i)
  
  # if there are no morphosource resources...
  if (length(ms.rows) == 0) {
    
    # Copy row over to non-morphosource and leave it alone
    temp.mat <- matrix(c(i, taxon.sample[i, 1:4]), nrow = 1)
    colnames(temp.mat) <- colnames(missing.list)
    missing.list <- rbind(missing.list, temp.mat)
    
  } else {   # If there are morphosource resources...

    # For each genus on morphosource, make new rows of Order/Family/Genus 
    # Number of rows of that genus = How.many. column
    
    # Subset morphosource list
    taxon.ms <- as.matrix(on.ms[ms.rows, ])
    
    # Store order and family; will be the same for all genera in the taxa
    order.family <- c(taxon.sample[i, 1:2])
    
    # For each genus on morphosource...
    for (j in 1:nrow(taxon.ms)) {
      
      # build a new vector:
      # order and family (from taxon list), genus from morphosource list, and a
      # blank space for the species
      genus.vector <- c(as.numeric(i), order.family, taxon.ms[j, 2], "")
      
      # Count how many species in that genus have a scan uploaded
      row.count <- as.numeric(taxon.ms[j, 5])
      
      # Add that many copies of the new row to the morphosource dataframe
      temp.mat <- matrix(rep(genus.vector, row.count), nrow = row.count, byrow = TRUE)
      colnames(temp.mat) <-  colnames(morphosource.list)
      
      morphosource.list <- rbind(morphosource.list, temp.mat)
      
    }
    
    # These will be filled in manually, then searched on fishbase
    
    
  }
  
}

write.csv(morphosource.list, "Code/Spreadsheets/Taxa_on_morphosource.csv")
write.csv(missing.list, "Code/Spreadsheets/Not_on_morphosource.csv")