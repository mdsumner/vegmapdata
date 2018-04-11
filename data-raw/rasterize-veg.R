vm <- "...data_local/tas.gov.au/TASVEG/GDB/TASVEG3.gdb"
library(vapour)
vegdata <- tibble::as_tibble(vapour::vapour_read_attributes(vm))
#66.8Mb
vegeom <- vapour::vapour_read_geometry(vm)
vegeom <- sf::st_as_sfc(vegeom)
library(sf)
x <- st_sf(geometry = vegeom, rownum = seq_along(vegeom))
x$rownum <- seq_len(nrow(x))
library(raster)
r <- raster(spex::buffer_extent(x, 10), res = 10)
library(fasterize)
vegraster <- fasterize::fasterize(x, r, field = "rownum")
saveRDS(vegraster, "vegraster.rds", compress = FALSE)
saveRDS(vegdata, "vegdata.rds", compress = "bzip2")

library(raster)
vegraster <- readRDS("vegraster.rds")
veg1 <- crop(vegraster, extent(vegraster, 1, 20000, 1, ncol(vegraster)),
             filename = "veg1.grd", datatype = "INT4U")
veg1 <- crop(vegraster, extent(vegraster, 20001, nrow(vegraster), 1, ncol(vegraster)),
             filename = "veg2.grd", datatype = "INT4U")
system("gdalbuildvrt veg.vrt veg1.grd veg2.grd")
system("gdal_translate veg.vrt vegmap3.tif  -a_srs 32755 -ot UInt32 -co COMPRESS=DEFLATE -co TILED=YES")

