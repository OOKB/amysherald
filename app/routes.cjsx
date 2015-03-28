React = require 'react'
{Route, DefaultRoute} = require 'react-router'

Index = require './view/index'
Page = require './view/page'
Work = require './view/work'
Archive = require './view/archive'

module.exports =

  <Route name="app" path="/" handler={Index}>
    <DefaultRoute handler={Page}/>
    <Route name="page" path=":pageId" handler={Page} />
    <Route name="work" path="work/:pageId" handler={Work} />
    <Route name="archive" path="archive/:pageId" handler={Work} />
  </Route>
