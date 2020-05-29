#' Freeze installed packages from global environment
#'
#' @param version Boolean. Show version or not
#' @param export Boolean. Save into RDS file or not
#'
#' @return Installed packages
#' @export
#'
#' @examples
#' freeze()
freeze <- function(version=F, export=T) {
  package_mat <- installed.packages()[,c("Package", "Version")]
  requirement_lst <- apply(package_mat, 1, function(pp) {
    paste0(pp["Package"], "==", pp["Version"])
  })

  requirements <- unname(sort(unlist(requirement_lst)))

  if(version == T) {
    return(requirements)

  } else {
    package_splt <- unlist(strsplit(requirements, "=="))
    package_mat <- matrix(package_splt, ncol = 2, byrow = TRUE)

    package_mat <- package_mat[,1]
    ifelse(any(duplicated(package_mat)), package_mat <- package_mat[-which(duplicated(package_mat))], package_mat)

    if(export) {
      return(saveRDS(package_mat, "requirements"))
    } else {
      return(package_mat)
    }
  }
}







