#' @keywords internal
"_PACKAGE"

# ============================================================
#  euphoria: ggplot2 themes and palettes inspired by HBO's Euphoria
# ============================================================

# ------------------------------------------------------------
#  COLOR PALETTES
# ------------------------------------------------------------

#' Core Euphoria color palette (named vector)
#'
#' A named character vector of hex colors drawn from the visual aesthetic
#' of HBO's Euphoria — deep blacks, electric violets, neon pinks, icy blues.
#' Each color is named after a character.
#'
#' @export
#' @examples
#' euphoria_colors
#' euphoria_colors[["jules"]]
euphoria_colors <- c(
  void      = "#0a0010",
  abyss     = "#110022",
  shadow    = "#1e0035",
  rue       = "#7c3aed",
  jules     = "#f72585",
  maddy     = "#b5179e",
  cassie    = "#4cc9f0",
  nate      = "#3a0ca3",
  kat       = "#4361ee",
  lexi      = "#7209b7",
  glitter   = "#e040fb",
  highlight = "#ffffff"
)

#' Discrete Euphoria palette (8 colors for categorical data)
#'
#' @export
euphoria_palette_discrete <- unname(euphoria_colors[
  c("jules", "cassie", "rue", "glitter", "maddy", "kat", "lexi", "nate")
])

#' Sequential Euphoria palette (void to glitter, for continuous data)
#'
#' @export
euphoria_palette_seq <- c(
  "#0a0010", "#2d0057", "#5a0096",
  "#8b00c8", "#b800e0", "#e040fb", "#f5a7ff"
)

#' Generate an Euphoria color palette
#'
#' Returns a vector of \code{n} colors from the Euphoria palette.
#'
#' @param n Integer. Number of colors needed.
#' @param type Character. Either \code{"discrete"} (default, max 8 colors)
#'   or \code{"sequential"} (interpolated gradient, any n).
#'
#' @return A character vector of hex color codes.
#' @export
#'
#' @examples
#' euphoria_pal(5)
#' euphoria_pal(100, type = "sequential")
euphoria_pal <- function(n, type = "discrete") {
  if (type == "discrete") {
    pal <- euphoria_palette_discrete
    if (n > length(pal)) {
      stop(paste("Discrete palette supports max", length(pal), "colors."))
    }
    return(pal[seq_len(n)])
  } else {
    grDevices::colorRampPalette(euphoria_palette_seq)(n)
  }
}

# ------------------------------------------------------------
#  SCALE FUNCTIONS
# ------------------------------------------------------------

#' Euphoria discrete colour scale
#'
#' @param ... Additional arguments passed to \code{ggplot2::scale_colour_manual}.
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
#'   geom_point() +
#'   scale_colour_euphoria()
scale_colour_euphoria <- function(...) {
  ggplot2::scale_colour_manual(values = euphoria_palette_discrete, ...)
}

#' @rdname scale_colour_euphoria
#' @export
scale_color_euphoria <- scale_colour_euphoria

#' Euphoria discrete fill scale
#'
#' @param ... Additional arguments passed to \code{ggplot2::scale_fill_manual}.
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(mpg, aes(class, fill = class)) +
#'   geom_bar() +
#'   scale_fill_euphoria()
scale_fill_euphoria <- function(...) {
  ggplot2::scale_fill_manual(values = euphoria_palette_discrete, ...)
}

#' Euphoria continuous colour scale
#'
#' @param ... Additional arguments passed to \code{ggplot2::scale_colour_gradientn}.
#' @export
scale_colour_euphoria_c <- function(...) {
  ggplot2::scale_colour_gradientn(colours = euphoria_palette_seq, ...)
}

#' @rdname scale_colour_euphoria_c
#' @export
scale_color_euphoria_c <- scale_colour_euphoria_c

#' Euphoria continuous fill scale
#'
#' @param ... Additional arguments passed to \code{ggplot2::scale_fill_gradientn}.
#' @export
#' @examples
#' library(ggplot2)
#' ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'   geom_tile() +
#'   scale_fill_euphoria_c()
scale_fill_euphoria_c <- function(...) {
  ggplot2::scale_fill_gradientn(colours = euphoria_palette_seq, ...)
}

