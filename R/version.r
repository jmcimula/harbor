#' Get Docker version info
#'
#' @param host docker host
#' @export
version <- function(host=harbor::localhost) {

  docker_cmd(host, cmd="version")

  vers_info <- docker_cmd(host, cmd="version", args='--format="{{ json . }}"', capture_text=TRUE)

  vers_info <- sub('^"', "", vers_info)
  vers_info <- sub('"[[:space:]]+$', "", vers_info)

  out <- jsonlite::fromJSON(vers_info, simplifyVector=FALSE, simplifyDataFrame=FALSE)

  class(out) <- c("dckr_version")

  invisible(out)

}

#' @rdname version
#' @param x object
#' @param ... unused
#' @export
print.dckr_version <- function(x, ...) {
  cat(sprintf("Docker:\n  - Client: %s\n  - Server: %s\n", x$Client$Version, x$Server$Version))
}
