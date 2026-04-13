# ============================================================
#  make_hex.R  —  Generate the {euphoria} hex sticker
#  Run this once to create man/figures/logo.png
#  Requires: hexSticker, showtext, ggplot2
# ============================================================

setwd("~/Desktop/euphoria")
# install.packages(c("hexSticker", "showtext"))

library(hexSticker)
library(showtext)
library(ggplot2)

# Load a Google Font for the sticker text
font_add_google("Playfair Display", "playfair")
showtext_auto()

# -- Inner plot: a small glitter-scatter --
set.seed(42)
n   <- 120
hex_inner <- ggplot(
  data.frame(
    x = rnorm(n),
    y = rnorm(n),
    g = sample(c("jules", "cassie", "rue", "glitter", "maddy", "kat"),
               n, replace = TRUE)
  ),
  aes(x, y, colour = g)
) +
  geom_point(size  = 0.9, alpha = 0.9) +
  scale_colour_manual(values = c(
    jules   = "#f72585",
    cassie  = "#4cc9f0",
    rue     = "#7c3aed",
    glitter = "#e040fb",
    maddy   = "#b5179e",
    kat     = "#4361ee"
  ), guide = "none") +
  theme_void() +
  theme(
    plot.background  = element_rect(fill = "#0a0010", colour = NA),
    panel.background = element_rect(fill = "#0a0010", colour = NA)
  )

# -- Build the sticker --
dir.create("man/figures", recursive = TRUE, showWarnings = FALSE)

sticker(
  subplot    = hex_inner,
  package    = "euphoria",
  p_size     = 22,
  p_color    = "#e040fb",
  p_family   = "playfair",
  p_y        = 1.55,
  s_x        = 1,
  s_y        = 0.9,
  s_width    = 1.3,
  s_height   = 1.0,
  h_fill     = "#0a0010",
  h_color    = "#e040fb",
  h_size     = 1.5,
  filename   = "man/figures/logo.png",
  dpi        = 300
)

message("Hex sticker saved to man/figures/logo.png")
