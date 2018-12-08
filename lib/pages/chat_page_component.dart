import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:secure_chat/components/chat_message_component.dart';

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

    @override
    void initState() {
        print(widget.roomId);
        super.initState();
    }

    getImage(ImageSource imageSource) => () async {
            File image = await ImagePicker.pickImage(source: imageSource);

            if(image != null) {
                ChatMessage message = new ChatMessage(
                    image: image,
                    name: 'Narek',
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
        data: new IconThemeData(color: Theme
            .of(context)
            .accentColor),
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
                            InputDecoration.collapsed(
                                hintText: "Send a message"),
                        ),
                    ),
                    new Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          children: <Widget>[
                            new IconButton(
                                tooltip: "Photo",
                                icon: new Icon(Icons.camera_alt),
                                onPressed: getImage(ImageSource.camera)
                            ),
                            new IconButton(
                                icon: new Icon(Icons.image),
                                onPressed: getImage(ImageSource.gallery)
                            ),
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
            bgcolor: "#e74c3c",
            textcolor: '#ffffff');
        return;
    }
    _textController.clear();
    ChatMessage message = new ChatMessage(
        text: text,
        // TODO use real user name
        name: 'Narek',
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

Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: Text("Friendlychat")),
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
                    decoration: new BoxDecoration(color: Theme
                        .of(context)
                        .cardColor),
                    child: _buildTextComposer(),
                ),
            ],
        ),
    );
}}
