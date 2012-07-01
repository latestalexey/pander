context('Pandoc.brew')

test_that('expected result', {
    expect_that(capture.output(Pandoc.brew(text='## foo')), equals('## foo '))
    expect_that(capture.output(Pandoc.brew(text='## <%=1%>')), equals('## _1_ '))
    expect_that(capture.output(Pandoc.brew(text='<%=1%>')), equals('_1_ '))
    expect_that(capture.output(Pandoc.brew(text='<%for (i in 1:3)%><%=i%>')), equals('_1__2__3_ '))
})

test_that('correct number of list elements', {
    expect_that(length(Pandoc.brew(text='## foo', output = '/tmp/dev/null')), equals(1))
    expect_that(length(Pandoc.brew(text='## foo <%=mtcars[1:2,]%>', output = '/tmp/dev/null')), equals(3))
    expect_that(length(Pandoc.brew(text='## foo <%=mtcars[1:2,]%> bar <%=plot(1:10)%>', output = '/tmp/dev/null')), equals(5))
    expect_that(length(Pandoc.brew(text='## foo <%=1%> bar <%=pi%>', output = '/tmp/dev/null')), equals(1))
    expect_that(length(Pandoc.brew(text='<%for (i in 1:5){%>## foo<%}%>', output = '/tmp/dev/null')), equals(5))
    expect_that(length(Pandoc.brew(text='# FOO <%=pi%> bar \n# sad', output = '/tmp/dev/null')), equals(2))
    expect_that(length(Pandoc.brew(text='# FOO\n## bar<%=pi%> bar \n# sad', output = '/tmp/dev/null')), equals(3))
    expect_that(length(Pandoc.brew(text='# FOO ## bar<%=pi%> barn# sad', output = '/tmp/dev/null')), equals(1))
})