import 'package:UI/helpers/app_constants.dart';
import 'package:UI/helpers/names.dart';
import 'package:UI/models/messages.dart';
import 'package:UI/screens/chatScreen.dart';
import 'package:UI/screens/searchScreen.dart';
import 'package:UI/screens/SignIn.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Widget chatRoomsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index) {
          final Message chat = chats[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  user: chat.sender,
                ),
              ),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.75,
              margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35.0,
                        backgroundImage: AssetImage(chat.sender.imageUrl),
                      ),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            chat.sender.name,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(
                              chat.text,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        chat.time,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      chat.unread
                          ? Container(
                              width: 40.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                color: AppConstants.hexToColor(
                                    AppConstants.APP_PRIMARY_COLOR),
                                // Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'NEW',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : Text(''),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: () {},
        ),
        title: Image.asset("assests/images/ca_logo.png"),
        // Text("Let's Connect.."),
        backgroundColor:
            AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR),

        actions: <Widget>[
          GestureDetector(
            onTap: () {
              // authMethods.Signout();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {}));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            chatRoomsList(),
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor:
                    AppConstants.hexToColor(AppConstants.APP_PRIMARY_COLOR),
                child: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
