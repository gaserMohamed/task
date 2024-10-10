import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:popover/popover.dart';
import 'package:tasky/core/unit/routes.dart';
import 'package:tasky/feature/home/delete_task/bloc.dart';
import 'package:tasky/feature/home/tasks/model.dart';
import '../unit/app_assets.dart';
import 'app_image.dart';

class AppMenu extends StatefulWidget {
 final double scale;
 final TaskModel taskModel;
 final void Function()? onTapDeleted;

  const AppMenu({super.key,this.scale=1.0,required this.taskModel,required this.onTapDeleted});

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
 late final TasksDeletedBloc bloc;
@override
  void initState() {
    bloc = TasksDeletedBloc();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return                                   Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          print('*' * 400);
          showPopover(
onPop: (){},


            context: context,
            radius: 12.r,

            arrowDyOffset: 4.h* widget.scale,
constraints: BoxConstraints(
  minWidth: 100.w*widget.scale,
  maxWidth: 100.w*widget.scale,
  minHeight: 100.h*widget.scale,
  maxHeight: 100.h*widget.scale,

),

            shadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.19),
                blurRadius: 16,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
arrowDxOffset: 60.w*widget.scale,
            contentDxOffset: -180.w*widget.scale,
            bodyBuilder: (context) => Transform.scale(
              scale: widget.scale,
              child: Container(
                  height: 85.h*widget.scale,
                  width: 85.w*widget.scale,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w*widget.scale,
                      vertical: 8.h*widget.scale),
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (
                        ){
                          GoRouter.of(context).go(AppRouter.rAdd,extra: {'fromEdit': true, 'taskModel': widget.taskModel});

                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: 16.sp*widget.scale,
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          bloc.add(
                              TaskDeletedEvent(
                                   widget.taskModel.sId));
                          widget.onTapDeleted;

                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 16.sp*widget.scale,
                            fontWeight:
                            FontWeight.w500,
                            color: const Color(
                                0xffFF7D53),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            direction: PopoverDirection.bottom,
            // contentDxOffset:-300.w,
            transition: PopoverTransition.scale,
            width: 86.w*widget.scale,
            height: 100.h*widget.scale,
            // arrowHeight: 0.h*scale,
            arrowWidth: -18.w*widget.scale,
          );
        },
        child: const AppImage(
            path: DataAssets.edit,
            fit: BoxFit.scaleDown),
      );
    });
  }
}
