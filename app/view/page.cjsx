React = require 'react'
_ = require 'lodash'

Wufoo = require './wufoo'
SlideShow = require './slideshow'
ImageGrid = require './imageGrid/imageGrid'
Quote = require './quote'

module.exports = React.createClass
  render: ->
    {content, title, images, imageSettings, dir, wufoo, contents, display, quote, theme} = @props
    if images
      if imageSettings
        {slideDuration, width, display} = imageSettings
      unless slideDuration
        slideDuration = 3500
      SlideShowEl =
        <SlideShow
          images={images}
          slideDuration={3500}
          baseDir={dir}
          width={width}
        />
    if contents
      if display is 'imageGrid' or true
        if theme?.imageGrid
          gridProps = _.merge theme.imageGrid, {images: contents}
        else
          gridProps = {images: contents}
        Grid = React.createElement(ImageGrid, gridProps)

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
