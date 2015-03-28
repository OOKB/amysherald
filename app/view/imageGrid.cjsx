React = require 'react'
{Link} = require 'react-router'
_ = require 'lodash'

Menu = require './menu'

Image = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  render: ->
    {id, filename, i} = @props
    imgUrl = "http://ezle.imgix.net/#{id}?w=300&h=300&fit=crop"
    path = @context.router.getCurrentPathname()
    <Link to={path} query={i:i} role="button" activeClassName="" className="">
      <img className="small" src={imgUrl} alt={filename} />
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

module.exports = React.createClass
  contextTypes: {
    router: React.PropTypes.func.isRequired
  }
  getInitialState: ->
    isMounted: false

  componentDidMount: ->
    @setState isMounted: true

  render: ->
    {images} = @props
    {isMounted} = @state
    {i} = @context.router.getCurrentQuery()
    i = parseInt(i)
    maxIndex = images.length - 1
    ImageEl = (image, index) =>
      {id, filename, rev} = image
      if isMounted and i is index
        Detail = <ImageDetail id={id} filename={filename} i={i} maxIndex={maxIndex} />
      <li className="image" key={rev} >
        <Image id={id} filename={filename} i={index} />
        {Detail}
      </li>

    <ul className="image-grid">
      { _.map images, ImageEl }
    </ul>
