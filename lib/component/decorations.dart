import 'package:flutter/widgets.dart';
import 'package:techblog/component/constant/my_colors.dart';

class MyDecorations {
  MyDecorations._();

  static BoxDecoration mainGradiant = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(18)),
    gradient: LinearGradient(colors: GradiantColors.bottemNav),
  );
}
