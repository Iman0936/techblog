import 'package:flutter/material.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/component/my_colors.dart';
import 'package:techblog/component/my_component.dart';
import 'package:techblog/component/my_string.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  });

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: Assets.images.avatar.provider(), height: 100),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  Assets.icons.bluepen.provider(),
                  color: SolidColors.seeMore,
                ),
                SizedBox(width: 8),
                Text(MyString.imageProfileEdit, style: textTheme.displaySmall),
              ],
            ),
            const SizedBox(height: 60),
            Text("ایمان خراسانی", style: textTheme.headlineMedium),
            Text("imankhorasani0936@gmail.com", style: textTheme.headlineMedium),
            const SizedBox(height: 40),
            TechDivider(size: size),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                child: Center(
                  child: Text(
                    MyString.myFavBlog,
                    style: textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
            TechDivider(size: size),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                child: Center(
                  child: Text(
                    MyString.myFavPodcast,
                    style: textTheme.headlineMedium,
                  ),
                ),
              ),
            ),
            TechDivider(size: size),
            InkWell(
              onTap: () {},
              splashColor: SolidColors.primaryColor,
              child: SizedBox(
                height: 45,
                child: Center(
                  child: Text(MyString.logOut, style: textTheme.headlineMedium),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
