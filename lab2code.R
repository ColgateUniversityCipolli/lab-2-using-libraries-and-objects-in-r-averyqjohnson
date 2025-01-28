
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

music.directories <- list.dirs("Music/", recurisve = TRUE)

