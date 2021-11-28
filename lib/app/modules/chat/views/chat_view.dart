import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ntp/ntp.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/firestore_methods/message_methods.dart';
import 'package:served_food/app/modules/chat/controllers/chat_controller.dart';
import 'package:served_food/app/modules/chat/models/message_model.dart';
import 'package:skeletons/skeletons.dart';

class ChatView extends StatefulWidget {
  final UserModel user;
  final String chatRoomId;
  ChatView({this.user, this.chatRoomId});

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  _buildMessage(MessageModel message, bool isMe, bool isLast) {
    final Column msg = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
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
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
            color: isMe ? kBtnColorStart : Color(0xFFf2f3f8),
            borderRadius: isMe
                ? BorderRadius.all(
                    Radius.circular(20),
                  )
                : BorderRadius.all(
                    Radius.circular(20),
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                message.time.toString().split(' ').last.split('.').first,
                style: TextStyle(
                  color: isMe ? Colors.white : Color(0xFF908e99),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                message.text,
                style: TextStyle(
                  color: isMe ? Colors.white : Color(0xFF908e99),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        isMe && isLast && message.unread == false
            ? Icon(
                Icons.remove_red_eye_outlined,
                size: kIconSize,
                color: kBtnColorEnd,
              )
            : Container()
      ],
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: widget.user.image,
          placeholder: (context, url) {
            return CircleAvatar(radius: 25, child: SkeletonAvatar());
          },
          fit: BoxFit.contain,
          imageBuilder: (context, imageProvider) {
            // you can access to imageProvider
            return CircleAvatar(
              radius:
                  15, // or any widget that use imageProvider like (PhotoView)
              backgroundImage: imageProvider,
            );
          },
        ),
        SizedBox(
          width: kPadding / 2,
        ),
        msg,
        BouncingWidget(
          scaleFactor: 3,
          onPressed: () {
            message.isLiked = !message.isLiked;

            MessageMethods().updateMessage(widget.chatRoomId, message);
          },
          child: Icon(
            message.isLiked ? Icons.favorite : Icons.favorite_border,
            size: 30.0,
            color: message.isLiked ? kBtnColorStart : Color(0xFFCACBCC),
          ),
        )
      ],
    );
  }

  _buildMessageComposer(ChatController controller) {
    TextEditingController textEditingController = new TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: kBtnColorStart,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: textEditingController,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: kBtnColorStart,
            onPressed: () async {
              if (textEditingController.text != '') {
                DateTime time = await NTP.now();
                MessageModel message = new MessageModel(
                    sender: controller.me.value,
                    time: time,
                    text: textEditingController.text,
                    isLiked: false,
                    receiver: widget.user,
                    unread: true);
                controller.sendMesage(widget.chatRoomId, message.toJson());
                FocusScope.of(context).unfocus();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ChatController controller = Get.put(ChatController());
    controller.getMe();
    controller.getMessages(widget.chatRoomId);
    controller.seenMessage(widget.chatRoomId, controller.me.value);
    final Stream<QuerySnapshot> chatRooms = FirebaseFirestore.instance
        .collection('ChatRoom')
        .doc(widget.chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots();

    return Scaffold(
      backgroundColor: kBtnColorStart,
      appBar: AppBar(
        title: Row(
          children: [
            CachedNetworkImage(
              imageUrl: widget.user.image,
              placeholder: (context, url) {
                return CircleAvatar(radius: 25, child: SkeletonAvatar());
              },
              fit: BoxFit.contain,
              imageBuilder: (context, imageProvider) {
                // you can access to imageProvider
                return CircleAvatar(
                  radius:
                      25, // or any widget that use imageProvider like (PhotoView)
                  backgroundImage: imageProvider,
                );
              },
            ),
            SizedBox(
              width: kPadding / 2,
            ),
            Text(
              widget.user.firstName,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: kPadding,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: kPadding),
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
                  child: StreamBuilder<QuerySnapshot>(
                      stream: chatRooms,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                                reverse: true,
                                padding: EdgeInsets.all(kPadding),
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final MessageModel message =
                                      MessageModel.fromJson(
                                          snapshot.data.docs[index].data());
                                  bool isLast = index == 0 ? true : false;
                                  bool isMe = message.sender.id ==
                                          controller.me.value.id
                                      ? true
                                      : false;
                                  return _buildMessage(message, isMe, isLast);
                                },
                              )
                            : Container();
                      }),
                ),
              ),
            ),
            _buildMessageComposer(controller),
          ],
        ),
      ),
    );
  }
}
