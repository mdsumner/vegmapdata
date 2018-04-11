
<!-- README.md is generated from README.Rmd. Please edit that file -->
vegmapdata
==========

The goal of vegmapdata is to provide a fast and simple compromise to accessing TASVEG polygon classifications.

WORK IN PROGRESS

The basic idea is to have the data frame of fields, and a nicely compressed GeoTIFF version of the data frame row IDs. Currently at 10m resolution only. (See /data-raw/).

TODO

rerun the script to put the UTM zone CRS on properly, the GeoTIFF is currently un-crs ready because I read the geometry on its own. (Use "+init=epsg:32755").
