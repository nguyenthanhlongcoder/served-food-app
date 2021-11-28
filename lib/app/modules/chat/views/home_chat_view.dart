import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/firestore_methods/user_methods.dart';
import 'package:served_food/app/modules/browse/widgets/search_input.dart';
import 'package:served_food/app/modules/chat/controllers/chat_home_controller.dart';
import 'package:served_food/app/modules/chat/widgets/category_selector.dart';
import 'package:served_food/app/modules/chat/widgets/favorite_contacts.dart';
import 'package:served_food/app/modules/chat/widgets/recent_chats.dart';
import 'package:served_food/app/modules/chat/widgets/search_field_widget.dart';
import 'package:skeletons/skeletons.dart';

class HomeChatView extends StatefulWidget {
  @override
  _HomeChatViewState createState() => _HomeChatViewState();
}

class _HomeChatViewState extends State<HomeChatView> {
  ChatHomeController controller = Get.put(ChatHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBtnColorStart,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: kPadding / 2),
          child: Row(
            children: [
              Obx(() {
                if (controller.me.value.image == null) {
                  return CircleAvatar(radius: 20, child: SkeletonAvatar());
                } else {
                  return CachedNetworkImage(
                    imageUrl: controller.me.value.image,
                    placeholder: (context, url) {
                      return CircleAvatar(radius: 20, child: SkeletonAvatar());
                    },
                    fit: BoxFit.contain,
                    imageBuilder: (context, imageProvider) {
                      // you can access to imageProvider
                      return CircleAvatar(
                        radius:
                            20, // or any widget that use imageProvider like (PhotoView)
                        backgroundImage: imageProvider,
                      );
                    },
                  );
                }
              }),
              SizedBox(
                width: kPadding / 2,
              ),
              Text(
                'Chats',
                style: TextStyle(
                  fontSize: kTitleTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: kBtnColorStart,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Obx(() {
                  return Column(
                    children: <Widget>[
                      FavoriteContacts(),
                      RecentChats(me: controller.me.value),
                    ],
                  );
                })),
          ),
        ],
      ),
    );
  }
}
