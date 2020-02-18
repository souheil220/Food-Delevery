import 'package:flutter/material.dart';
import '../style/const.dart';
import 'chatScreen.dart';

class Chat extends StatelessWidget {
  static const String id = 'chat';
  final String peerId;
  final String peerAvatar;

  Chat({@required this.peerId, @required this.peerAvatar});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'CHAT',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: new ChatScreen(
        peerId: peerId,
        peerAvatar: peerAvatar,
      ),
    );
  }
}

