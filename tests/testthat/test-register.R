
context("Calendar register")

test_that("it should list calendars thru register", {
  l <- length(calendars())
  cal <- Calendar_()
  expect_equal(length(calendars()), l)
  cal <- calendars()[["Brazil/ANBIMA"]]
  cal <- create.calendar("try-ANBIMA", cal$holidays,
    weekdays = c("saturday", "sunday")
  )
  expect_equal(length(calendars()), l + 1)
  expect_true("try-ANBIMA" %in% ls(calendars()))
})

test_that("it should retrieve registered calendars", {
  expect_is(calendars()[["actual"]], "Calendar")
  expect_null(calendars()[["blá"]])
})

test_that("it should call calendar's methods with calendar's name", {
  expect_error(
    bizdays("2016-02-01", "2016-02-02", "actual/365"),
    "Invalid calendar"
  )
  expect_equal(bizdays("2016-02-01", "2016-02-02", "actual"), 1)
  expect_equal(is.bizday("2016-02-01", "actual"), TRUE)
  expect_equal(offset("2016-02-01", 1, "actual"), as.Date("2016-02-02"))
  expect_equal(
    bizseq("2016-02-01", "2016-02-02", "actual"),
    as.Date(c("2016-02-01", "2016-02-02"))
  )
  expect_equal(
    modified.following("2013-01-01", "actual"),
    as.Date("2013-01-01")
  )
  expect_equal(
    modified.preceding("2013-01-01", "actual"),
    as.Date("2013-01-01")
  )
  expect_equal(following("2013-01-01", "actual"), as.Date("2013-01-01"))
  expect_equal(preceding("2013-01-01", "actual"), as.Date("2013-01-01"))
})

test_that("it should set default calendar with calendar's name", {
  cal <- create.calendar("actual-calendar")
  bizdays.options$set(default.calendar = "actual-calendar")
  expect_is(bizdays.options$get("default.calendar"), "character")
  expect_equal(bizdays.options$get("default.calendar"), "actual-calendar")
})

test_that("it should remove a calendar", {
  cal <- create.calendar("actual")
  expect_false(is.null(calendars()[["actual"]]))
  remove_calendars("actual")
  expect_true(is.null(calendars()[["actual"]]))
})

test_that("it should check if a calendar exists", {
  create.calendar("actual")
  expect_true(has_calendars("actual"))
  expect_false(has_calendars("nama"))
  expect_equal(
    has_calendars(c("actual", "weekends", "nama")),
    c(TRUE, TRUE, FALSE)
  )
})