import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.text,
      @required this.name,
      this.self = false,
      this.animationController,
      this.image});

  final bool self;
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
    var list = <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
            backgroundColor: self ? Colors.grey : null,
            foregroundColor: self ? Colors.white : null,
            child: Text(name[0].toUpperCase())),
      ),
      Expanded(
        child: Container(),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: _buildContent(),
          ),
        ],
      )
    ];

    return SizeTransition(
        sizeFactor: CurvedAnimation(
            parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: self ? list.reversed.toList() : list,
          ),
        ));
  }
}
