React = require 'react'
_ = require 'lodash'

Wufoo = require './wufoo'
SlideShow = require './slideshow'
ImageGrid = require './imageGrid/imageGrid'
Quote = require './quote'

module.exports = React.createClass
  render: ->
    {content, title, images, dir, wufoo, contents, display, quote, theme} = @props
    if not theme then theme = {}
    if contents?.length or images?.length
      if display is 'slideShow' or display is 'slideshow'
        if not theme.slideShow then theme.slideShow = {slideDuration: 3500}
        displayProps = _.merge theme.slideShow, {
          images: images or contents
          baseDir: dir
        }
        SlideShowEl = React.createElement(SlideShow, displayProps)
      else if display is 'imageGrid'
        if not theme.imageGrid then theme.imageGrid = {}
        displayProps = _.merge theme.imageGrid, {
          images: images or contents
          baseDir: dir
        }
        Grid = React.createElement(ImageGrid, displayProps)
      else
        console.log 'no display'
    <div className="page">
      { if title then <h1>{title}</h1> }
      { SlideShowEl }
      { if quote then React.createElement(Quote, quote) }
      { if content
          <div className="content" dangerouslySetInnerHTML={ __html: content }/>
      }
      { Grid }
      { if wufoo then <Wufoo hash={wufoo.hash} subdomain={wufoo.subdomain} /> }
    </div>
