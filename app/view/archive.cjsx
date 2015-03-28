React = require 'react'
ImageGrid = require './imageGrid/imageGrid'

module.exports = React.createClass
  render: ->
    {images, title} = @props
    <div className="archive">
      <h1>{title}</h1>
      {images}
    </div>
