import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/core/unit/app_assets.dart';
import 'package:tasky/core/widget/app_image.dart';
import 'package:tasky/feature/home/tasks/model.dart';

import '../../core/unit/routes.dart';
import '../../core/widget/app_container.dart';
import '../../core/widget/app_menu.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.taskModel});

  final TaskModel taskModel;

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
            fit: BoxFit.scaleDown,
            color: Colors.black,
            height: 25.h,
          ),
        ),
        title: Text(
          "Task Details",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          AppMenu(
            scale: .8,
            taskModel: taskModel,
            onTapDeleted: () {
              GoRouter.of(context).go(AppRouter.rHome);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            AppImage(
              path: taskModel.image,
              height: 0.25.sh,
              fit: BoxFit.scaleDown,
            ),
            SizedBox(height: 20.h),
            Text(
              taskModel.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              taskModel.desc,
              style: TextStyle(
                color: const Color(0xff24252C).withOpacity(.6),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 15.h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: const Color.fromRGBO(240, 236, 255, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("End Date",
                            style: TextStyle(
                              color: const Color.fromRGBO(110, 106, 124, 1),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            )),
                        SizedBox(height: 5.h),
                        Text(taskModel.createdAt.split("T")[0],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            )),
                      ],
                    ),
                  ),
                  AppImage(
                    path: DataAssets.calendar,
                    fit: BoxFit.scaleDown,
                    height: 30.h,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            AppContainer(
              text: taskModel.status??'',
            ),
            SizedBox(height: 10.h),
            AppContainer(
              withIcon: true,
              text: "${taskModel.priority} Priority",
            ),
            SizedBox(height: 30.h),
            Center(
              child: QrImageView(
                data: taskModel.sId,
                size: 0.5.sh,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
