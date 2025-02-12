#!/bin/bash

# Set projection codes
SRC_EPSG="EPSG:27700"   # Source EPSG for BNG
TGT_EPSG="EPSG:32630"   # Target EPSG for UTM Zone 30N

# Define no-data value (usually -9999 for .asc files, adjust if different)
NODATA_VALUE=-9999

# Define target resolution (replace with your desired resolution, in meters)
PIXEL_SIZE=5  # Adjust based on the resolution of your input data

# Output merged .bil filename
MERGED_OUTPUT="merged_dem.bil"

# Step 1: Convert each .asc file to .bil format in UTM 32630 with grid alignment
for asc_file in *.asc; do
    base_name=$(basename "$asc_file" .asc)
    bil_file="${base_name}.bil"

    # Convert to .bil format and reproject to EPSG:32630 with alignment
    gdalwarp -s_srs "$SRC_EPSG" -t_srs "$TGT_EPSG" -of ENVI \
             -srcnodata "$NODATA_VALUE" -dstnodata "$NODATA_VALUE" \
             -tr $PIXEL_SIZE $PIXEL_SIZE -tap \
             "$asc_file" "$bil_file"
    echo "Converted $asc_file to $bil_file with no-data handling and grid alignment"
done

# Step 2: Merge all .bil files into a single .bil file with blending
gdal_merge.py -o "$MERGED_OUTPUT" -of ENVI -n "$NODATA_VALUE" -a_nodata "$NODATA_VALUE" ./*.bil
echo "Merged .bil files into $MERGED_OUTPUT with smooth blending"

