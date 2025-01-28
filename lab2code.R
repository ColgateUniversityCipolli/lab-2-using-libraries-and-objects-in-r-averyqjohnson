
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

# Step 2: Use the str_count() function to count the numbner of (/) in each
# directory
num_slashes <- str_count(music.directories, "/")

