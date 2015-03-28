React = require 'react'
Menu = require './menu'
{Link} = require 'react-router'

module.exports = React.createClass
  render: ->
    {primaryMenu, title} = @props

    <header>
      <Link to="/"><h1>{title}</h1></Link>
      <nav>
        <Menu menu={primaryMenu} />
      </nav>
    </header>
