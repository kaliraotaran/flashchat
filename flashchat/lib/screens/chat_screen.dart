import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore
    .instance; // this was only supposed to be Firestore.instance
User loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagetextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  String messageText;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(user.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  // void getmessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var messages in messages.docs) {
  //     print(messages.data());
  //   }
  // }

  void messagesSent() async {
    await for (var snapshots in _firestore.collection('messages').snapshots()) {
      for (var messages in snapshots.docs) {
        print(messages.data());
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
                messagesSent();
                _auth.signOut();
                Navigator.pushNamed(context, WelcomeScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messagetextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        messagetextController.clear();
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser.email,
                        });
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
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent),
            );
          }
          final messages = snapshot.data.docs.reversed;
          List<Messagebubble> messageBubbles = [];
          for (var message in messages) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final currentuser = loggedInUser.email;
            // final messagedatetime = message['date and time'];

            final messageBubble = Messagebubble(
              text: messageText,
              Sender: messageSender,
              isMe: currentuser == messageSender,
            );
            //datetime: messagedatetime);
            messageBubbles.add(messageBubble);
            // messageBubbles.sort((a, b) => DateTime.parse(b.datetime)
            //   .compareTo(DateTime.parse(a.datetime))

          }
          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              children: messageBubbles,
            ),
          );
        });
  }
}

class Messagebubble extends StatelessWidget {
  const Messagebubble({
    Key key,
    this.Sender,
    this.text,
    this.isMe,
  });
  final String Sender;
  final String text;
  final bool isMe;
  // final String datetime;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$Sender',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          SizedBox(
            height: 5,
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 5,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('$text')),
            color: isMe ? Colors.blueAccent : Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flash_chat/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// final _firestore = FirebaseFirestore.instance;
// User loggedInUser;

// class ChatScreen extends StatefulWidget {
//   static const String id = 'chat_screen';
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final messageTextController = TextEditingController();
//   final _auth = FirebaseAuth.instance;

//   String messageText;

//   void getCurrentUser() async {
//     try {
//       final user = await _auth.currentUser;
//       if (user != null) {
//         loggedInUser = user;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void initState() {
//     super.initState();

//     getCurrentUser();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: null,
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 _auth.signOut();
//                 Navigator.pop(context);
//               }),
//         ],
//         title: Text('⚡️Chat'),
//         backgroundColor: Colors.lightBlueAccent,
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             MessagesStream(),
//             Container(
//               decoration: kMessageContainerDecoration,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: messageTextController,
//                       onChanged: (value) {
//                         messageText = value;
//                       },
//                       decoration: kMessageTextFieldDecoration,
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       messageTextController.clear();
//                       _firestore.collection('messages').add({
//                         'text': messageText,
//                         'sender': loggedInUser.email,
//                       });
//                     },
//                     child: Text(
//                       'Send',
//                       style: kSendButtonTextStyle,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 8,
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MessagesStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore.collection('messages').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Colors.lightBlueAccent,
//             ),
//           );
//         }
//         final messages = snapshot.data.docs;
//         List<MessageBubble> messageBubbles = [];
//         for (var message in messages) {
//           final messageText = message['text'];
//           final messageSender = message['sender'];

//           final currentUser = loggedInUser.email;

//           final messageBubble = MessageBubble(
//             sender: messageSender,
//             text: messageText,
//             isMe: currentUser == messageSender,
//           );

//           messageBubbles.add(messageBubble);
//         }
//         return Expanded(
//           child: ListView(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//             children: messageBubbles,
//           ),
//         );
//       },
//     );
//   }
// }

// class MessageBubble extends StatelessWidget {
//   MessageBubble({this.sender, this.text, this.isMe});

//   final String sender;
//   final String text;
//   final bool isMe;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment:
//             isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             sender,
//             style: TextStyle(
//               fontSize: 12.0,
//               color: Colors.black,
//             ),
//           ),
//           Material(
//             borderRadius: isMe
//                 ? BorderRadius.only(
//                     topLeft: Radius.circular(30.0),
//                     bottomLeft: Radius.circular(30.0),
//                     bottomRight: Radius.circular(30.0))
//                 : BorderRadius.only(
//                     bottomLeft: Radius.circular(30.0),
//                     bottomRight: Radius.circular(30.0),
//                     topRight: Radius.circular(30.0),
//                   ),
//             elevation: 5.0,
//             color: isMe ? Colors.lightBlueAccent : Colors.greenAccent,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: isMe ? Colors.white : Colors.black54,
//                   fontSize: 15.0,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
