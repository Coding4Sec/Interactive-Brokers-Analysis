#Interactive Brokers Analysis Tool

This program serves as an example of pulling data from Interactive Brokers, and running analysis on said data.

##Running These Scripts

(i) To run, you must have an Interactive Brokers account or Interactive Brokers paper trader account.

(ii) Log into TWS Latest with your paper trader account. 

(iii) Once in TWS, navigate to Global Configuration > API > Settings and ensure that Enable ActiveX and Socket Clients is checked. Additionally, enter the IP address for your local machine as 127.0.0.1 in the field of trusted machines.

(iv) Run the scripts individually, preferably in RStudio.

(v) In order to run the crude oil script, you must acquire an EIA API key, at no charge, at http://www.eia.gov/beta/api/register.cfm. Then enter your API key where indicated in the Crude.R script.

##Scripts Included
###Options Analysis (options.r)
This script takes the April 2nd AAPL call, and compares it with the underlying asset AAPL. The script pulls historical data from Interactive Brokers, and uses the quantmod package to plot charts of the volatility. The script finally shows a summary output of statistical data taken from the comparison.

###Crude Oil Analysis (crude.r)
One of the biggest topics in the markets right now is crude oil. This script shows the relationship between the May 2015 WTI crude oil futures and U.S. field production of crude oil weekly figures, in thousands of barrels. The price data is pulled from Interactive Brokers, while the production data is pulled from the United States Energy Information Administration website via their API. Follow instructions above to get access to their API if you wish to run this code for yourself. The following two figures show the inverse relationship between the two figures.

#####Crude Oil Plots
![alt tag](https://raw.githubusercontent.com/mkirch/Interactive-Brokers-Analysis/master/productionData.png)
![alt tag](https://raw.githubusercontent.com/mkirch/Interactive-Brokers-Analysis/master/priceData.png)
##Future Additions
* Analyze effect of weekly Wednesday EIA production reports on crude oil future prices
  

##Style Methodology
The included code attempts to follow Google's R Style Guide as closely as possible. More information on this can be found at: https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml

