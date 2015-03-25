# Michael R. Kirchner
# github.com/mkirch
# Options Analysis Tool

# Function definition for adding necessary packages from CRAN
checkinstall <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg))
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("IBrokers", "quantmod") #List of required packages
checkinstall(packages) 

# Add necessary packages from R-Forge (twsInstrument)
if (require("twsInstrument") == TRUE) {
  library("twsInstrument")
} else {
  install.packages("twsInstrument", repos="http://R-Forge.R-project.org")
  library("twsInstrument")
}

# Connect to TWS
tws <- twsConnect()
tws

# Create stock and option objects for AAPL
aaplStock <- twsEquity("AAPL")
aaplOption <- twsOption(local = '', expiry = '20150402', strike = '128.00', right = 'C', symbol = 'AAPL')

# Price data for stock and option for last 6 days
aaplStockData <- reqHistoricalData(tws, aaplStock, barSize="1 hour", duration="6 D")
Sys.sleep(10) #tws requirement for gaps between requests
aaplOptionData <- reqHistoricalData(tws, aaplOption, barSize="1 hour", duration= "6 D")

# Merge the two data frames together horizontally
mergedData <- merge(aaplStockData[,6], aaplOptionData[,6], join="inner")
names(mergedData) <- c("stock", "option")

# XTS operation
xtsData <- xts(apply(mergedData, 2, Delt)[-1,], order.by=index(mergedData)[-1])

# Create charts for each instrument's volatility (absolute value of change)
chartSeries(abs(xtsData$stock)) # quantmod stock plot
chartSeries(abs(xtsData$option)) # quantmod option plot

# Summary statistics output for analysis
summary(lm(xtsData$option ~ xtsData$stock))