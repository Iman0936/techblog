import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/component/my_string.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/component/my_colors.dart';
import 'package:techblog/view/main_screen/home_screen.dart';
import 'package:techblog/view/main_screen/profile_screen.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainScreen extends StatelessWidget {
  RxInt selectedPageIndex = 0.obs;

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          backgroundColor: SolidColors.scafoldBg,
          child: Padding(
            padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Image.asset(Assets.images.logo.path, scale: 3),
                  ),
                ),
                ListTile(
                  title: Text(
                    "پروفایل کاربری",
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {},
                ),
                const Divider(color: SolidColors.dividerColor),
                ListTile(
                  title: Text(
                    "درباره تک‌بلاگ",
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {},
                ),
                const Divider(color: SolidColors.dividerColor),
                ListTile(
                  title: Text(
                    "اشتراک گذاری تک بلاگ",
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () async{
                    await SharePlus.instance.share(ShareParams(text: MyString.shareText));
                  },
                ),
                const Divider(color: SolidColors.dividerColor),
                ListTile(
                  title: Text(
                    "تک‌بلاگ در گیت هاب",
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {
                    myLaunchUrl(MyString.techBlogGithubUrl);
                  },
                ),
                const Divider(color: SolidColors.dividerColor),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: SolidColors.scafoldBg,
          title: //appbar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: Icon(Icons.menu, color: Colors.black),
              ),
              Assets.images.logo.image(height: size.height / 13.6),
              Icon(Icons.search, color: Colors.black),
            ],
          ),
        ),

        body: Stack(
          children: [
            Positioned.fill(
              child: Obx(() => IndexedStack(
                index: selectedPageIndex.value,
                children: [
                  HomeScreen(
                    size: size,
                    textTheme: textTheme,
                    bodyMargin: bodyMargin,
                  ), //0
                  ProfileScreen(
                    size: size,
                    textTheme: textTheme,
                    bodyMargin: bodyMargin,
                  ), //1
                ],
              ),)
            ),
            BottomNavigation(
              size: size,
              bodyMargin: bodyMargin,
              changeScreen: (int value) {
        
                  selectedPageIndex.value = value;
                
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
  });

  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      right: 0,
      left: 0,
      child: Container(
        height: size.height / 12.3,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: GradiantColors.bottemNavBackground,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
          child: Container(
            height: size.height / 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              gradient: LinearGradient(colors: GradiantColors.bottemNav),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () => changeScreen(0),
                  icon: ImageIcon(
                    Assets.icons.home.provider(),
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: ImageIcon(
                    Assets.icons.write.provider(),
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => changeScreen(1),
                  icon: ImageIcon(
                    Assets.icons.user.provider(),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
