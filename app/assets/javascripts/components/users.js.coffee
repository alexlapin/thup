@Users = React.createClass
  getInitialState: ->
    users: @props.data

  getDefaultProps: ->
    users: []

  addRecord: (user) ->
    users = @state.records.slice()
    users.push user
    @setState records: users

  render: ->
    React.DOM.div
      className: 'users'
      React.DOM.h2
        className: 'title'
        'Users'
      React.createElement RecordForm, handleNewRecord: @addRecord
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
          for user in @state.users
            React.createElement User, key: user.id, user: user