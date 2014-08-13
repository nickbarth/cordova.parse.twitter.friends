## Cordova iOS Twitter Friends

## About this Plugin

Retrieve Twitter friends for an authorized iOS device. Supports iOS Versions 6.0 and up only.

## Using the Plugin

Example:

```
window.iOSTwitterFriends(function (err, friends) {
  if (err) return alert(err);
  console.log('friends are ', friends);
});
```

## Adding the Plugin ##

```
  cordova plugin add https://github.com/nickbarth/cordova.parse.twitter.friends.git
```

**NOTE**: You'll have to set your app category as a game and request the user_friends permission. See https://developers.twitter.com/docs/graph-api/reference/v2.0/user/invitable_friends

## LICENSE ##

The CC0 License

[![CC0](http://i.creativecommons.org/l/zero/1.0/88x31.png)](http://creativecommons.org/publicdomain/zero/1.0/)
