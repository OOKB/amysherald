React = require 'react'
Menu = require './menu'
{Link} = require 'react-router'

module.exports = React.createClass
  render: ->
    {primaryMenu} = @props

    <header>
      <Link to="/"><h1>Laura Hudson</h1></Link>
      <nav>
        <Menu menu={primaryMenu} />
      </nav>
    </header>
