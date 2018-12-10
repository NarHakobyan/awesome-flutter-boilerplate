import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/models/room.dart';

class RoomsPageComponent extends StatefulWidget {
  @override
  _RoomsPageComponentState createState() => _RoomsPageComponentState();
}

class _RoomsPageComponentState extends State<RoomsPageComponent> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Channels",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _createChannelDialog(context);
              })
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[_buildSearchBar(context), Expanded(child: _buildChannelList(context))],
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

  Widget _buildChannelList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('rooms').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.separated(
      itemCount: snapshot.length,
      itemBuilder: (BuildContext context, int index) => _buildListItem(context, snapshot[index]),
      separatorBuilder: (BuildContext context, int index) => Divider(
            height: 1,
          ),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Room.fromSnapshot(data);
    return ListTile(
      key: ValueKey(record.name),
      title: Text(record.name),
      onTap: () => Application.router.navigateTo(context, '/rooms/${record.id}'),
    );
  }

  Future<void> _createChannelDialog(BuildContext context) async {
    String channelKey = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _channelNameKey = GlobalKey<FormFieldState>();

          return AlertDialog(
            title: Text('Create new channel!'),
            content: TextFormField(
              key: _channelNameKey,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'please fill the field'.toUpperCase();
                }
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

    print('channelKey, $channelKey');
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
    String channelId = _generateRandomKey();

    Room room = Room(id: channelId, name: channelName, createdAt: DateTime.now());

    DocumentReference documentReference = await Firestore.instance.collection('rooms').add(room.toJson());

    room.reference = documentReference;

    print(room);

    return channelId;
  }

  _RoomsPageComponentState();
}
