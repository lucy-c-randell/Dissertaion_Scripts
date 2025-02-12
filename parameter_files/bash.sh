#!/bin/bash

#SBATCH --account=geos_extra
#SBATCH --mem=85G
#SBATCH --cpus-per-task=1
#SBATCH --output=lsdttbm-%A.out
#SBATCH --error=lsdttbm-%A.err

#run lsdtt-chi-metrics
lsdtt-chi-mapping pennines.txt

#All done

