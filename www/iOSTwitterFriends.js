var exec = require('cordova/exec');


var iOSTwitterFriends = function(callback) {
  var iOSTwitterFriendsReturn = function (json) {
    var data = JSON.parse(json);

    if (data.error)
      return callback(data.error, null);

    return callback(null, data.friends);
  }

  exec(iOSTwitterFriendsReturn, iOSTwitterFriendsReturn, 'iOSTwitterFriends', 'iOSTwitterFriends', []);
};

module.exports = iOSTwitterFriends;
