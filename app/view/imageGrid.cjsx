React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'
Qs = require 'qs'

Menu = require './menu'

Image = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  render: ->
    {id, filename, i, width, height, crop, domain} = @props
    domain = domain or 'ezle.imgix.net'
    if !width and !height
      width = 500
    url = "//#{domain}/#{id}"
    if width or height or crop
      url += "?" + Qs.stringify({ h: height, w: width, fit: crop })

    path = @context.router.getCurrentPathname()
    <Link to={path} query={i:i} role="button" activeClassName="" className="">
      <img className="small" src={url} alt={filename} />
    </Link>

ImageDetail = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  render: ->
    {id, filename, maxIndex, i} = @props
    imgUrl = "http://ezle.imgix.net/#{id}?w=1200"
    nextIndex = if i is maxIndex then 0 else i+1
    prevIndex = if i is 0 then maxIndex else i-1
    path = @context.router.getCurrentPathname()

    <div className="img-detail">
      <Link className="button close" to={path} role="button"> Close </Link>
      <Link className="button left" to={path} query={i:prevIndex} role="button"> Previous </Link>
      <Link to={path} role="button" onClick={@close}>
        <img className="large" src={imgUrl} alt={filename} />
      </Link>
      <Link className="button right" to={path} query={i:nextIndex} role="button"> Next </Link>
    </div>

ImageText = React.createClass
  render: ->
    {title, collection, content, year, size, medium, height, width, sold} = @props
    if height or width and not size
      size = "#{height}\" × #{width}\""

    <div className="info">
      {if title then <h2>{title}</h2>}
      <ul className="details">
        {if collection then <li className="collection">{collection}</li>}
        {if year then <li className="year">{year}</li>}
        {if size then <li className="size">{size}</li>}
        {if medium then <li className="medium">{medium}</li>}
      </ul>
      { if content
          <div className="content" dangerouslySetInnerHTML={ __html: content }/>
      }
    </div>

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  getInitialState: ->
    isMounted: false

  componentDidMount: ->
    @setState isMounted: true

  render: ->
    {images, width, height, fit, domain} = @props
    {isMounted} = @state
    {i} = @context.router.getCurrentQuery()
    i = parseInt(i)
    maxIndex = images.length - 1
    ImageEl = (image, index) =>
      {id, filename, rev, images, title, content, year, medium, sold} = image
      if images
        {id, filename, rev} = images[0]
      if isMounted and i is index
        Detail = <ImageDetail id={id} filename={filename} i={i} maxIndex={maxIndex} />
      if title or content or year or medium
        Text = React.createElement(ImageText, image)
      className = if sold then "image sold" else "image"
      <li className={className} key={rev} >
        <Image
          id={id}
          filename={filename}
          i={index}
          height={height}
          width={width}
          domain={domain}
        />
        {Text}
        {Detail}
      </li>

    <ul className="image-grid">
      { _.map images, ImageEl }
    </ul>
