################################################################################
# Makefile
#
# This Makefile is not only for building qwraps2 but to serve as a template and
# example for other R packages.
#
################################################################################

PKG_ROOT    = .
PKG_VERSION = $(shell gawk '/^Version:/{print $$2}' $(PKG_ROOT)/DESCRIPTION)
PKG_NAME    = $(shell gawk '/^Package:/{print $$2}' $(PKG_ROOT)/DESCRIPTION)

CRAN = "https://cran.rstudio.com"

# General Package Dependencies
RFILES    = $(wildcard $(PKG_ROOT)/R/*.R)
TESTS     = $(wildcard $(PKG_ROOT)/tests/*.R)

# Targets
#
## Vignettes
# These are both targets for building and dependencies for the package tar.gz
# file
VIGNETTES  = $(PKG_ROOT)/vignettes/kutnerALSM5e-00-preface.Rmd
VIGNETTES  = $(PKG_ROOT)/vignettes/kutnerALSM5e-Appendix-C-Data-Sets.Rmd

################################################################################
# Recipes

.PHONY: all check install clean

all: $(PKG_NAME)_$(PKG_VERSION).tar.gz

$(PKG_NAME)_$(PKG_VERSION).tar.gz: .install_dev_deps.Rout .document.Rout $(VIGNETTES) $(TESTS)
	R CMD build --md5 $(build-options) $(PKG_ROOT)

.install_dev_deps.Rout : $(PKG_ROOT)/DESCRIPTION
	Rscript --vanilla --quiet -e "options(repo = c('$(CRAN)'))" \
		-e "if (!require(devtools)) {install.packages('devtools', repo = c('$(CRAN)'))}" \
		-e "options(warn = 2)" \
		-e "devtools::install_dev_deps()"
	touch $@

.document.Rout: $(SRC) $(RFILES) $(EXAMPLES) $(PKG_ROOT)/DESCRIPTION
	Rscript --vanilla --quiet -e "options(warn = 2)" \
		-e "devtools::document('$(PKG_ROOT)')"
	touch $@

################################################################################
# Recipes for Vignettes
#
# Expecting that the vignettes are built via knitr::spin
#
# List the explicit targets above

$(PKG_ROOT)/vignettes/%.Rmd : $(PKG_ROOT)/vignette-spinners/%.R
	R --vanilla --quiet -e "knitr::spin(hair = '$<', knit = FALSE)"
	mv $(basename $<).Rmd $@

################################################################################
# Other Recipes for checking the package, (un)installing, and cleaning the
# working directory.

check: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD check $(PKG_NAME)_$(PKG_VERSION).tar.gz

install: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R CMD INSTALL $(PKG_NAME)_$(PKG_VERSION).tar.gz

uninstall :
	R --vanilla --quiet -e "try(remove.packages('$(PKG_NAME)'), silent = TRUE)"

site: $(PKG_NAME)_$(PKG_VERSION).tar.gz
	R --vanilla --quiet -e "pkgdown::build_site()"

clean:
	$(RM) -f  $(PKG_NAME)_$(PKG_VERSION).tar.gz
	$(RM) -rf $(PKG_NAME).Rcheck
	$(RM) -f .document.Rout
	$(RM) -f .install_dev_deps.Rout

