#' Install yet installed R packages
#'
#' @export
#'
#' @examples
#' restore()
restore <- function() {
    requirements <- readRDS("requirements")
    installed_packages <- requirements %in% sort(rownames(installed.packages()))

    if (any(installed_packages == FALSE)) {
      install.packages(requirements[!installed_packages])
    }
}


