React = require 'react'
{Link} = require 'react-router'

module.exports = React.createClass
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
