import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secure_chat/widget/chat_message_component.dart';

class ChatPage extends StatefulWidget {
  final String roomId;

  @override
  _ChatPageState createState() => _ChatPageState();

  ChatPage({@required this.roomId});
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.roomId,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
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
          ChatMessage message = ChatMessage(
            image: image,
            name: displayName,
            self: true,
            animationController: AnimationController(
              duration: Duration(milliseconds: 700),
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
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: <Widget>[
                  IconButton(
                      tooltip: "Photo",
                      icon: Icon(Icons.camera_alt),
                      onPressed: getImage(ImageSource.camera)),
                  IconButton(
                      icon: Icon(Icons.image),
                      onPressed: getImage(ImageSource.gallery)),
                  IconButton(
                      icon: Icon(Icons.send),
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

    ChatMessage message = ChatMessage(
      text: text,
      self: true,
      name: displayName,
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
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
