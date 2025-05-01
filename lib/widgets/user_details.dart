import 'package:electro_app_team/widgets/user_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:electro_app_team/providers/theme_provider.dart';

class UserDetails extends StatelessWidget {
  final String name;
  final String email;

  const UserDetails({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<ThemeProvider>(context);

    // تحديد الألوان حسب الثيم الحالي
    Color titleColor =
        themeProvider.currentTheme == ThemeMode.light
            ? AppColors.darkBlueColor
            : AppColors.whiteColor;

    Color subtitleColor =
        themeProvider.currentTheme == ThemeMode.light
            ? AppColors.blackColor
            : AppColors.whiteColor.withOpacity(0.7);

    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppLocalizations.of(context)!.welcome}, $name',
                style: TextStyle(color: titleColor, fontSize: 20),
              ),
              Text(email, style: TextStyle(color: subtitleColor, fontSize: 14)),
            ],
          ),
        ),
        const Spacer(),
        const UserCircleimage(),
      ],
    );
  }
}
