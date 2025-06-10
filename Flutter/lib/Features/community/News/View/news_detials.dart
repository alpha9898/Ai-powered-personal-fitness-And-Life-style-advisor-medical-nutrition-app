import 'package:flutter/material.dart';
import 'package:graduation_project_ui/Features/community/Models/articals_model.dart';
import 'package:graduation_project_ui/core/Common/common_container.dart';
import 'package:graduation_project_ui/core/Utils/AppColors.dart';

class NewsDetials extends StatelessWidget {
  final ArticalsModel artical;
  const NewsDetials({super.key, required this.artical});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Detials')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonContainer(
              width: double.infinity,
              heighht: 250,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Center(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: DecorationImage(
                          image: NetworkImage(artical.image!),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Row(
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: KPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'published on ${artical.publishedAt}',
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Row(
                children: [
                  Container(
                    height: 12,
                    width: 12,
                    decoration: BoxDecoration(
                      color: KPrimaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'published by ${artical.author}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Text(
                artical.content!,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  height: 1.5,
                  letterSpacing: 1.5,
                  wordSpacing: 1.5,
                  fontStyle: FontStyle.italic,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 1.5,
                ),
              ),
            ),
          ],
        )),

        // Column(
        //   children: [
        //     Text(
        //       artical.title!,
        //       style: const TextStyle(
        //         fontSize: 18,
        //         fontWeight: FontWeight.w700,
        //         color: Colors.grey,
        //       ),
        //     ),
        //     SizedBox(height: 50),
        //     Text(
        //       artical.content!,
        //       style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //     ),
        //     SizedBox(height: 50),
        //     // GestureDetector(
        //     //   onTap: () {
        //     //     openNewsLink(artical.url!);
        //     //   },
        //     //   child: Text(
        //     //     'To Read More Click Here',
        //     //     style: const TextStyle(
        //     //       fontSize: 20,
        //     //       fontWeight: FontWeight.bold,
        //     //       color: Colors.blue,
        //     //       decoration: TextDecoration.underline,
        //     //     ),
        //     //   ),
        //     // ),

        //     // ElevatedButton(
        //     //   onPressed: () async {
        //     //     final uri = Uri.parse("https://www.google.com");
        //     //     if (await canLaunchUrl(uri)) {
        //     //       await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
        //     //     } else {
        //     //       print("Can't launch Google");
        //     //     }
        //     //   },
        //     //   child: Text("Open Google"),
        //     // ),
        //   ],
        // ),
      ),
    );
  }
}
