import 'package:electro_app_team/cubits/profile%20data/get_profile_data_cubit.dart';
import 'package:electro_app_team/cubits/profile%20data/get_profile_data_state.dart';
import 'package:electro_app_team/models/profile_model.dart';
import 'package:electro_app_team/providers/language_provider.dart';
import 'package:electro_app_team/providers/theme_provider.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:electro_app_team/widgets/user_account_details.dart';
import 'package:electro_app_team/widgets/user_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int selectedIndex = 0;
  var width;
  var height;
  @override
  void initState() {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2ODAxMTIzN2E1NGVkNGExYTYyZjM2MTQiLCJlbWFpbCI6ImFuYTYwZG9kYUBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsImlhdCI6MTc0NTMwMzU0Mn0.ceAWk_n1OWRIf39_Q8BCqh-YUsBNon05Txjf9EAddf4";
    super.initState();
    BlocProvider.of<GetProfileDataCubit>(context).getProfileData(token);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.darkBlueColor, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: BlocBuilder<GetProfileDataCubit, ProfileDataState>(
          builder: (context, state) {
            ProfileModel? profile;
            if (state is ProfileDataLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileDataFailed) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is ProfileDataSuccess) {
              profile = state.profileModel!;
            }
            return Column(
              children: [
                UserDetails(),
                // const SizedBox(height: 10),
                UserAccountDetails(
                  labelText: "Your full name",
                  initialText: profile!.name,
                ),
                // const SizedBox(height: 5),
                UserAccountDetails(
                  labelText: "Your email",
                  initialText: profile!.email,
                ),
                // const SizedBox(height: 5),
                UserAccountDetails(
                  labelText: "Your mobile number",
                  initialText: profile!.mobileNumber,
                ),
                // const SizedBox(height: 5),
                UserAccountDetails(
                  labelText: "Your address",
                  initialText: profile!.address,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
