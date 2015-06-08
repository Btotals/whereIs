Meteor.startup !->
  Upload-server.init {
    tmp-dir: process.env.PWD + '/public/tmp/'
    upload-dir: process.env.PWD + '/public/images'
    check-create-directories: true
    max-post-size: 4096000

    # get-directory: (file-info, form-data)->
    #   console.log 'fileinfo: '
    #   console.log fileInfo
    #   form-data.content-type

    # get-file-name: (file-info, form-data)->
    #   file-type = file-info.name.split '.'
    #   console.log file-type
    #   user-id = CurrentUser.findOne {only: true} .userId
    #   console.log       "#user-id." + file-type[file-type.length]
    #   "#user-id." + file-type[file-type.length]

    finished: (file-info, form-fields)!->
      user-id = CurrentUser.findOne {only: true} .userId
      # console.log user-id
      Meteor.call 'updateAvatar', [user-id, file-info.name]
  }
  CurrentUser.insert {only: true, user-id: "heheda~"}

Meteor.methods {
  update-avatar: (args)!->
    # args: [user-id, avatar-name]
    console.log args
    Meteor.users.update args[0], {$set: {'profile.avatar': args[1]}}, (err)!-> console.log err if err
}
