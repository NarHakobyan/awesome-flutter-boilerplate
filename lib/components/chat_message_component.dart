import 'dart:io';

import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
    ChatMessage({this.text, @required this.name, this.animationController, this.image});

    final String text;
    final File image;
    final String name;
    final AnimationController animationController;

    Widget _buildContent() {
        if (text != null) {
            return Text(text);
        } else if (image != null) {
            return Container(
                child: Image.file(image),
                constraints: BoxConstraints(
                    maxHeight: 300.0,
                    maxWidth: 200.0,
                    minWidth: 150.0,
                    minHeight: 150.0),
            );
        }

        return SizedBox();
    }

    Widget build(BuildContext context) {
        return new SizeTransition(
            sizeFactor: new CurvedAnimation(
                parent: animationController, curve: Curves.easeOut),
            axisAlignment: 0.0,
            child: new Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        new Container(
                            margin: const EdgeInsets.only(right: 16.0),
                            child: new CircleAvatar(child: new Text(name[0])),
                        ),
                        new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                new Text(name, style: Theme
                                    .of(context)
                                    .textTheme
                                    .subhead),
                                new Container(
                                    margin: const EdgeInsets.only(top: 5.0),
                                    child: _buildContent(),
                                ),
                            ],
                        ),
                    ],
                ),
            ));
    }
}
