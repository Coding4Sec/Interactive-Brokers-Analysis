# Michael R. Kirchner
# github.com/mkirch
# Crude Oil Analysis
# See Readme.MD for details

# Function definition for adding necessary packages from CRAN
checkinstall <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("IBrokers", "quantmod","EIAdata","plotly") # List of required packages
checkinstall(packages) 

# Add necessary packages from R-Forge (twsInstrument)
if (require("twsInstrument") == TRUE) {
  library("twsInstrument")
} else {
  install.packages("twsInstrument", repos="http://R-Forge.R-project.org")
  library("twsInstrument")
}

# Connects to TWS
tws <- twsConnect()
tws

# Get the contract details for the May 2015 WTI Crude Oil future
crude <- getContract("CLMAY2015") #Uses twsInstrument package

# Get historical data over 1 year starting at the last production
# report date released on March 13th at 10:30 AM
priceData <- reqHistoricalData(tws, 
                               crude,
                               "20150313 12:00:00",
                               barSize= "1 week",
                               duration="6 M",
                               )

# Declare your EIA API key
key <- "INSERT YOUR API KEY HERE"

# Retrieve U.S. Field Production of Crude Oil, Weekly (Thousand Barrels per Day, Weekly)
rawProductionData <- getEIA(ID = "PET.WCRFPUS2.W", key)
productionData <- data.frame(rawProductionData["2014-09-19/"]) # Include 6 months

# Merge data
mergedData <- cbind(priceData[,6], productionData[,1], join='right')
names(mergedData) <- c("Price", "Production")

# Plot price data using quantmod
chartSeries(mergedData[,1], 
            type="candlesticks",
            theme=chartTheme("black"),
            name="Price Data")

# Plot production data using quantmod
chartSeries(mergedData[,2], 
            type="candlesticks",
            theme=chartTheme("black"),
            name="Production Data")

# Run correlation between price and U.S. production
cor(mergedData)


