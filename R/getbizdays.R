#' Obtaining business days using other dates (or month or year) as reference
#' 
#' Calculates the number of business days for some specific periof of a year
#' or a month.
#' \code{getbizdays} returns the number of business days according to a
#' reference than can be another date, a month or an year.
#' 
#' @param ref a reference which represents a month or year, where the date has
#' to be found.
#' @param cal the calendar's name
#' 
#' \code{getbizdays} returns the number of working days according to a reference
#' that can be a month or an year.
#' This reference can be passed as a character vector representing months
#' or years, or as a numeric vector representing years. The ISO format must be 
#' used to represent years or months with character vectors.
#' 
#' @examples
#' # for years
#' getbizdays(2022:2024, "actual")
#' 
#' # for months
#' getbizdays("2022-12", "actual")
#' 
#' # using dates as references for months
#' dts <- seq(as.Date("2022-01-01"), as.Date("2022-12-01"), by = "months")
#' getbizdays(dts, "actual")
#' @export
getbizdays <- function(ref, cal = bizdays.options$get("default.calendar")) {
  cal <- check_calendar(cal)
  ref <- ref(ref)
  
  bizdays_ <- lapply(seq_len(NROW(ref$year_month)),
                     function(x) count_bizdays_(ref, cal, x))
  unlist(bizdays_)
}

count_bizdays_ <- function(ref, cal, ref_pos) {
  ix <- if (ref$by_month) {
    cal$dates.table[, "month"] == ref$year_month[ref_pos, "month"] &
      cal$dates.table[, "year"] == ref$year_month[ref_pos, "year"]
  } else {
    cal$dates.table[, "year"] == ref$year_month[ref_pos, "year"]
  }
  sum(cal$dates.table[ix, "is_bizday"])
}