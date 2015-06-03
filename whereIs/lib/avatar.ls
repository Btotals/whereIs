Router.map !->
  @.route 'serverFile', {
    where: 'server'
    path: '/avatar'
    action: !->
      console.log @.request.avatar
  }