## Cordova iOS FaceBook Friends

## About this Plugin

Retrieve FaceBook friends for an authorized iOS device. Supports iOS Versions 6.0 and up only.

## Using the Plugin

Example:

```
window.iOSFaceBookFriends(function (err, friends) {
  if (err) return alert(err);
  console.log('friends are ', friends);
});
```

## Adding the Plugin ##

```
  cordova plugin add https://github.com/nickbarth/cordova.parse.facebook.friends.git
```

**NOTE**: You'll have to set your app category as a game and request the user_friends permission. See https://developers.facebook.com/docs/graph-api/reference/v2.0/user/invitable_friends

## LICENSE ##

The MIT License
