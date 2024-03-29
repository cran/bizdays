% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/R-bizdays-package.r
\docType{package}
\name{bizdays-package}
\alias{bizdays-package}
\title{Business Days Calculations and Utilities}
\description{
In many countries the standard approach to price derivatives and fixed income
instruments involves the use of business days. In Brazil, for example, the
great majority of financial instruments are priced on business days counting
rules. Given that the use of business days is somehow vital to handle many
tasks. That's the reason why \code{bizdays} came up, to make these tasks
easier.
Excel's NETWORKDAYS is fairly at hand and once you have a list of
holidays it is quite easy to put your data into a spreadsheet and make
things happen.
\code{bizdays} brings that ease to R.

Although R's users have similar feature in packages like \code{RQuantLib} and
\code{timeDate} it doesn't come for free. Users have to do some stackoverflow
in order to get this task accomplished. \code{bizdays} is a tiny package
dramatically focused on that simple task: support calculations involving
business days for a given list of holidays.

\code{bizdays} was designed to work with all common date types and ISO
formatted character strings and all methods have support for vectorized
operations and handle the recycle rule.
}
\seealso{
Useful links:
\itemize{
  \item \url{https://github.com/wilsonfreitas/R-bizdays}
}

}
\author{
Wilson Freitas
}
