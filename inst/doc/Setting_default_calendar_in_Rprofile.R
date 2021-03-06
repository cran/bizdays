## ---- message=FALSE-----------------------------------------------------------
library(bizdays)
create.calendar(name='ANBIMA', holidays=holidaysANBIMA, weekdays=c('saturday', 'sunday'))
bizdays.options$set(default.calendar='ANBIMA')

## -----------------------------------------------------------------------------
from_dates <- c('2013-07-12', '2012-06-13')
to_dates <- seq(as.Date('2014-02-17'), as.Date('2016-07-21'), by='months')
bizdays(from_dates, to_dates)

