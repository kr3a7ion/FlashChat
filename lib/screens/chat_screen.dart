import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String id = 'chatScreen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String firestoreDocumentId = 'messages';
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String? messages;

  void getCurrentUser() {
    try {
      _auth.userChanges().listen((event) {
        if (event != null) {
          loggedInUser = event;
        }
      });
    } catch (e) {
      Exception(e);
    }
  }

  // void getmessages() async {
  //   final messages = await _firestore.collection(firestoreDocumentId).get();
  //   for (var message in messages.docs) {
  //     print(message.data());
  //   }
  // }

  // void messageStream() async {
  //   await for (var message
  //       in _firestore.collection(firestoreDocumentId).snapshots()) {
  //     for (var snapshot in message.docs) {
  //       print(snapshot.data());
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                Navigator.pop(context);
                _auth.signOut();
              }),
        ],
        title: const Text('⚡️Chat \u26A1'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection(firestoreDocumentId).snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final messages = snapshot.data!.docs;
                  List<Text> messageWidgets = [];
                  for (var message in messages) {
                    Map<String, dynamic> messageData =
                        message.data()! as Map<String, dynamic>;
                    final messageText = messageData['message'];
                    final sender = messageData['sender'];

                    final messageWidget = Text('$messageText From $sender');
                    messageWidgets.add(messageWidget);
                  }
                  return Column(
                    children: const [
                      
                    ],
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messages = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('messages').add({
                        'message': messages,
                        'sender': loggedInUser?.email,
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
