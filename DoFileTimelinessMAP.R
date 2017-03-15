install.packages("rworldmap")
install.packages("RCologBrewer")
library(rworldmap)
library(classInt)
library(RColorBrewer)
#upload data
DF=read.csv("TimelinessMAP.csv")
#clean data
DF<-DF[1:170,2:3]
DF$Index<-round(DF$Change/30,digits=0)
#create datamap input
sPDF<-joinCountryData2Map(DF, joinCode="ISO3",nameJoinColumn="ISO3")
#getting class intervals
classInt <- classIntervals( sPDF[["Index"]],n=7, style = "jenks")
#catMethod = classInt[["brks"]]
catMethod = c(-4,-3,-2,-1,-.1,0,1,2,3,6)

#getting colours
colourPalette <- brewer.pal(7,'RdYlGn')
#plot map
mapDevice() #create world map shaped window
mapParams <- mapCountryData(sPDF
                            ,nameColumnToPlot="Index"
                            ,addLegend=FALSE
                            ,catMethod = catMethod
                            ,oceanCol='lightblue'
                            ,missingCountryCol='grey'
                            ,borderCol='black'
                            ,colourPalette=colourPalette )

#adding legend
do.call(addMapLegend
        ,c(mapParams
           ,legendLabels="all"
           ,legendWidth=0.5
           ,legendIntervals="data"
           ,legendMar = 2))