#!/bin/bash
# Quick and dirty script to generate the maps for Weathermap
# Originally by Alek Patsouris - https://alek.id.au

# Where is your PHP binary?
PHPBIN="/bin/php"
# Fill in your Observium URL here
OWMURL="http://`hostname`/weathermap/maps"

# Change into the directory (Observium / Weathermap uses a LOT of relative paths)
cd /opt/observium/html/weathermap

# Loop through the config files
for i in `ls configs/*.conf`; do
   # Strip down to just the NAME of the config, no folders, no extensions
   # There is probably a better way to do this, but this works for me
   FPATH="${i##*/}"
   FNAME="${FPATH%.*}"
   # Run the generation command 
   $PHPBIN /opt/observium/html/weathermap/weathermap --config=/opt/observium/html/weathermap/"$i" --image-uri=$OWMURL/$FNAME.png --base-href=/weathermap/
   # Move the files generated into the map folder
   mv -f /opt/observium/html/weathermap/"$FNAME".html /opt/observium/html/weathermap/"$FNAME".png /opt/observium/html/weathermap/maps
done
