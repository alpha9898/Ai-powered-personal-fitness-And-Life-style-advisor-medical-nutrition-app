import 'package:graduation_project_ui/core/Utils/App_images.dart';

class BottomNavigationBarEntity {
  final String title;
  final String Activeimage;

  BottomNavigationBarEntity({
    required this.title,
    required this.Activeimage,
  });
}

List<BottomNavigationBarEntity> BottomNavigationBarList = [
  BottomNavigationBarEntity(
    title: 'Home',
    Activeimage: Assets.assetsSvgHomeIconNavi,
  ),
  BottomNavigationBarEntity(
    title: 'Progress',
    Activeimage: Assets.assetsSvgProgressIconNavi,
  ),
  BottomNavigationBarEntity(
    title: 'Favorite',
    Activeimage: Assets.assetsSvgFavIconNavi,
  ),
  BottomNavigationBarEntity(
    title: 'Settings',
    Activeimage: Assets.assetsSvgSettingIconNavi,
  ),
];
