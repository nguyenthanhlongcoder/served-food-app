import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/firestore_methods/message_methods.dart';
import 'package:served_food/app/modules/chat/controllers/chat_home_controller.dart';
import 'package:served_food/app/modules/chat/views/chat_view.dart';
import 'package:skeletons/skeletons.dart';

class FavoriteContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ChatHomeController controller = Get.put(ChatHomeController());
    return Container(
      height: 120.0,
      child: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: controller.lstFavorites.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                controller.createChatRoom(
                    controller.me.value.id, controller.lstFavorites[index].id);
                String chatRoomId = '';
                await MessageMethods()
                    .createChatRoom(controller.me.value.id,
                        controller.lstFavorites[index].id)
                    .then((value) => chatRoomId = value);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChatView(
                        user: controller.lstFavorites[index],
                        chatRoomId: chatRoomId),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: 90,
                child: Column(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: controller.lstFavorites[index].image,
                      placeholder: (context, url) {
                        return CircleAvatar(
                            radius: 25, child: SkeletonAvatar());
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
                    SizedBox(height: 6.0),
                    Flexible(
                      child: Text(
                        controller.lstFavorites[index].firstName +
                            ' ' +
                            controller.lstFavorites[index].lastName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: kBodyTextSize,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
