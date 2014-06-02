#' Download FAF3 data to Rdata File
#'
#' Function to download part or all of the FAF3 data from the web to the /data folder.
#' It uses downloadsavezip to download, read it into a data frame/spatial format, save that
#' to an Rdata file for later use and then remove from workspace.
#' @param  datatypes Elements of the FAF data to download, character vector containing one or more of c("OD","2011OD","NETWORK","ZONES"), defaults to all
#' @param  subfoldername Name for a subfolder within /data to store the files in (character string, defaults to "")
#' @param  overwrite TRUE/FALSE to indicate whether to download and overwrite a file with the same name (defaults to FALSE)
#' @keywords download faf
#' @export
#' @examples
#' downloadfaf3()

downloadfaf <- function(datatypes=c("OD","2011OD","NETWORK","ZONES"), subfoldername="", overwrite=FALSE){
  
#check that data only includes one of the required four data types
  
  datatypesu <- toupper(datatypes)
  
  if(!datatypesu %in% c("OD","2011OD","NETWORK","ZONES")) stop("datatypes should contain one or more of 'OD','2011OD','NETWORK','ZONES'")

  if("OD" %in% datatypesu){

    #Full FAF 3 OD data -- download from http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/faf3_4.zip
    downloadsavezip(website="http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/",
                    zipfilename="faf3_4.zip",
                    datafilename="faf3.4_data",
                    datafiletype="csv",
                    objectname="faf3",
                    outfilename="faf3.Rdata",
                    subfoldername=subfoldername,
                    overwrite=overwrite)
  }
  
  if("2011OD" %in% datatypesu){

    #2011 Provisional Data -- http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/faf3_4_prov2011.zip
    downloadsavezip(website="http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/",
                    zipfilename="faf3_4_prov2011.zip",
                    datafilename="faf3.4_provisional_2011",
                    datafiletype="csv",
                    objectname="faf34p2011",
                    outfilename="faf34p2011.Rdata",
                    subfoldername=subfoldername,
                    overwrite=overwrite)
  }

  if("NETWORK" %in% datatypesu){
  
  #FAF 3 Network, ESRI Format (shapefile)
  downloadsavezip(website="http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/netwkdbflow/network/esri/",
                  zipfilename="faf3_4_esri.zip",
                  subfoldername="faf3_4_esri",
                  datafilename="FAF3.4_Network",
                  datafiletype="shp",
                  objectname="faf3net",
                  outfilename="faf3net.Rdata",
                  subfoldername=subfoldername,
                  overwrite=overwrite)
  }

  if("ZONES" %in% datatypesu){
  
    #FAF3 Regions Boundary Layer, ESRI Format (shapefile)
    downloadsavezip(website="http://www.ops.fhwa.dot.gov/freight/freight_analysis/faf/faf3/netwkdbflow/regboundary/",
                    zipfilename="faf3_zone_esri.zip",
                    datafilename="FAF3-Zone",
                    datafiletype="shp",
                    objectname="faf3zone",
                    outfilename="faf3zone.Rdata",
                    subfoldername=subfoldername,
                    overwrite=overwrite)
  }

}