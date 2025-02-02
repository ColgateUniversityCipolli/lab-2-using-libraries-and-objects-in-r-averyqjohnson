
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

music.directories <- list.dirs("Music")

# Step 2: Use the str_count() function to count the number of (/) in each
# directory
num_slashes <- str_count(music.directories, "/")
album_subdirectories <- music.directories[num_slashes==2]

code.to.process <- c() #initialize empty vector

# Step 3: For each album subdirectory, complete the following tasks

for (album.sub in 1:length(album_subdirectories)) {
  #substep 1: list all files in the album subdirectory
  
  album.sub <- album_subdirectories[album.sub]
  
  all.files <- list.files(album.sub, recursive=TRUE)
    
  #substep 2: filter all .WAV files
  wav_count <- str_count(all.files, "\\.wav")
  wav_file_indicies <- which(wav_count > 0)
  wav_files <- all.files[wav_file_indicies]
  
  #substep 3: process each .WAV file
  for (wav.file in 1:length(wav_files)) {
    
    wav.file <- wav_files[wav.file]
    # (a) create an object containin)g the track file location
    track_file_location <- paste(album.sub, "/", wav.file, sep = "")
    
    # (b) create an object containing the current track's filename
    track_name <- str_sub(wav.file, start=1, end=str_length(wav.file) - 4)  # Remove '.WAV'
    track_name_parts <- str_split(track_name, "-", simplify=TRUE)
    album_parts <- str_split(album.sub, "/", simplify=TRUE)
    # (c) desired output file
    artist <- track_name_parts[2]
    album <- album_parts[3]
    track<- track_name_parts[3]
    
    output_filename <- paste(artist,"-",album,"-", track, ".json", sep = "")
    #output.file <- c(output.file, output_filename)
    
    # (d) create command line prompt
    command <- paste("streaming_extractor_music.exe", " ", '"', wav.file, '"', " ", '"',output_filename, '"', sep="")
    
    code.to.process <- c(code.to.process, command)
  }
}
# Step 4: write the code.to.process vector to a .txt file
writeLines(code.to.process, "batfile.txt")

##############################################################################
# Task 2: Process JSON Output
##############################################################################

# Step 0: Install the jsonlite package for R
library("jsonlite")
library("stringr")

# Step 1: extract the artists, album, and track from the file name
json_files <- list.files(pattern = "\\.json$")  # Find all JSON files
for (json_file in 1:length(json_files)) {
  json_file <- json_files[json_file]
  file_parts <- strsplit(json_file, "-")[[1]]
  artist <- file_parts[1]
  album <- file_parts[2]
  track <- file_parts [3]
  track <- str_sub (track, start=1, end=str_length(track)-5) # Remove .json
  
  # load JSON data
  json_data <- fromJSON(json_file)
  
  #Step 3: extract the required features
  avg_loudness <- json_data$lowlevel$average_loudness
  spectral_energy_mean <- json_data$lowlevel$spectral_energy$mean
  danceability <- json_data$rhythm$danceability
  bpm <- json_data$rhythm$bpm
  key_key <- json_data$tonal$key_key
  key_scale <- json_data$tonal$key_scale
  length <- json_data$metadata$audio_properties$length
}