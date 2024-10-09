import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled1/utils/enums/screen_elements.dart';
import 'package:untitled1/utils/styles/colors/app_colors.dart';

class ScreenElement extends StatelessWidget {
  const ScreenElement(
      {super.key, required this.screenElements, required this.onTap});

  final ScreenElements screenElements;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              spreadRadius: 4,
              color: Colors.black12,

            )
          ],
          border: Border.all(color: Theme.of(context).scaffoldBackgroundColor,width: 4),
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              screenElements.imagePath,
              theme: SvgTheme(currentColor: AppColors.dark),
              color: AppColors.dark,
              height: size.width/12,
            ),
            const SizedBox(height: 16,),
            Text(
              screenElements.name,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColors.dark),
            ),
          ],
        ),
      ),
    );
  }
}
