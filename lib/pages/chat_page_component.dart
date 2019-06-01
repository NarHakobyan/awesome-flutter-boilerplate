import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secure_chat/components/chat_message_component.dart';
import 'package:secure_chat/config/application.dart';

class ChatPageComponent extends StatefulWidget {
  final String roomId;

  @override
  _ChatPageComponentState createState() => _ChatPageComponentState();

  ChatPageComponent({@required this.roomId});
}

class _ChatPageComponentState extends State<ChatPageComponent>
    with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          widget.roomId,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  getImage(ImageSource imageSource) => () async {
        File image = await ImagePicker.pickImage(source: imageSource);
//        final String displayName = Application.currentUser.displayName;
        final String displayName = 'displayName';

        if (image != null) {
          ChatMessage message = new ChatMessage(
            image: image,
            name: displayName,
            self: true,
            animationController: new AnimationController(
              duration: new Duration(milliseconds: 700),
              vsync: this,
            ),
          );
          setState(() {
            _messages.insert(0, message);
          });
          message.animationController
              .forward()
              .then((void _) => message.animationController.dispose());
        }
      };

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: <Widget>[
                  new IconButton(
                      tooltip: "Photo",
                      icon: new Icon(Icons.camera_alt),
                      onPressed: getImage(ImageSource.camera)),
                  new IconButton(
                      icon: new Icon(Icons.image),
                      onPressed: getImage(ImageSource.gallery)),
                  new IconButton(
                      icon: new Icon(Icons.send),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    if (text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Message is required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return;
    }
    _textController.clear();
    final displayName = 'displayName';

    ChatMessage message = new ChatMessage(
      text: text,
      self: true,
      name: displayName,
      animationController: new AnimationController(
        duration: new Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController
        .forward()
        .then((void _) => message.animationController.dispose());
  }
}
