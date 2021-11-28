import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/firestore_methods/message_methods.dart';
import 'package:served_food/app/modules/chat/controllers/chat_controller.dart';
import 'package:served_food/app/modules/chat/controllers/chat_home_controller.dart';
import 'package:served_food/app/modules/chat/models/message_model.dart';
import 'package:served_food/app/modules/chat/views/chat_view.dart';
import 'package:skeletons/skeletons.dart';

class RecentChats extends StatefulWidget {
  final UserModel me;

  const RecentChats({Key key, this.me}) : super(key: key);
  @override
  RecentChatsState createState() {
    return RecentChatsState();
  }
}

class RecentChatsState extends State<RecentChats> {
  List<MessageModel> lstMessages = [];
  @override
  void initState() {
    MessageMethods().getRecentChats(widget.me.id).then((value) {
      lstMessages = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> chatRooms =
        FirebaseFirestore.instance.collection('ChatRoom').snapshots();
    ChatHomeController controller = Get.put(ChatHomeController());
    return Expanded(
        child: Container(
            padding: EdgeInsets.all(kPadding),
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
                child: Obx(() {
                  if (!controller.isLoading.value) {
                    return StreamBuilder(
                        stream: controller.getRecentChats(),
                        builder: (context, snapshot) {
                          var data = controller.lstMessages;
                          return ListView.builder(
                            itemCount: controller.lstMessages.length,
                            itemBuilder: (BuildContext context, int index) {
                              final MessageModel chat = data[index];

                              return GestureDetector(
                                onTap: () async {
                                  String chatRoomId = '';
                                  await MessageMethods()
                                      .createChatRoom(
                                          controller.me.value.id,
                                          chat.receiver.id ==
                                                  controller.me.value.id
                                              ? chat.sender.id
                                              : chat.receiver.id)
                                      .then((value) => chatRoomId = value);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ChatView(
                                        user: chat.sender.id == widget.me.id
                                            ? chat.receiver
                                            : chat.sender,
                                        chatRoomId: chatRoomId,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: kPadding / 2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            imageUrl:
                                                widget.me.id == chat.sender.id
                                                    ? chat.receiver.image
                                                    : chat.sender.image,
                                            placeholder: (context, url) {
                                              return CircleAvatar(
                                                  radius: 25,
                                                  child: SkeletonAvatar());
                                            },
                                            fit: BoxFit.contain,
                                            imageBuilder:
                                                (context, imageProvider) {
                                              // you can access to imageProvider
                                              return CircleAvatar(
                                                radius:
                                                    25, // or any widget that use imageProvider like (PhotoView)
                                                backgroundImage: imageProvider,
                                              );
                                            },
                                          ),
                                          SizedBox(width: 10.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                widget.me.id == chat.sender.id
                                                    ? chat.receiver.firstName +
                                                        ' ' +
                                                        chat.receiver.lastName
                                                    : chat.sender.firstName +
                                                        ' ' +
                                                        chat.sender.lastName,
                                                style: TextStyle(
                                                  color: widget.me.id ==
                                                          chat.receiver.id
                                                      ? chat.unread
                                                          ? Colors.black
                                                          : Colors.grey
                                                      : Colors.grey,
                                                  fontSize: kSubtitleTextSize,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(height: 5.0),
                                              Container(
                                                width: Get.width / 2.5,
                                                child: Text(
                                                  chat.text,
                                                  style: TextStyle(
                                                      color: widget.me.id !=
                                                              chat.sender.id
                                                          ? chat.unread
                                                              ? Colors.black
                                                              : Colors.grey
                                                          : Colors.grey,
                                                      fontSize: 15.0,
                                                      fontWeight: widget
                                                                  .me.id !=
                                                              chat.sender.id
                                                          ? chat.unread
                                                              ? FontWeight.bold
                                                              : FontWeight.w400
                                                          : FontWeight.w400),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            chat.time
                                                .toString()
                                                .split(' ')
                                                .first,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  } else {
                    return Container(
                        width: Get.width,
                        padding: EdgeInsets.all(kPadding),
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
                          child: Center(
                            child: SpinKitFadingFour(
                              color: kBtnColorStart,
                              size: kIconSize * 2,
                            ),
                          ),
                        ));
                  }
                }))));
  }
}
