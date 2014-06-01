#' Download to Rdata File
#'
#' Function to download a zip file containing data in csv or shp format
#' from the web to the /data folder, read it into a data frame/spatial format
#' save that to an Rdata file for later use and then remove from workspace
#' @param website Path to website root where data to be downloaded are (character string)
#' @param zipfilename Name of zip file to download (character string including for example .zip)
#' @param  datafilename Filename (without file type ending) of the file in the zip file to extrat (character string)
#' @param  datafiletype Fietype of the file to extract (".csv" for comma seperated variable, ".shp" for shape files)
#' @param  objectname Object name to assign to the table of data in R (character string)
#' @param  outfilename Filename for the Rdata file that will store the data (character string)
#' @param  subfoldername Name for a subfolder within /data to store the files in (character string, defaults to "")
#' @param  overwrite TRUE/FALSE to indicate whether to download and overwrite a file with the same name (defaults to FALSE)
#' @keywords download
#' @export
#' @examples
#' downloadsavezip()

downloadsavezip <- function(website,zipfilename,datafilename,datafiletype,objectname,outfilename,subfoldername="",overwrite=FALSE){
  #create the data folder if it doesn't exist -- function hardcoded to download to /data
  if(!file.exists("data")) dir.create("data")
  #check if we already have downloaded and processed this file
  #or if we should download and ovewrite anyway
  if( !file.exists( file.path("data",outfilename)) | overwrite==TRUE ) {
    download.file(paste0(website, zipfilename),file.path("data",zipfilename),"auto")
    if(datafiletype=="csv"){
      #read in data from zip file (slow!) 
      assign(objectname,read.csv(unz(file.path(getwd(),"data",zipfilename),paste(datafilename,datafiletype,sep="."))))
    }
    if(datafiletype=="shp"){
      #upzip date and then read shape file, and save to an Rdata file for future use
      unzip(file.path(getwd(),"data",zipfilename),exdir="data")
      dsnpath <- file.path(getwd(),"data")
      if(subfoldername != "") dsnpath<-file.path(dsnpath,subfoldername)
      assign(objectname,readOGR(dsn=dsnpath,datafilename))
    }
    if(datafiletype %in% c("csv","shp")){
      #save to an Rdata file for future use  
      save(list=objectname,file=file.path("data",outfilename))
      rm(list=objectname)
      print(paste(paste0(website, zipfilename), "saved as", outfilename))
    } else {
      print("Filetypes that are currently support for import from downloaded zip files are csv and shp")
    }  
  } else {
    #if it was already there and told to not overwrite
    print(paste(paste0(website, zipfilename), "was previously downloaded and saved as", outfilename,"- to download again set overwrite=TRUE"))
  }
}