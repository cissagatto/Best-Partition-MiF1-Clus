##############################################################################
# BEST PARTITION MICRO-F1 CLUS                                               #
# Copyright (C) 2021                                                         #
#                                                                            #
# This code is free software: you can redistribute it and/or modify it under #
# the terms of the GNU General Public License as published by the Free       #
# Software Foundation, either version 3 of the License, or (at your option)  #
# any later version. This code is distributed in the hope that it will be    #
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of     #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General   #
# Public License for more details.                                           #
#                                                                            #
# Elaine Cecilia Gatto | Prof. Dr. Ricardo Cerri | Prof. Dr. Mauri           #
# Ferrandin | Federal University of Sao Carlos                               #
# (UFSCar: https://www2.ufscar.br/) Campus Sao Carlos | Computer Department  #
# (DC: https://site.dc.ufscar.br/) | Program of Post Graduation in Computer  #
# Science (PPG-CC: http://ppgcc.dc.ufscar.br/) | Bioinformatics and Machine  #
# Learning Group (BIOMAL: http://www.biomal.ufscar.br/)                      #
#                                                                            #
##############################################################################


###########################################################################
#
###########################################################################
FolderRoot = "~/Best-Partition-MiF1-Clus"
FolderScripts = "~/Best-Partition-MiF1-Clus/R"

