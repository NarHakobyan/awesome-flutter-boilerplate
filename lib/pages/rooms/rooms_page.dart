import 'dart:async';
import 'dart:math';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/store/auth/auth_store.dart';

class RoomsPage extends StatefulWidget {
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final authState = GetIt.I<AuthStore>();
  final router = GetIt.I<Router>();

  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Channels',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.chat),
              onPressed: () => _connectChannelDialog(context)),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _createChannelDialog(context))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSearchBar(context),
        /*Expanded(child: _buildChannelList(context))*/
        Observer(
          builder: (_) => GestureDetector(
                onTap: () {
                  authState.changeUserName();
                },
                child: Text(
                  '${authState.currentUser.firstName}',
                  style: Theme.of(context).textTheme.display1,
                ),
              ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        keyboardType: TextInputType.text,
        maxLines: 1,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          border: InputBorder.none,
          hintText: 'Jump to conversation ...',
        ),
      ),
    );
  }

//  Widget _buildChannelList(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('rooms').where('owner', isEqualTo: Application.currentUser.uid).snapshots(),
//      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//        if (!snapshot.hasData) return LinearProgressIndicator();
//
//        return _buildList(context, snapshot.data.documents);
//      },
//    );
//  }

//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView.separated(
//      itemCount: snapshot.length,
//      itemBuilder: (BuildContext context, int index) => _buildListItem(context, snapshot[index]),
//      separatorBuilder: (BuildContext context, int index) => Divider(
//            height: 1,
//          ),
//    );
//  }

//  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//    final record = Room.fromSnapshot(data);
//    return ListTile(
//      leading: CircleAvatar(
//        child: Icon(Icons.supervised_user_circle),
//      ),
//      key: ValueKey(record.name),
//      title: Text(record.name, style: TextStyle(fontWeight: FontWeight.bold),),
//      subtitle: Text(
//        record.key,
//        style: TextStyle(color: Colors.grey[400]),
//      ),
//      onTap: () => router.navigateTo(context, '/rooms/${record.key}'),
//    );
//  }

  Future<void> _connectChannelDialog(BuildContext context) async {
    final _channelFieldKey = GlobalKey<FormFieldState>();

    String channelKey = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Fill channel key!'),
            content: TextFormField(
              key: _channelFieldKey,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'please fill the field'.toUpperCase();
                }
                return null;
              },
              maxLines: 1,
              decoration: InputDecoration(hintText: 'Channel key...'),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () async {
                    final field = _channelFieldKey.currentState;
                    if (field.validate()) {
                      Navigator.of(context).pop(field.value);
                    }
                  },
                  child: Text('Connect'))
            ],
          );
        });

    if (channelKey == null) {
      return;
    }

//    final QuerySnapshot room =
//        await Firestore.instance.collection('rooms').where('key', isEqualTo: channelKey).getDocuments();

//    if (room.documents.isEmpty) {
//      Fluttertoast.showToast(
//          msg: "Channel not found".toUpperCase(),
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.BOTTOM,
//          timeInSecForIos: 1,
//          backgroundColor: Colors.red,
//          textColor: Colors.white);
//      return;
//    }

    router.navigateTo(context, '/rooms/$channelKey');
  }

  Future<void> _createChannelDialog(BuildContext context) async {
    final _channelNameKey = GlobalKey<FormFieldState>();

    String channelKey = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Create new channel!'),
            content: TextFormField(
              key: _channelNameKey,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'please fill the field'.toUpperCase();
                }
                return null;
              },
              maxLines: 1,
              decoration: InputDecoration(hintText: 'Channel name...'),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel')),
              FlatButton(
                  onPressed: () async {
                    final field = _channelNameKey.currentState;
                    if (field.validate()) {
                      String _channelName = field.value;
                      String channelKey = await _createChannel(_channelName);
                      Navigator.of(context).pop(channelKey);
                    }
                  },
                  child: Text('Create'))
            ],
          );
        });

    if (channelKey == null) {
      return;
    }
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Save your secret key: $channelKey'),
      action: SnackBarAction(
          label: 'Copy',
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: channelKey));
          }),
    ));
  }

  String _generateRandomKey() {
    var key = '';
    var rnd = new Random();
    for (var i = 0; i < 6; i++) {
      key = key + rnd.nextInt(9).toString();
    }
    return key;
  }

  _createChannel(String channelName) async {
    String channelKey = _generateRandomKey();
//
//    Room room = Room(key: channelKey, owner: Application.currentUser.uid, name: channelName, createdAt: DateTime.now());
//
//    DocumentReference documentReference = await Firestore.instance.collection('rooms').add(room.toJson());
//
//    room.reference = documentReference;

    return channelKey;
  }
}
