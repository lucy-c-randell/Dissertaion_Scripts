#!/bin/bash

# Output shapefile name
OUTPUT="merged_bedrock.shp"

# Check if there are any .shp files in the current directory
shapefiles=(*.shp)
if [ ${#shapefiles[@]} -eq 0 ]; then
    echo "No .shp files found in the current directory."
    exit 1
fi

# Take the first shapefile as the base for the merged shapefile
echo "Creating merged shapefile from ${shapefiles[0]}..."
ogr2ogr -f "ESRI Shapefile" "$OUTPUT" "${shapefiles[0]}"

# Loop through and append the rest of the shapefiles
for shp in "${shapefiles[@]:1}"; do
    echo "Merging $shp into $OUTPUT..."
    ogr2ogr -f "ESRI Shapefile" -update -append "$OUTPUT" "$shp" -nln merged_bedrock
done

echo "Merge completed. Merged shapefile is $OUTPUT."
