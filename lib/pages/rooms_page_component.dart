import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/models/Room.dart';

class RoomsPageComponent extends StatefulWidget {
  @override
  _RoomsPageComponentState createState() => _RoomsPageComponentState();
}

class _RoomsPageComponentState extends State<RoomsPageComponent> {
  Widget build(BuildContext context) {
    return new Scaffold(
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
                print('add');
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
}
