import 'package:electro_app_team/cubits/profile/profile_cubit.dart';
import 'package:electro_app_team/cubits/profile/profile_state.dart';
import 'package:electro_app_team/models/profile_model.dart';
import 'package:electro_app_team/providers/language_provider.dart';
import 'package:electro_app_team/providers/theme_provider.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:electro_app_team/widgets/user_account_details.dart';
import 'package:electro_app_team/widgets/user_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:electro_app_team/utils/shared_perefrences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const String routeName = 'ProfileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetchProfile();
  }

  void _loadTokenAndFetchProfile() async {
    String? token = await StorageService().getToken();
    if (token != null) {
      BlocProvider.of<ProfileCubit>(context).fetchProfile(token);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token not found. Please log in again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: TextStyle(color: AppColors.darkBlueColor, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            ProfileResponse? profile;

            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is ProfileLoaded) {
              profile = state.profileResponse!;
              print(profile.user.name);
            }

            if (profile == null) {
              return const Center(child: Text("No profile data available"));
            }

            return Column(
              children: [
                UserDetails(
                  name: profile!.user.name,
                  email: profile!.user.email,
                ),
                UserAccountDetails(
                  labelText: AppLocalizations.of(context)!.name,
                  initialText: profile!.user.name,
                ),
                UserAccountDetails(
                  labelText: AppLocalizations.of(context)!.email,
                  initialText: profile!.user.email,
                ),
                UserAccountDetails(
                  labelText: AppLocalizations.of(context)!.phone_number,
                  initialText: profile!.user.phone,
                ),
                UserAccountDetails(
                  labelText: AppLocalizations.of(context)!.address,
                  initialText: profile!.user.address,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
