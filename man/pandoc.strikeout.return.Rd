\name{pandoc.strikeout.return}
\alias{pandoc.strikeout}
\alias{pandoc.strikeout.return}
\title{Add strikeout}
\usage{
pandoc.strikeout.return(x)
}
\arguments{
  \item{x}{character vector}
}
\value{
By default this function outputs (see: \code{cat}) the
result. If you would want to catch the result instead, then
call the function ending in \code{.return}.
}
\description{
Pandoc's markdown strikeout format (e.g. \code{~~FOO~~}) is
added to character string.
}
\examples{
pandoc.strikeout('FOO')
pandoc.strikeout(c('FOO', '~~FOO~~'))
pandoc.strikeout.return('FOO')
}
\references{
John MacFarlane (2012): _Pandoc User's Guide_.
\url{http://johnmacfarlane.net/pandoc/README.html}
}
\seealso{
\code{\link{pandoc.emphasis}} \code{\link{pandoc.strong}}
\code{\link{pandoc.verbatim}}
}

