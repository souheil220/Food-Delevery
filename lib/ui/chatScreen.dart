import 'dart:async';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'fullPhoto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../style/const.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat-screen';
  final String peerId;
  final String peerAvatar;

  ChatScreen({Key key, @required this.peerId, @required this.peerAvatar}) : super(key: key);

  @override
  State createState() => new ChatScreenState(peerId: peerId, peerAvatar: peerAvatar);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.peerId, @required this.peerAvatar});

  String peerId;
  String peerAvatar;
  String id;

  var listMessage;
  String groupChatId;
  SharedPreferences prefs;

  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;

  final TextEditingController textEditingController = new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  final FocusNode focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {
      // Hide sticker when keyboard appear
      setState(() {
        isShowSticker = false;
      });
    }
  }

  readLocal() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id') ?? user.uid;
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    Firestore.instance.collection('users').document(id).updateData({'chattingWith': peerId});

    setState(() {});
  }

  Future getImage() async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        isLoading = true;
      });
      uploadFile();
    }
  }

  void getSticker() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isShowSticker = !isShowSticker;
    });
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  void onSendMessage(String content, int type) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = Firestore.instance
          .collection('messages')
          .document(groupChatId)
          .collection(groupChatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());

      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type
          },
        );
      });
      listScrollController.animateTo(0.0, duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    } else {
      Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document['idFrom'] == id) {
      // Right (my message)
      return Row(
        children: <Widget>[
          document['type'] == 0
              // Text
              ? Container(
                  child: Text(
                    document['content'],
                    style: TextStyle(color: primaryColor),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(color: greyColor2, borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                )
              : document['type'] == 1
                  // Image
                  ? Container(
                      child: FlatButton(
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                              ),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: greyColor2,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                'images/img_not_available.jpeg',
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: document['content'],
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
                        },
                        padding: EdgeInsets.all(0),
                      ),
                      margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                    )
                  // Sticker
                  : Container(
                      child: new Image.asset(
                        'images/${document['content']}.gif',
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                      margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                    ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      // Left (peer message)
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMessageLeft(index)
                    ? Material(
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                            ),
                            width: 35.0,
                            height: 35.0,
                            padding: EdgeInsets.all(10.0),
                          ),
                          imageUrl: 'data:image/png;base64,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',//peerAvatar,
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(width: 35.0),
                document['type'] == 0
                    ? Container(
                        child: Text(
                          document['content'],
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : document['type'] == 1
                        ? Container(
                            child: FlatButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                                    ),
                                    width: 200.0,
                                    height: 200.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: greyColor2,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Material(
                                    child: Image.asset(
                                      'images/img_not_available.jpeg',
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: document['content'],
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => FullPhoto(url: document['content'])));
                              },
                              padding: EdgeInsets.all(0),
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        : Container(
                            child: new Image.asset(
                              'images/${document['content']}.gif',
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                            margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                          ),
              ],
            ),

            // Time
            isLastMessageLeft(index)
                ? Container(
                    child: Text(
                      DateFormat('dd MMM kk:mm')
                          .format(DateTime.fromMillisecondsSinceEpoch(int.parse(document['timestamp']))),
                      style: TextStyle(color: greyColor, fontSize: 12.0, fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 50.0, top: 5.0, bottom: 5.0),
                  )
                : Container()
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] == id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 && listMessage != null && listMessage[index - 1]['idFrom'] != id) || index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
    } else {
     // Firestore.instance.collection('users').document(id).updateData({'chattingWith': null});
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(),

              // Sticker
              (isShowSticker ? buildSticker() : Container()),

              // Input content
              buildInput(),
            ],
          ),

          // Loading
          buildLoading()
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  Widget buildSticker() {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi1', 2),
                child: new Image.asset(
                  'images/mimi1.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi2', 2),
                child: new Image.asset(
                  'images/mimi2.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi3', 2),
                child: new Image.asset(
                  'images/mimi3.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi4', 2),
                child: new Image.asset(
                  'images/mimi4.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi5', 2),
                child: new Image.asset(
                  'images/mimi5.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi6', 2),
                child: new Image.asset(
                  'images/mimi6.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => onSendMessage('mimi7', 2),
                child: new Image.asset(
                  'images/mimi7.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi8', 2),
                child: new Image.asset(
                  'images/mimi8.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              ),
              FlatButton(
                onPressed: () => onSendMessage('mimi9', 2),
                child: new Image.asset(
                  'images/mimi9.gif',
                  width: 50.0,
                  height: 50.0,
                  fit: BoxFit.cover,
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Button send image
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.image),
                onPressed: getImage,
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 1.0),
              child: new IconButton(
                icon: new Icon(Icons.face),
                onPressed: getSticker,
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),

          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: primaryColor, fontSize: 15.0),
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: greyColor),
                ),
                focusNode: focusNode,
              ),
            ),
          ),

          // Button send message
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 8.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(color: greyColor2, width: 0.5)), color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder(
              stream: Firestore.instance
                  .collection('messages')
                  .document(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(20)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(themeColor)));
                } else {
                  listMessage = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) => buildItem(index, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }
  }