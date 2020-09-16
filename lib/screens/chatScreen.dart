import 'package:UI/helpers/app_constants.dart';
import 'package:UI/helpers/names.dart';
import 'package:UI/models/messages.dart';
import 'package:UI/models/users.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Stream chatMessagesStream;

  TextEditingController messageController = new TextEditingController();

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe
            ? AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR_ACTION)
            : AppConstants.hexToColor(
                AppConstants.APP_PRIMARY_FONT_COLOR_WHITE),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.text,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message.time,
            style: TextStyle(
              color: isMe ? Colors.white : Colors.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
        IconButton(
          icon: message.isLiked
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: message.isLiked
              ? AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR)
              : Colors.blueGrey,
          onPressed: () {},
        )
      ],
    );
  }

  Widget ChatMessageList() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                child: ListView.builder(
                  reverse: true,
                  padding: EdgeInsets.only(top: 15.0),
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Message message = messages[index];
                    final bool isMe = message.sender.id == currentUser.id;
                    return _buildMessage(message, isMe);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "sendBy": Constant.myName,
        "message": messageController.text,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      // databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
//      after we have sent the message the messge bar should be cleared
      messageController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image(
          image: AssetImage(widget.user.imageUrl),
        ),
        title: Text(
          widget.user.name,
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor:
            AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: Row(
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: () {
                        AlertDialog(
                          title: Text("To be Updated.."),
                          content: Text(
                              "Sending image will be enables in next version"),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            )
                          ],
                        );
                      },
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      shape: CircleBorder(),
                      elevation: 3.0,
                      fillColor: AppConstants.hexToColor(
                          AppConstants.APP_PRIMARY_COLOR),
                    ),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          hintText: 'Type your message...',
                          filled: true,
                          hintStyle: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            height: 47,
                            width: 47,
                            decoration: BoxDecoration(
                              color: AppConstants.hexToColor(
                                  AppConstants.APP_PRIMARY_COLOR),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Image.asset("assests/images/send.png")),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