# ------------------------------------------------------------
#  THEME
# ------------------------------------------------------------

#' Euphoria ggplot2 theme
#'
#' A dark ggplot2 theme inspired by the visual aesthetic of HBO's Euphoria,
#' featuring deep purple-black backgrounds, neon orchid accents, soft lavender
#' text, and glowing panel borders.
#'
#' @param base_size   Numeric. Base font size in pts (default \code{12}).
#' @param base_family Character. Font family (default \code{"serif"}).
#'   For full effect, use a Google Font such as \code{"Playfair Display"}
#'   loaded via the \pkg{showtext} package.
#' @param grid Logical. Show major grid lines? (default \code{TRUE}).
#'
#' @return A ggplot2 theme object.
#' @export
#'
#' @examples
#' library(ggplot2)
#'
#' # Scatter plot
#' ggplot(mtcars, aes(wt, mpg, colour = factor(cyl))) +
#'   geom_point(size = 3, alpha = 0.9) +
#'   scale_colour_euphoria() +
#'   labs(
#'     title    = "Euphoria",
#'     subtitle = "every version of herself she's ever been",
#'     x = "Weight", y = "MPG", colour = "Cylinders"
#'   ) +
#'   theme_euphoria()
#'
#' # Bar chart without grid
#' ggplot(mpg, aes(class, fill = class)) +
#'   geom_bar() +
#'   scale_fill_euphoria() +
#'   labs(title = "Euphoria", subtitle = "glitter & darkness") +
#'   theme_euphoria(grid = FALSE)
theme_euphoria <- function(base_size   = 12,
                           base_family = "serif",
                           grid        = TRUE) {

  void   <- euphoria_colors[["void"]]
  abyss  <- euphoria_colors[["abyss"]]
  shadow <- euphoria_colors[["shadow"]]
  glow   <- euphoria_colors[["glitter"]]
  hi     <- euphoria_colors[["highlight"]]
  lo     <- "#c084fc"

  ggplot2::theme_dark(base_size = base_size, base_family = base_family) %+replace%
    ggplot2::theme(

      plot.background  = ggplot2::element_rect(fill = void,  colour = NA),
      panel.background = ggplot2::element_rect(fill = abyss, colour = NA),

      panel.grid.major = if (grid)
        ggplot2::element_line(colour = shadow, linewidth = 0.4)
      else
        ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank(),

      panel.border = ggplot2::element_rect(colour = glow, fill = NA,
                                           linewidth = 0.6),

      axis.line   = ggplot2::element_blank(),
      axis.ticks  = ggplot2::element_line(colour = lo, linewidth = 0.3),
      axis.text   = ggplot2::element_text(colour = lo,
                                          size   = base_size * 0.75),
      axis.title  = ggplot2::element_text(colour = hi,
                                          size   = base_size * 0.9,
                                          face   = "italic"),

      plot.title = ggplot2::element_text(
        colour = glow, size = base_size * 1.6, face = "bold",
        hjust  = 0, margin = ggplot2::margin(b = 6)
      ),
      plot.subtitle = ggplot2::element_text(
        colour = lo, size = base_size * 0.95, hjust = 0,
        face   = "italic", margin = ggplot2::margin(b = 10)
      ),
      plot.caption = ggplot2::element_text(
        colour = lo, size = base_size * 0.65,
        hjust  = 1, margin = ggplot2::margin(t = 8)
      ),

      legend.background = ggplot2::element_rect(fill = void,  colour = NA),
      legend.key        = ggplot2::element_rect(fill = abyss, colour = NA),
      legend.text       = ggplot2::element_text(colour = lo),
      legend.title      = ggplot2::element_text(colour = hi, face = "bold"),

      strip.background = ggplot2::element_rect(fill = shadow, colour = NA),
      strip.text       = ggplot2::element_text(colour = glow, face = "bold",
                                               size = base_size * 0.85),

      plot.margin = ggplot2::margin(14, 14, 10, 14)
    )
}
