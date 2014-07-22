var exec = require('cordova/exec');


var iOSTwitterFriends = function(callback) {
  var iOSTwitterFriendsReturn = function (json) {
    var data = JSON.parse(json);

    if (data.error)
      return callback(err, null);

    return callback(null, data.contacts);
  }

  exec(iOSTwitterFriendsReturn, iOSTwitterFriendsReturn, 'iOSTwitterFriends', 'iOSTwitterFriends', []);
};

module.exports = iOSTwitterFriends;