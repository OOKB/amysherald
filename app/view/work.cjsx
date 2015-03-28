React = require 'react'

ImageGrid = require './imageGrid'

module.exports = React.createClass
  render: ->
    {content, images, title, images} = @props
    if content
      ContentEl = <div className="content" dangerouslySetInnerHTML={ __html: content }/>
    if images
      Images = <ImageGrid images={images} />
    <div className="work">
      <h1>{title}</h1>
      {ContentEl}
      {Images}
    </div>
