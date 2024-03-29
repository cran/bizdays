
context("getdate")

test_that("it should return a date accordingly the given date reference", {
  dx <- getdate("last bizday", 2018, "Brazil/ANBIMA")
  expect_equal(dx, as.Date("2018-12-31"))
  dx <- getdate("last bizday", 2017:2018, "Brazil/ANBIMA")
  expect_equal(dx, as.Date(c("2017-12-29", "2018-12-31")))
  dx <- getdate("last bizday", c("2017-01", "2018-01"), "Brazil/ANBIMA")
  expect_equal(dx, as.Date(c("2017-01-31", "2018-01-31")))
  dx <- getdate("first wed", 2018, "actual")
  expect_equal(dx, as.Date("2018-01-03"))
  expect_error(getdate("last xxx", 2018, "actual"))
})

test_that("it should convert nth to int", {
  expect_equal(nth2int("10th"), 10)
  expect_error(nth2int("xxx"))
})

test_that("it should parse position token", {
  expect_equal(getnth_("first"), 1)
  expect_equal(getnth_("second"), 2)
  expect_equal(getnth_("third"), 3)
  expect_equal(getnth_("1st"), 1)
  expect_equal(getnth_("2nd"), 2)
  expect_equal(getnth_("3rd"), 3)
  expect_equal(getnth_("last"), -1)
  expect_equal(getnth_("10th"), 10)
  expect_error(getnth_("xxx"))
})

test_that("it should create a year-month reference", {
  rrr <- ref(as.Date("2018-01-01"))
  expect_is(rrr, "ref")
  expect_is(rrr, "by_day")
  expect_equal(rrr$dates, as.Date("2018-01-01"))
  rrr <- ref(c(as.Date("2018-01-01"), as.Date("2018-02-01")))
  expect_is(rrr, "ref")
  expect_is(rrr, "by_day")
  expect_equal(rrr$dates, c(as.Date("2018-01-01"), as.Date("2018-02-01")))
  rrr <- ref("2018-01")
  expect_is(rrr, "ref")
  expect_is(rrr, "by_month")
  expect_equal(rrr$ref_table, cbind(year = 2018, month = 1))
  rrr <- ref("2018")
  expect_is(rrr, "ref")
  expect_is(rrr, "by_year")
  expect_equal(rrr$ref_table, cbind(year = 2018))
  rrr <- ref(2018)
  expect_is(rrr, "ref")
  expect_is(rrr, "by_year")
  expect_equal(rrr$ref_table, cbind(year = 2018))
  rrr <- ref(2010:2018)
  expect_is(rrr, "by_year")
  expect_equal(rrr$ref_table, cbind(year = 2010:2018))
  rrr <- ref("2018-01-01")
  expect_is(rrr, "by_day")
  expect_equal(rrr$dates, as.Date("2018-01-01"))
})

test_that("it should get the nth day by the reference", {
  rrr <- ref("2018-01")
  cal <- calendars()[["actual"]]
  expect_equal(getnthday(rrr, 1, FALSE, cal), as.Date("2018-01-01"))
  expect_equal(getnthday(rrr, -1, FALSE, cal), as.Date("2018-01-31"))
  cal <- calendars()[["Brazil/ANBIMA"]]
  expect_equal(
    getnthday(rrr, 1, TRUE, cal),
    as.Date("2018-01-02")
  )
  expect_equal(
    getnthday(rrr, -1, TRUE, cal),
    as.Date("2018-01-31")
  )
})