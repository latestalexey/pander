\name{Pandoc.brew}
\alias{Pandoc.brew}
\title{Brew in pandoc format}
\usage{
Pandoc.brew(file = stdin(), output = stdout(), convert = FALSE,
  open = TRUE, graph.name, graph.dir, graph.hi.res = FALSE, text = NULL,
  envir = parent.frame(), append = FALSE, ...)
}
\arguments{
  \item{file}{file path of the brew template. As this is
  passed to \code{readLines}, \code{file} could be an URL
  too, but not over SSL (for that latter \code{RCurl} would
  be needed).}

  \item{output}{(optional) file path of the output file}

  \item{convert}{string: format of required output document
  (besides Pandoc's markdown). Pandoc is called if set via
  \code{Pandoc.convert} and the converted document could be
  also opened automatically (see below).}

  \item{open}{try to open converted document with operating
  system's default program}

  \item{graph.name}{character string (default to \code{\%t}
  when \code{output} is set to \code{stdout} and
  \code{paste0(basename(output), '-\%n')} otherwise) passed
  to \code{\link{evals}}.  Besides \code{\link{evals}}'s
  possible tags \code{\%i} is also available which would be
  replaced by the chunk number (and optionally an integer
  which would handle nested \code{brew} calls) and
  \code{\%I} with the order of the current expression.}

  \item{graph.dir}{character string (default to
  \code{tempdir()} when \code{output} is set to
  \code{stdout} and \code{dirname(graph.name)} otherwise)
  passed to \code{\link{evals}}}

  \item{graph.hi.res}{render high resolution images of
  plots? Default is \code{FALSE} except for HTML output.}

  \item{text}{character vector (treated as the content of
  the \code{file}}

  \item{envir}{environment where to \code{brew} the
  template}

  \item{append}{should append or rather overwrite (default)
  the \code{output} markdown text file? Please note that
  this option only affects the markdown file and not the
  optionally created other formats.}

  \item{...}{additional parameters passed to
  \code{\link{Pandoc.convert}}}
}
\value{
converted file name with full path if \code{convert} is
set, none otherwise
}
\description{
This function behaves just like \code{brew} except for the
\code{<\%=...\%>} tags, where \code{Pandoc.brew} first
translate the R object found between the tags to Pandoc's
markdown before passing to the \code{cat} function.
}
\details{
This parser tries to be smart in some ways:

\itemize{ \item a block (R commands between the tags) could
return any value at any part of the block and there are no
restrictions about the number of returned R objects \item
plots and images are grabbed in the document, rendered to a
png file and \code{pander} method would result in a
Pandoc's markdown formatted image link (so the image would
be shown/included in the exported document). The images are
put in \code{plots} directory in current \code{getwd()} or
to the specified \code{output} file's directory.  \item all
warnings/messages and errors are recorded in the blocks and
returned in the document as a footnote }

Please see my Github page for details
(\url{http://rapporter.github.com/pander/#brew-to-pandoc})
and examples
(\url{http://rapporter.github.com/pander/#examples}).
}
\note{
Only one of the input parameters (\code{file} or
\code{text}) is to be used at once!
}
\examples{
\dontrun{
text <- paste('# Header', '',
  'What a lovely list:\\n<\%=as.list(runif(10))\%>',
  'A wide table:\\n<\%=mtcars[1:3, ]\%>',
  'And a nice chart:\\n\\n<\%=plot(1:10)\%>', sep = '\\n')
Pandoc.brew(text = text)
Pandoc.brew(text = text, output = tempfile(), convert = 'html')
Pandoc.brew(text = text, output = tempfile(), convert = 'pdf')

## pi is awesome
Pandoc.brew(text='<\%for (i in 1:5) {\%>\\n Pi has a lot (<\%=i\%>) of power: <\%=pi^i\%><\%}\%>')

## package bundled examples
Pandoc.brew(system.file('examples/minimal.brew', package='pander'))
Pandoc.brew(system.file('examples/minimal.brew', package='pander'),
  output = tempfile(), convert = 'html')
Pandoc.brew(system.file('examples/short-code-long-report.brew', package='pander'))
Pandoc.brew(system.file('examples/short-code-long-report.brew', package='pander'),
  output = tempfile(), convert = 'html')

## brew returning R objects
str(Pandoc.brew(text='Pi equals to <\%=pi\%>.
And here are some random data:\\n<\%=runif(10)\%>'))

str(Pandoc.brew(text='# Header <\%=1\%>\\nPi is <\%=pi\%> which is smaller then <\%=2\%>.
foo\\nbar\\n <\%=3\%>\\n<\%=mtcars[1:2,]\%>'))

str(Pandoc.brew(text='<\%for (i in 1:5) {\%>
Pi has a lot (<\%=i\%>) of power: <\%=pi^i\%><\%}\%>'))
}
}
\references{
\itemize{ \item Jeffrey Horner (2011). _brew: Templating
Framework for Report Generation._
\url{http://CRAN.R-project.org/package=brew} \item John
MacFarlane (2012): _Pandoc User's Guide_.
\url{http://johnmacfarlane.net/pandoc/README.html} }
}

