#'---
#'title: "kutnerALSM5e Appendix C Data Sets"
#'output:
#'  rmarkdown::html_vignette:
#'    toc: true
#'    number_sections: true
#'bibliography: references.bib
#'vignette: >
#'  %\VignetteIndexEntry{kutnerALSM5e Appendix C Data Sets}
#'  %\VignetteEngine{knitr::rmarkdown}
#'  %\VignetteEncoding{UTF-8}
#'---
#'
#+ label = "setup"
#/*
devtools::load_all()
#*/
library(kutnerALSM5e)
packageVersion("kutnerALSM5e")
#'
#' Documentation and construction of the provided data sets in
#' @kutner2005applied.
#'
#' # Data Set C.1 SENIC
#'
#' The primary object of the Study on the Efficiency of Nosocomial Infection
#' Control (**SENIC** Project [@SENIC]) was to determine whether infection
#' surveillance and control programs have reduced the rates of nosocomial
#' (hospital-acquired) infection in United States hospitals.  The data set
#' consists of a random sample of 113 hospitals selected from the original 338
#' hospital surveyed.
#'
#' Each line of the data set has an identification number and provides
#' information on 11 other variable for the single hospital.  The data presented
#' here are for the 1975-76 study period.  The 12 variables are:
#'
#+ label = "data_c1_data_dict", echo = TRUE, results = "asis"
SENIC <-
  read.table(
    file = system.file("datasets", "APPENC01.txt", package = "kutnerALSM5e")
  , header = FALSE
  , col.names = c(
      "id"
    , "lenght_of_stay"
    , "age"
    , "infection_risk"
    , "culturing_ratio"
    , "chest_x_ray_ratio"
    , "number_of_beds"
    , "medical_school_affiliation"
    , "region"
    , "average_daily_census"
    , "number_of_nurses"
    , "available_facilities_and_services"
    )
  )

#'
#'
#' # References
#'
#'<div id="refs"></div>
#'
#' # Session Info
#+ label = "sessioninfo"
sessionInfo()

# /* ---------------------------- END OF FILE ------------------------------- */
