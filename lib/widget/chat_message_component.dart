import 'dart:io';

import 'package:flutter/material.dart';

@immutable
class ChatMessage extends StatelessWidget {
  const ChatMessage({
    @required this.name,
    this.text,
    this.self = false,
    this.animationController,
    this.image,
  });

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
        constraints: const BoxConstraints(
          maxHeight: 300,
          maxWidth: 200,
          minWidth: 150,
          minHeight: 150,
        ),
        child: Image.file(image),
      );
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 16),
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
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildContent(),
          ),
        ],
      )
    ];

    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: self ? list.reversed.toList() : list,
          ),
        ));
  }
}
