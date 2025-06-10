import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project_ui/Features/community/Models/continars.dart';
import 'package:graduation_project_ui/Features/community/Models/continars_items.dart';
import 'package:graduation_project_ui/Features/community/presention/view/widgets/Post_container.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';
import 'package:graduation_project_ui/core/Utils/App_images.dart';
import 'package:graduation_project_ui/Features/community/presention/view/widgets/chat_bot_dialog.dart';

class CommunityViewBody extends StatelessWidget {
  const CommunityViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(child: postcontainer()),
        ),
        Positioned(
          bottom: 24,
          right: 24,
          child: FloatingActionButton(
            backgroundColor: KPrimaryColor,
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const ChatBotDialog(),
              );
            },
            child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class postcontainer extends StatelessWidget {
  const postcontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push('/NewsView');
                      },
                      child: Continars(
                        item1(
                          image: Assets.assetsImagesEarth,
                          text: 'News',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Continars(
                        item1(image: Assets.assetsImagesNearby, text: 'Nearby'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Continars(
                      item1(image: Assets.assetsImagesChatBot, text: 'ChatBot'),
                    ),
                    const SizedBox(width: 10),
                    Continars(
                      item1(image: Assets.assetsImagesEarth, text: 'Sports'),
                    ),
                    const SizedBox(width: 10),
                    Continars(
                      item1(
                        image: Assets.assetsImagesEarth,
                        text: 'Technology',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 15, (
            context,
            index,
          ) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Post_container(),
            );
          }),
        )
      ],
    ); //Post_container();
  }
}