#########################################################################
# FUNCTION DIRECTORIES                                   
#   Objective:                                           
#      Creates all the necessary folders for the project.
#   Parameters:                                          
#      dataset_name: name of the dataset                 
#      folderResults: path to save process the algorithm. 
#               Example: "/dev/shm/birds", "/scratch/birds", 
#            "/home/usuario/birds", "/C:/Users/usuario/birds"
#   Return:                                                              
#      All path directories                                              
#########################################################################
directories <- function(dataset_name, folderResults, similarity){
  
  retorno = list()
  
  #############################################################################
  # RESULTS FOLDER:                                                           #
  # Parameter from command line. This folder will be delete at the end of the #
  # execution. Other folder is used to store definitely the results.          #
  # Example: "/dev/shm/res"                                                   #
  #############################################################################
  if(dir.exists(folderResults) == TRUE){
    setwd(folderResults)
    dir_folderResults = dir(folderResults)
    n_folderResults = length(dir_folderResults)
  } else {
    dir.create(folderResults)
    setwd(folderResults)
    dir_folderResults = dir(folderResults)
    n_folderResults = length(dir_folderResults)
  }
  
  
  #############################################################################
  # UTILS FOLDER:                                                             #
  # Get information about the files within folder utils that already exists   #
  # in the project. It's needed to run CLUS framework and convert CSV files   #
  # in ARFF files correctly.                                                  #
  # "/home/[user]/Partitions-Kohonen/utils"                                   #
  #############################################################################
  folderUtils = paste(FolderRoot, "/Utils", sep="")
  if(dir.exists(folderUtils) == TRUE){
    setwd(folderUtils)
    dir_folderUtils = dir(folderUtils)
    n_folderUtils = length(dir_folderUtils)
  } else {
    dir.create(folderUtils)
    setwd(folderUtils)
    dir_folderUtils = dir(folderUtils)
    n_folderUtils = length(dir_folderUtils)
  }
  
  
  #############################################################################
  #
  #############################################################################
  folderReports = paste(FolderRoot, "/Reports", sep="")
  if(dir.exists(folderReports) == TRUE){
    setwd(folderReports)
    dir_folderReports = dir(folderReports)
    n_folderReports = length(dir_folderReports)
  } else {
    dir.create(folderReports)
    setwd(folderReports)
    dir_folderReports = dir(folderReports)
    n_folderReports = length(dir_folderReports)
  }
  
  
  #############################################################################
  #
  #############################################################################
  folderRS = paste(folderReports, "/", similarity, sep="")
  if(dir.exists(folderRS) == TRUE){
    setwd(folderRS)
    dir_folderRS = dir(folderRS)
    n_folderRS = length(dir_folderRS)
  } else {
    dir.create(folderRS)
    setwd(folderRS)
    dir_folderRS = dir(folderRS)
    n_folderRS = length(dir_folderRS)
  }
  
  
  
  
  
  #############################################################################
  # DATASETS FOLDER:                                                          #
  # Get the information within DATASETS folder that already exists in the     #
  # project. This folder store the files from cross-validation and will be    #
  # use to get the label space to modeling the label correlations and         #
  # compute silhouete to choose the best hybrid partition.                    #
  # "/home/[user]/Partitions-Kohonen/datasets"                                #
  #############################################################################
  folderDatasets = paste(folderResults, "/Datasets", sep="")
  if(dir.exists(folderDatasets) == TRUE){
    setwd(folderDatasets)
    dir_folderDatasets = dir(folderDatasets)
    n_folderDatasets = length(dir_folderDatasets)
  } else {
    dir.create(folderDatasets)
    setwd(folderDatasets)
    dir_folderDatasets = dir(folderDatasets)
    n_folderDatasets = length(dir_folderDatasets)
  }
  
  
  #############################################################################
  # SPECIFIC DATASET FOLDER:                                                  #
  # Path to the specific dataset that is runing. Example: with you are        # 
  # running this code for EMOTIONS dataset, then this get the path from it    #
  # "/home/[user]/Partitions-Kohonen/datasets/birds"                          #
  #############################################################################
  folderSpecificDataset = paste(folderDatasets, "/", dataset_name, sep="")
  if(dir.exists(folderSpecificDataset) == TRUE){
    setwd(folderSpecificDataset)
    dir_folderSpecificDataset = dir(folderSpecificDataset)
    n_folderSpecificDataset = length(dir_folderSpecificDataset)
  } else {
    dir.create(folderSpecificDataset)
    setwd(folderSpecificDataset)
    dir_folderSpecificDataset = dir(folderSpecificDataset)
    n_folderSpecificDataset = length(dir_folderSpecificDataset)
  }
  
  
  #############################################################################
  # LABEL SPACE FOLDER:                                                       #
  # Path to the specific label space from the dataset that is runing.         #
  # This folder store the label space for each FOLD from the cross-validation #
  # which was computed in the Cross-Validation Multi-Label code.              #
  # In this way, we don't need to load the entire dataset into the running    #
  # "/home/elaine/Partitions-Kohonen/datasets/birds/LabelSpace"               #
  #############################################################################
  folderLabelSpace = paste(folderSpecificDataset, "/LabelSpace", sep="")
  if(dir.exists(folderLabelSpace) == TRUE){
    setwd(folderLabelSpace)
    dir_folderLabelSpace = dir(folderLabelSpace)
    n_folderLabelSpace = length(dir_folderLabelSpace)
  } else {
    dir.create(folderLabelSpace)
    setwd(folderLabelSpace)
    dir_folderLabelSpace = dir(folderLabelSpace)
    n_folderLabelSpace = length(dir_folderLabelSpace)
  }
  
  
  #############################################################################
  # NAMES LABELS FOLDER:                                                      #
  # Get the names of the labels from this dataset. This will be used in the   #
  # code to create the groups for each partition. Is a way to guarantee the   #
  # use of the correct names labels.                                          #
  # "/home/[user]/Partitions-Kohonen/datasets/birds/NamesLabels"              #
  #############################################################################
  folderNamesLabels = paste(folderSpecificDataset, "/NamesLabels", sep="")
  if(dir.exists(folderNamesLabels) == TRUE){
    setwd(folderNamesLabels)
    dir_folderNamesLabels = dir(folderNamesLabels)
    n_folderNamesLabels = length(dir_folderNamesLabels)
  } else {
    dir.create(folderNamesLabels)
    setwd(folderNamesLabels)
    dir_folderNamesLabels = dir(folderNamesLabels)
    n_folderNamesLabels = length(dir_folderNamesLabels)
  }
  
  
  #############################################################################
  # CROSS VALIDATION FOLDER:                                                  #
  # Path to the folders and files from cross-validation for the specific      # 
  # dataset                                                                   #
  # "/home/[user]/Partitions-Kohonen/datasets/birds/CrossValidation"          #
  #############################################################################
  folderCV = paste(folderSpecificDataset, "/CrossValidation", sep="")
  if(dir.exists(folderCV) == TRUE){
    setwd(folderCV)
    dir_folderCV = dir(folderCV)
    n_folderCV = length(dir_folderCV)
  } else {
    dir.create(folderCV)
    setwd(folderCV)
    dir_folderCV = dir(folderCV)
    n_folderCV = length(dir_folderCV)
  }
  
  
  #############################################################################
  # TRAIN CROSS VALIDATION FOLDER:                                            #
  # Path to the train files from cross-validation for the specific dataset    #                                                                   #
  # "/home/[user]/Partitions-Kohonen/datasets/birds/CrossValidation/Tr"       #
  #############################################################################
  folderCVTR = paste(folderCV, "/Tr", sep="")
  if(dir.exists(folderCVTR) == TRUE){
    setwd(folderCVTR)
    dir_folderCVTR = dir(folderCVTR)
    n_folderCVTR = length(dir_folderCVTR)
  } else {
    dir.create(folderCVTR)
    setwd(folderCVTR)
    dir_folderCVTR = dir(folderCVTR)
    n_folderCVTR = length(dir_folderCVTR)
  }
  
  
  #############################################################################
  # TEST CROSS VALIDATION FOLDER:                                             #
  # Path to the test files from cross-validation for the specific dataset     #                                                                   #
  # "/home/[user]/Partitions-Kohonen/datasets/birds/CrossValidation/Ts"       #
  #############################################################################
  folderCVTS = paste(folderCV, "/Ts", sep="")
  if(dir.exists(folderCVTS) == TRUE){
    setwd(folderCVTS)
    dir_folderCVTS = dir(folderCVTS)
    n_folderCVTS = length(dir_folderCVTS)
  } else {
    dir.create(folderCVTS)
    setwd(folderCVTS)
    dir_folderCVTS = dir(folderCVTS)
    n_folderCVTS = length(dir_folderCVTS)
  }
  
  
  #############################################################################
  # VALIDATION CROSS VALIDATION FOLDER:                                       #
  # Path to the validation files from cross-validation for the specific       #
  # dataset                                                                   #                                                           
  # "/home/[user]/Partitions-Kohonen/datasets/birds/CrossValidation/Vl"       #
  #############################################################################
  folderCVVL = paste(folderCV, "/Vl", sep="")
  if(dir.exists(folderCVVL) == TRUE){
    setwd(folderCVVL)
    dir_folderCVVL = dir(folderCVVL)
    n_folderCVVL = length(dir_folderCVVL)
  } else {
    dir.create(folderCVVL)
    setwd(folderCVVL)
    dir_folderCVVL = dir(folderCVVL)
    n_folderCVVL = length(dir_folderCVVL)
  }
  
  
  #############################################################################
  # RESULTS DATASET FOLDER:                                                   #
  # Path to the results for the specific dataset that is running              #                                                           
  # "/dev/shm/res/birds"                                                      #
  #############################################################################
  folderResultsDataset = paste(folderResults, "/", dataset_name, sep="")
  if(dir.exists(folderResultsDataset) == TRUE){
    setwd(folderResultsDataset)
    dir_folderResultsDataset = dir(folderResultsDataset)
    n_folderResultsDataset = length(dir_folderResultsDataset)
  } else {
    dir.create(folderResultsDataset)
    setwd(folderResultsDataset)
    dir_folderResultsDataset = dir(folderResultsDataset)
    n_folderResultsDataset = length(dir_folderResultsDataset)
  }
  
  #############################################################################
  # RESULTS PARTITIONS FOLDER:                                                #
  # Folder to store the results from partitioning the label correlations      #
  # "/dev/shm/res/birds/Partitions"                                           #
  #############################################################################
  folderPartitions = paste(folderResults, "/Partitions", sep="")
  if(dir.exists(folderPartitions) == TRUE){
    setwd(folderPartitions)
    dir_folderPartitions = dir(folderPartitions)
    n_folderPartitions = length(dir_folderPartitions)
  } else {
    dir.create(folderPartitions)
    setwd(folderPartitions)
    dir_folderPartitions = dir(folderPartitions)
    n_folderPartitions = length(dir_folderPartitions)
  }
  
  
  
  #############################################################################
  # OUTPUT FOLDER:                                                            #
  # This folder is used to store information that will be the INPUT for the   #
  # next phase of the strategy, i.e., find the best hybrid partition with     #
  # silhouete measure partitioning or macro-f1 measure performance.           #
  # Therefore, OUTPUT folder will be used as INPUT folder in next phase.      #
  # "/home/[user]/Partitions-Kohonen/Output"                                  #
  #############################################################################
  folderOutput = paste(FolderRoot, "/Output", sep="")
  if(dir.exists(folderOutput) == TRUE){
    setwd(folderOutput)
    dir_folderOutput = dir(folderOutput)
    n_folderOutput = length(dir_folderOutput)
  } else {
    dir.create(folderOutput)
    setwd(folderOutput)
    dir_folderOutput = dir(folderOutput)
    n_folderOutput = length(dir_folderOutput)
  }
  
  
  #############################################################################
  
  #############################################################################
  folderOS = paste(folderOutput, "/", similarity, sep="")
  if(dir.exists(folderOS) == TRUE){
    setwd(folderOS)
    dir_folderOS  = dir(folderOS )
    n_folderOS = length(dir_folderOS )
  } else {
    dir.create(folderOS)
    setwd(folderOS)
    dir_folderOS  = dir(folderOS )
    n_folderOS = length(dir_folderOS )
  }
  
  
  #############################################################################
  
  #############################################################################
  folderOutputDataset = paste(folderOS, "/", dataset_name, sep="")
  if(dir.exists(folderOutputDataset) == TRUE){
    setwd(folderOutputDataset)
    dir_folderOutputDataset = dir(folderOutputDataset)
    n_folderOutputDataset = length(dir_folderOutputDataset)
  } else {
    dir.create(folderOutputDataset)
    setwd(folderOutputDataset)
    dir_folderOutputDataset = dir(folderOutputDataset)
    n_folderOutputDataset = length(dir_folderOutputDataset)
  }
  
  
  #############################################################################
  # RETURN ALL PATHS                                                          #
  #############################################################################
  retorno$folderReports = folderReports
  retorno$folderRS = folderRS
  retorno$folderResults = folderResults
  retorno$folderUtils = folderUtils
  retorno$folderDatasets = folderDatasets
  retorno$folderSpecificDataset = folderSpecificDataset
  retorno$folderLabelSpace = folderLabelSpace
  retorno$folderNamesLabels = folderNamesLabels
  retorno$folderCV = folderCV
  retorno$folderCVTR = folderCVTR
  retorno$folderCVTS = folderCVTS
  retorno$folderCVVL = folderCVVL
  retorno$folderPartitions = folderPartitions
  retorno$folderOutput = folderOutput
  retorno$folderOS = folderOS
  retorno$folderOutputDataset = folderOutputDataset
  retorno$folderResultsDataset = folderResultsDataset
  
  
  #############################################################################
  # RETURN ALL DIRS                                                           #
  #############################################################################
  retorno$dir_folderReports = dir_folderReports
  retorno$dir_folderRS = dir_folderRS
  retorno$dir_folderResults = dir_folderResults
  retorno$dir_folderUtils = dir_folderUtils
  retorno$dir_folderDatasets = dir_folderDatasets
  retorno$dir_folderSpecificDataset = dir_folderSpecificDataset
  retorno$dir_folderLabelSpace = dir_folderLabelSpace
  retorno$dir_folderNamesLabels = dir_folderNamesLabels
  retorno$dir_folderCV = dir_folderCV
  retorno$dir_folderCVTR = dir_folderCVTR
  retorno$dir_folderCVTS = dir_folderCVTS
  retorno$dir_folderCVVL = dir_folderCVVL
  retorno$dir_folderPartitions = dir_folderPartitions
  retorno$dir_folderOutput = dir_folderOutput
  retorno$dir_folderOS = dir_folderOS
  retorno$dir_folderOutputDataset = dir_folderOutputDataset
  retorno$dir_folderResultsDataset = dir_folderResultsDataset
  
  
  #############################################################################
  # RETURN ALL LENGHTS                                                        #
  #############################################################################
  retorno$n_folderReports = n_folderReports
  retorno$n_folderRS = n_folderRS
  retorno$n_folderResults = n_folderResults
  retorno$n_folderUtils = n_folderUtils
  retorno$n_folderDatasets = n_folderDatasets
  retorno$n_folderSpecificDataset = n_folderSpecificDataset
  retorno$n_folderLabelSpace = n_folderLabelSpace
  retorno$n_folderNamesLabels = n_folderNamesLabels
  retorno$n_folderCV = n_folderCV
  retorno$n_folderCVTR = n_folderCVTR
  retorno$n_folderCVTS = n_folderCVTS
  retorno$n_folderCVVL = n_folderCVVL
  retorno$n_folderPartitions = n_folderPartitions
  retorno$n_folderOutput = n_folderOutput
  retorno$n_folderOS = n_folderOS
  retorno$n_folderOutputDataset = n_folderOutputDataset
  retorno$n_folderResultsDataset = n_folderResultsDataset
  
  return(retorno)
  gc()
}



