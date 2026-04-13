# ============================================================
#  SETUP.R  —  Run this ONCE to build and publish {euphoria}
#
#  Steps:
#    1. Install dependencies
#    2. Document (roxygen2 → man/ files + NAMESPACE)
#    3. Check the package
#    4. Generate the hex sticker
#    5. Build the README
#    6. Initialise git and push to GitHub
#    7. Build and deploy the pkgdown site
#
#  Prerequisites:
#    - R >= 4.1
#    - A GitHub account
#    - Run: gitcreds::gitcreds_set()  to store your GitHub PAT
# ============================================================

# ------------------------------------------------------------
# 0. Install required packages (run once)
# ------------------------------------------------------------
install.packages(c(
  "devtools",
  "usethis",
  "roxygen2",
  "pkgdown",
  "hexSticker",
  "showtext",
  "remotes",
  "gitcreds"
))

# ------------------------------------------------------------
# 1. Open the package project
#    (If you're not already inside the euphoria/ folder)
# ------------------------------------------------------------
# setwd("path/to/euphoria")      # <- point this at your euphoria/ folder
# OR double-click euphoria.Rproj in RStudio
setwd("~/Desktop/euphoria")
# ------------------------------------------------------------
# 2. Edit DESCRIPTION  ← do this before anything else
#    Replace "Your Name", "your@email.com", and "YOURUSERNAME"
# ------------------------------------------------------------

# ------------------------------------------------------------
# 3. Document  —  reads #' roxygen comments → generates man/ + NAMESPACE
# ------------------------------------------------------------
devtools::document()

# ------------------------------------------------------------
# 4. Check  —  runs full CRAN-style checks
#    Aim for 0 errors, 0 warnings, 0 notes
# ------------------------------------------------------------
devtools::check()

# ------------------------------------------------------------
# 5. Install locally (so you can library(euphoria) right now)
# ------------------------------------------------------------
devtools::install()
library(euphoria)

# Quick smoke-test
ggplot2::ggplot(mtcars, ggplot2::aes(wt, mpg, colour = factor(cyl))) +
  ggplot2::geom_point(size = 3) +
  scale_colour_euphoria() +
  ggplot2::labs(title = "Euphoria", subtitle = "it works!") +
  theme_euphoria()

# ------------------------------------------------------------
# 6. Make the hex sticker  (saves to man/figures/logo.png)
# ------------------------------------------------------------
source("make_hex.R")

# ------------------------------------------------------------
# 7. Knit README.Rmd  →  README.md (shown on GitHub)
# ------------------------------------------------------------
devtools::build_readme()

# ------------------------------------------------------------
# 8. Initialise git
# ------------------------------------------------------------
usethis::use_git()
# When prompted: commit everything, yes restart

# ------------------------------------------------------------
# 9. Create GitHub repo and push
#    You need a GitHub PAT stored — run this first if needed:
#      gitcreds::gitcreds_set()
# ------------------------------------------------------------
usethis::use_github(
  organisation = NULL,    # NULL = personal account
  private      = FALSE,   # TRUE if you want a private repo first
  description  = "ggplot2 themes and palettes inspired by HBO's Euphoria"
)

# ------------------------------------------------------------
# 10. Build pkgdown site locally (preview before deploying)
# ------------------------------------------------------------
pkgdown::build_site()

# ------------------------------------------------------------
# 11. Deploy pkgdown to GitHub Pages (one-time setup)
# ------------------------------------------------------------
usethis::use_pkgdown_github_pages()
# This:
#   - creates the gh-pages branch
#   - adds the pkgdown GitHub Actions workflow
#   - sets the repo homepage URL automatically

# After this, every push to main will auto-rebuild the site via
# GitHub Actions (.github/workflows/pkgdown.yaml)

# ------------------------------------------------------------
# 12. Add the install badge to README (optional but nice)
# ------------------------------------------------------------
# Paste this into your README.Rmd under the title, then re-knit:
#
# [![R-CMD-check](https://github.com/YOURUSERNAME/euphoria/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/YOURUSERNAME/euphoria/actions/workflows/R-CMD-check.yaml)
#
# Then run:
devtools::build_readme()

# ------------------------------------------------------------
# Done! Your package is live at:
#   https://github.com/YOURUSERNAME/euphoria
#   https://YOURUSERNAME.github.io/euphoria
#
# Anyone can now install it with:
#   remotes::install_github("YOURUSERNAME/euphoria")
# ------------------------------------------------------------
