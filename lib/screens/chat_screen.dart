import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {

  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String messageText;

  @override
  void initState() {
    super.initState();
    currentUser();
  }
  void currentUser()
  async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    }
    catch(e)
    {
      print(e);
    }
  }

 void messageStream() // this is a Dart Stream, as soon as data is put in firestore, it gets printed over here
 // String : Future<String> - Singular
 // List<String> : Stream<String>  - Plural

 async {
   await for (var snapshots in _firestore.collection('message').snapshots()) {
     for(var message in snapshots.documents)
       {
         print(message.data);
       }
   }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messageStream();
                //_auth.signOut();
                //Navigator.pop(context);
              }),
        ],
        title: Text('⚡  Flash Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream : _firestore.collection('message').snapshots(),
              builder : (context, snapshot) {
                if(!snapshot.hasData)
                  {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                    final messages = snapshot.data.documents;
                    List<Text> messageWidgets = [];
                    for(var message in messages)
                      {
                        final messageText = message.data['text'];
                        final messageSender = message.data['sender'];

                        final messageWidget =
                            Text('$messageText from $messageSender',
                        style: TextStyle(
                          fontSize: 50.0,
                        ),
                );
                        messageWidgets.add(messageWidget);
                      }
                    return Expanded(
                      child: ListView(
                        children: messageWidgets,
                      ),
                    );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //messageText : text , loggedInUser.email : sender
                      //message is the type
                      _firestore.collection('message').add({'text' : messageText, 'sender' : loggedInUser.email});
                      },
                    child: Text(
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