###########################################################################
# FUNCTION LABEL SPACE                                                  
#   Objective                                                           
#       Separates the label space from the rest of the data to be used
#      as input for calculating correlations                          
#   Parameters                                                        
#       ds: specific dataset information
#       dataset_name: dataset name. It is used to save files.
#       number_folds: number of folds created                
#       folderResults: folder where to save results          
#   Return:                                                  
#       Training set labels space                            
#######################################################################
labelSpace <- function(ds, dataset_name, number_folds, folderResults){
  
  retorno = list()
  
  # return all fold label space
  classes = list()
  
  # get the directories
  diretorios = directories(dataset_name, folderResults, similarity)
  
  # from the first FOLD to the last
  k = 1
  while(k<=number_folds){
    
    # cat("\n\tFold: ", k)
    
    # enter folder train
    setwd(diretorios$folderCVTR)
    
    # get the correct fold cross-validation
    nome_arquivo = paste(dataset_name, "-Split-Tr-", k, ".csv", sep="")
    
    # open the file
    arquivo = data.frame(read.csv(nome_arquivo))
    
    # split label space from input space
    classes[[k]] = arquivo[,ds$LabelStart:ds$LabelEnd]
    
    # get the names labels
    namesLabels = c(colnames(classes[[k]]))
    
    # increment FOLD
    k = k + 1 
    
    # garbage collection
    gc() 
    
  } # End While of the 10-folds
  
  # return results
  retorno$NamesLabels = namesLabels
  retorno$Classes = classes
  return(retorno)
  
  gc()
  cat("\n##########################################################")
  cat("\n# FUNCTION LABEL SPACE: END                              #") 
  cat("\n##########################################################")
  cat("\n\n\n\n")
}


