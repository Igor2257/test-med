part of '../header.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.person,
          color: AppColors.dark,
        ),
        label: Text(
          "Sing in",
          style: TextStyle(color: AppColors.dark),
        ),
      ),
    );
  }
}
