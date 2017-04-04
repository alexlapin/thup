@Users = React.createClass
  getInitialState: ->
    users: @props.data

  getDefaultProps: ->
    users: []

  render: ->
    React.DOM.div
      className: 'users'
      React.DOM.h2
        className: 'title'
        'Users'
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'ID'
            React.DOM.th null, 'FirstName'
            React.DOM.th null, 'LastName'
            React.DOM.th null, 'EmployeeNumber'
        React.DOM.tbody null,
          for user in @props.data
            React.createElement User, key: user.id, user: user