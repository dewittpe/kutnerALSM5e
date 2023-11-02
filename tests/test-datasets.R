# Verify the wanted data sets are available:
# * "Item" is the name used in code
# * "Title" is the title of the dataset defined in the documentation file R/dataset.R
datasets <- data(package = "kutnerALSM5e")$results
stopifnot(identical(unname(datasets[, "Item"]), c("SENIC")))
stopifnot(identical(unname(datasets[, "Title"]), c("SENIC")))
