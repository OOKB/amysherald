React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'

ImageText = require './imageText'
ImageDetail = require './imageDetail'
Image = require './image'

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  getInitialState: ->
    isMounted: false
    imgDimensions: []

  componentDidMount: ->
    {calculateWidth, calculateHeight, images} = @props

    if calculateWidth or calculateHeight
      imageEls = document.querySelectorAll('.image-grid .image img')
      imgDimensions = _.map imageEls, (imgEl) ->
        width: imgEl.clientWidth
        height: imgEl.clientHeight

    @setState
      isMounted: true
      imgDimensions: imgDimensions or []

  render: ->
    {images, width, height, fit, domain, calculateWidth, calculateHeight, setContainerWidth, baseDir} = @props
    {isMounted, imgDimensions} = @state
    {i} = @context.router.getCurrentQuery()
    i = parseInt(i)
    maxIndex = images.length - 1

    ImageEl = (image, index) =>
      if _.isString image
        key = index
        id = if baseDir then baseDir + '/' + image
      else
        {id, filename, rev, images, title, content, year, medium, sold, key} = image
        if images
          {id, filename, rev} = images[0]
      key = key or rev or id or i
      if isMounted and i is index
        Detail = <ImageDetail id={id} filename={filename} i={i} maxIndex={maxIndex} />
      if title or content or year or medium
        Text = React.createElement(ImageText, image)
      className = if sold then "image sold" else "image"
      style = {}
      if isMounted
        if calculateWidth then style.width = imgDimensions[index].width
        if calculateHeight then style.height = imgDimensions[index].height
        dimensions = imgDimensions[index]
      <li className={className} key={key} style={style} >
        <Image
          id={id}
          filename={filename}
          i={index}
          height={height}
          width={width}
          domain={domain}
          dimensions={dimensions}
          fit={fit}
        />
        {Text}
        {Detail}
      </li>

    if setContainerWidth
      paddingMargin = images.length * 40
      if isMounted
        widthOfImages = _.sum(imgDimensions, 'width')
      else
        widthOfImages = (images.length + 4) * (width or height)
      style = {width: widthOfImages + paddingMargin}
      console.log style
    <ul className="image-grid" style={style}>
      { _.map images, ImageEl }
    </ul>
