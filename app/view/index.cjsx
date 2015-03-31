React = require 'react'
{Link, RouteHandler} = require 'react-router'

Header = require './header'
Main = require './main'
Footer = require './footer'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  render: ->
    {db, title, sha, sections, section, workIndex, archiveYears, currentYear, theme} = @props
    {primaryMenu, author, description, startYear, wufoo, homepageId} = db

    appFileName = sha or 'app'
    cssFilePath = "/assets/#{appFileName}.css"
    jsFilePath = "/assets/#{appFileName}.js"

    if author
      metaAuthor = <meta name="author" content={author} />
    else
      metaAuthor = false

    if description
      metaDescription = <meta name="description" content={description} />
    else
      metaDescription = false
    unless title
      title = '[title]'

    {pageId} = @context.router.getCurrentParams()
    pathParts = @context.router.getCurrentPathname().split('/')

    unless pageId
      pageId = homepageId or 'homepage'

    if pageId
      if workIndex and pageData = db.work.contents[workIndex[pageId]]
        # @TODO Should check section too...
        console.log 'work page', pageId
      else if pageData = db[pageId]
        console.log 'normal pg data', pageId
      else
        if pathParts[1] is 'archive' and archiveYears
          pageData =
            images: archiveYears[parseInt(pageId)]
            title: pageId
        else
          console.log 'missing page data!', pageId
          pageData = {}
      if pageId is 'contact' and wufoo
        pageData.wufoo = wufoo
      if theme
        pageData.theme = theme
        pageData.display = theme?.display?[pageId] or theme.defaultDisplay
    if pageData?.title
      pageTitle = title + ' | ' + pageData.title

    <html>
      <head>
        <title>{pageTitle or title}</title>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" type="text/css" href={cssFilePath} />
        <meta name="generator" content="CAPE.io, see www.cape.io" />
        {metaAuthor} {metaDescription}
      </head>
      <body>
        <div className="container">
          <Header primaryMenu={primaryMenu} title={title} />
          <Main pageData={pageData} sections={sections} sectionsData={section} />
          <Footer currentYear={currentYear} startYear={startYear} title={title} />
        </div>
        <script src={jsFilePath} type="text/javascript" />
      </body>
    </html>
