import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CardMenuWidget extends StatelessWidget {
  final void Function()? onTap;
  final dynamic path;
  final String title;
  const CardMenuWidget({super.key, this.onTap, required this.path, required this.title})
      : assert(path is String || path is IconData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        margin: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
        decoration: BoxDecoration(
          color: blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            if (path is String)
              Image.asset(
                path as String,
                height: 12.5.h,
              )
            else
              Icon(path as IconData, size: 12.5.h, color: blueIcon),
            TextWidget(title, fontWeight: FontWeight.bold)
          ],
        ),
      ),
    );
  }
}
