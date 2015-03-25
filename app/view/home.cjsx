React = require 'react'

module.exports = React.createClass
  render: ->
    {data, query} = @props

    <div className="container">
      <h1>Purple Monkey Dishwasher!</h1>
      <p>Some text to test</p>
    </div>
