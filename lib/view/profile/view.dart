import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/unit/app_assets.dart';
import 'package:tasky/core/unit/routes.dart';
import 'package:tasky/core/widget/app_image.dart';

import '../../feature/home/profile/bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
late  final ProfileBloc bloc ;
  @override
  void initState() {
    bloc = ProfileBloc();
    bloc.add(ProfileEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).go(AppRouter.rHome);
          },
          icon: AppImage(
            path: DataAssets.arrow,
            color: Colors.black,
            height: 25.h,
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text("Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            )),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is ProfileFailedState) {
            return Center(
              child: Text(state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromRGBO(215, 15, 23, 1),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  )),
            );
          } else if (state is ProfileSuccessState) {
            return Padding(
              padding: EdgeInsets.all( 20.w),
              child: ListView(
                children: [
                  ProfileItem(
                    title: "Name",
                    body: state.userModel.displayName,
                  ),
                  ProfileItem(
                    title: "Phone",
                    body: state.userModel.username,
                    withCody: true,
                  ),
                  ProfileItem(
                    title: "Level",
                    body: state.userModel.level,
                  ),
                  ProfileItem(
                    title: "Years of experience",
                    body: "${state.userModel.experienceYears} years",
                  ),
                  ProfileItem(
                    title: "Location",
                    body: state.userModel.address,
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox(
              child: Text("error"),
            );
          }
        },
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.body,
    this.withCody = false,
  });

  final String title, body;
  final bool withCody;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: const Color.fromRGBO(245, 245, 245, 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    color: const Color.fromRGBO(47, 47, 47, 0.4),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  body,
                  style: TextStyle(
                    color: const Color.fromRGBO(47, 47, 47, 0.6),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
          withCody
              ? IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: body));
                  },
                  icon: AppImage(
                    path: DataAssets.copy,
                    color: Theme.of(context).primaryColor,
                    height: 25.h,
                    fit: BoxFit.scaleDown,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
