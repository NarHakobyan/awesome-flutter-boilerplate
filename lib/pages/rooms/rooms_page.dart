import 'dart:async';
import 'dart:math';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/data/repositories/post_repository.dart';
import 'package:secure_chat/models/post/post.dart';
import 'package:secure_chat/store/auth/auth_state.dart';
import 'package:secure_chat/store/post/post_state.dart';

class RoomsPage extends StatefulWidget {
  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthState authState = GetIt.I<AuthState>();
  final Router router = GetIt.I<Router>();
  final PostState postStore = PostState();


  @override
  void initState() {
    super.initState();
    postStore.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            onPressed: () => _connectChannelDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _createChannelDialog(context),
          )
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
        Expanded(child: _buildChannelList(context)),
        Observer(
          builder: (_) => GestureDetector(
            onTap: authState.changeUserName,
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

  Widget _buildChannelList(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if(!postStore.dataState.hasData) {
          return const CircularProgressIndicator();
        }

        if(postStore.posts.isEmpty) {
          return Center(
            child: const Text('no data'),
          );
        }
        return _buildList(context, postStore.posts);
      },
    );
  }

  Widget _buildList(BuildContext context, List<Post> posts) {
    return ListView.separated(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) => _buildListItem(context, posts[index]),
      separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 1,
          ),
    );
  }

  Widget _buildListItem(BuildContext context, Post post) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.supervised_user_circle),
      ),
      key: ValueKey(post.id),
      title: Text(post.title, style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Text(
        post.id.toString(),
        style: TextStyle(color: Colors.grey[400]),
      ),
      onTap: () => router.navigateTo(context, '/rooms/${post.id}'),
    );
  }

  Future<void> _connectChannelDialog(BuildContext context) async {
    final GlobalKey<FormFieldState<String>> _channelFieldKey = GlobalKey<FormFieldState<String>>();

    final String channelKey = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fill channel key!'),
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
                  child: const Text('Cancel')),
              FlatButton(
                  onPressed: () async {
                    final FormFieldState<String> field = _channelFieldKey.currentState;
                    if (field.validate()) {
                      Navigator.of(context).pop(field.value);
                    }
                  },
                  child: const Text('Connect'))
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

    await router.navigateTo(context, '/rooms/$channelKey');
  }

  Future<void> _createChannelDialog(BuildContext context) async {
    final GlobalKey<FormFieldState<String>> _channelNameKey = GlobalKey<FormFieldState<String>>();

    final String channelKey = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Create new channel!'),
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
                  child: const Text('Cancel')),
              FlatButton(
                  onPressed: () async {
                    final FormFieldState<String> field = _channelNameKey.currentState;
                    if (field.validate()) {
                      final String _channelName = field.value;
                      final String channelKey = _createChannel(_channelName);
                      Navigator.of(context).pop(channelKey);
                    }
                  },
                  child: const Text('Create'))
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
            Clipboard.setData(ClipboardData(text: channelKey));
          }),
    ));
  }

  String _generateRandomKey() {
    final StringBuffer buffer = StringBuffer();
    final Random rnd = Random();
    for (int i = 0; i < 6; i++) {
      buffer.write(rnd.nextInt(9).toString());
    }
    return buffer.toString();
  }

  String _createChannel(String channelName) {
    final String channelKey = _generateRandomKey();
//
//    Room room = Room(key: channelKey, owner: Application.currentUser.uid, name: channelName, createdAt: DateTime.now());
//
//    DocumentReference documentReference = await Firestore.instance.collection('rooms').add(room.toJson());
//
//    room.reference = documentReference;

    return channelKey;
  }
}
