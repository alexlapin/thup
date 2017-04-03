@User = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.user.user_id
      React.DOM.td null, @props.user.first_name
      React.DOM.td null, @props.user.last_name
      React.DOM.td null, @props.user.employee_number