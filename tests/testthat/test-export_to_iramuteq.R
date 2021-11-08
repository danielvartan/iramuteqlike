test_that("export_to_iramuteq() | general test", {
    dir <- tempdir()

    export_to_iramuteq(head(friends::friends[[1]], 100), dir = dir,
                       file_name = "test.txt", var_name = "test")

    expect_true(any(grepl("^test\\.txt$", list.files(dir)), na.rm = TRUE))

    expect_true(grepl("\\*test_1\\*",
                       readLines(file.path(dir, "test.txt"))[1]))

    expect_equal(readLines(file.path(dir, "test.txt"))[2],
                 head(friends::friends[[1]], 100)[1])
})

test_that("export_to_iramuteq() | error test", {
    dir <- tempdir()

    expect_error(export_to_iramuteq(list(1), dir = dir, file_name = "test.txt",
                                    var_name = "test"),
                 "Assertion on 'x' failed")

    expect_error(export_to_iramuteq(1, dir = "999",
                                    file_name = "test.txt",
                                    var_name = "test"),
                 "Assertion on 'dir' failed")

    expect_message(export_to_iramuteq(1, dir = dir,
                                      file_name = "()",
                                      var_name = "test"))

    expect_error(export_to_iramuteq(1, dir = dir,
                                    file_name = "test.txt",
                                    var_name = "(test)"),
                 "Assertion on 'var_name' failed")
})
