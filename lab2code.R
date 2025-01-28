
##############################################################################
# Lab 2
# Avery Johnson
##############################################################################

##############################################################################
# Task 1: Build a Batch File for Data Processing
##############################################################################


# Step 1: Find the command required to list all of the directories in a
# specific directory and use it to find all subdirectories of MUSIC/

library("stringr")
# help("stringr")

music.directories <- list.dirs("Music")

# Step 2: Use the str_count() function to count the number of (/) in each
# directory
num_slashes <- str_count(music.directories, "/")
album_subdirectories <- music.directories[num_slashes==2]

# Step 3: For each album subdirectory, complete the following tasks

#WILL ADD A FOR LOOP HERE

#test file for now
  test.album <- album_subdirectories[1]
  
  #substep 1: list all files in the album subdirectory
  all.files <- list.files(test.album, recursive=TRUE)
    
  #substep 2: filter all .WAV files
  wav_count <- str_count(all.files, "\\.wav")
  wav_file_indicies <- which(wav_count > 0)
  wav_files <- all.files[wav_file_indicies]
  
    #substep 3: process each .WAV file
    code.to.procesess <- c() #initialize empty vector
    
    test.file <- wav_files[1]
    # WILL ADD ANOTHER FOR LOOP HERE
    
    # (a) create an object containing the track file location
    track_file_location <- paste(test.album, "/", test.file, sep = "")
    
    # (b) create an object containing the current track's filename
    track_name <- str_sub(test.file, start=1, end=str_length(test.file) - 4)  # Remove '.WAV'
    track_name_parts <- str_split(track_name, "-", simplify=TRUE)
    album_parts <- str_split(test.album, "/", simplify=TRUE)
    # (c) desired output file
    artist <- track_name_parts[2]
    album <- album_parts[3]
    track<- track_name_parts[3]
    
    output_filename <- paste(artist,"-",album,"-", track, ".json", sep = "")
    
    # (d) create command line prompt
    command <- paste("streaming_extractor.exe", test.file, output_filename)
    
    code.to.procesess <- c(code.to.procesess, command)

# Step 4: write the code.to.process vector to a .txt file