#######################################################################
# FUNCTION INFO DATA SET                                               
#  Objective                                                           
#     Gets the information that is in the "datasets-hpmlk.csv" file.   
#  Parameters                                                          
#     dataset: the specific dataset                                    
#  Return                                                              
#     Everything in the "datasets-hpmlk.csv" file.                     
#######################################################################
infoDataSet <- function(dataset){
  
  retorno = list()
  
  retorno$id = dataset$ID
  retorno$name = dataset$Name
  retorno$instances = dataset$Instances
  retorno$inputs = dataset$Inputs
  retorno$labels = dataset$Labels
  retorno$LabelsSets = dataset$LabelsSets
  retorno$single = dataset$Single
  retorno$maxfreq = dataset$MaxFreq
  retorno$card = dataset$Card
  retorno$dens = dataset$Dens
  retorno$mean = dataset$Mean
  retorno$scumble = dataset$Scumble
  retorno$tcs = dataset$TCS
  retorno$attStart = dataset$AttStart
  retorno$attEnd = dataset$AttEnd
  retorno$labStart = dataset$LabelStart
  retorno$labEnd = dataset$LabelEnd
  retorno$distinct = dataset$Distinct
  retorno$xn = dataset$xn
  retorno$yn = dataset$yn
  retorno$gridn = dataset$gridn
  
  return(retorno)
  
  gc()
}




###########################################################################
# Please, any errors, contact us: elainececiliagatto@gmail.com            #
# Thank you very much!                                                    #
###########################################################################
