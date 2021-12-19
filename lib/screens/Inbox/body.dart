//import 'package:bla_bla_car_clone/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'chat_detail_page.dart';

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers({
    @required this.name,
    @required this.messageText,
    @required this.imageURL,
    @required this.time,
  });
}

class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  bool isMessageRead;
  ConversationList({
    @required this.name,
    @required this.messageText,
    @required this.imageUrl,
    @required this.time,
    @required this.isMessageRead,
  });
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    // String _name = widget.name;
    // String _messageText = widget.messageText;
    // String _imageUrl = widget.imageUrl;
    // String _time = widget.time;
    // bool _isMessageRead = widget.isMessageRead;
    //ConversationList cl = new ConversationList(name: _name, messageText: _messageText, imageUrl: _imageUrl, time: _time, isMessageRead: _isMessageRead);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatDetailPage(conversationList: new ConversationList(name: widget.name, messageText: widget.messageText, imageUrl: widget.imageUrl, time: widget.time, isMessageRead: widget.isMessageRead));
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        widget.imageUrl), //NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: widget.isMessageRead
                                  ? FontWeight.w700
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.time,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.w700
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<ChatUsers> chatUsers = [
      ChatUsers(
          name: "Ahmed",
          messageText: "Main Nahi btau ga",
          imageURL: "assets/images/Profile Image.png",
          time: "Now"),
      ChatUsers(
          name: "Ali",
          messageText: "Ye batain btai nai jati",
          imageURL: "assets/images/Profile Image.png",
          time: "Yesterday"),
      ChatUsers(
          name: "Usama",
          messageText: "Nazar lag jati",
          imageURL: "assets/images/Profile Image.png",
          time: "31 Mar"),
      ChatUsers(
          name: "Zeeshaan",
          messageText: "A gya hai tu jawan ho kar!",
          imageURL: "assets/images/Profile Image.png",
          time: "28 Mar"),
      ChatUsers(
          name: "Abdul Rehman",
          messageText: "Thankyou, It's awesome",
          imageURL: "assets/images/Profile Image.png",
          time: "23 Mar"),
      ChatUsers(
          name: "Usama",
          messageText: "will update you in evening",
          imageURL: "assets/images/Profile Image.png",
          time: "17 Mar"),
      ChatUsers(
          name: "Zeeshaan",
          messageText: "Can you please share the file?",
          imageURL: "assets/images/Profile Image.png",
          time: "24 Feb"),
      ChatUsers(
          name: "Ammar",
          messageText: "How are you?",
          imageURL: "assets/images/Profile Image.png",
          time: "18 Feb"),
      ChatUsers(
          name: "Naagin",
          messageText: "How are you?",
          imageURL: "assets/images/Profile Image.png",
          time: "18 Feb"),
    ];
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 5),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead:
                        (index == 0 || index == 3 || index == 5) ? true : false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
