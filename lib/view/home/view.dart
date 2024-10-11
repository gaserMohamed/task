import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/core/unit/app_assets.dart';
import 'package:tasky/core/unit/app_strings.dart';
import 'package:tasky/core/widget/app_image.dart';
import 'package:tasky/core/widget/app_menu.dart';
import 'package:tasky/feature/home/tasks/bloc.dart';

import '../../core/logic/helper_methods.dart';
import '../../core/unit/routes.dart';
import '../../core/widget/shimmer.dart';
part 'app_bar.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  TaskType taskType = TaskType.all;
  Color color = const Color.fromRGBO(240, 236, 255, 1);
  late final TasksBloc bloc;
  int page=1;
  bool isLoading = false;
  bool isRefrashed = false;


  final List<TaskType> tasks = [
    TaskType.all,
    TaskType.finished,
    TaskType.waiting,
    TaskType.inpogress,
  ];

  @override
  void initState() {
    bloc = TasksBloc();
    bloc.add(GetTasksEvent(
      taskType,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: const _HomeAppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 22.0.h,horizontal: 12.w),
          child: Stack(
            children: [
              Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      DataString.myTasks,
                      textAlign: TextAlign.start,
                                style: TextStyle(
                        fontSize: 16.sp,

                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Task Type Selector
                  SizedBox(
                    height: 40.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        tasks.length,
                            (index) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24.r),
                            child: FilledButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  taskType == tasks[index]
                                      ? Theme.of(context).primaryColor
                                      : color,
                                ),
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.all(4.r),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  taskType = tasks[index];
                                  bloc.add(GetTasksEvent(
                                    taskType,
                                  ));
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                child: Text(
                                  tasks[index].toString().split('.').last.toUpperCase(),
                                  style: TextStyle(
                                    color:                                   taskType == tasks[index]?
                                    Colors.white:const Color.fromRGBO(124, 124, 128, 1),
                                    fontWeight:   taskType == tasks[index]?FontWeight.w700:FontWeight.w400,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        page = 1;
                        isRefrashed=true;

                        bloc.add(GetTasksEvent(taskType, page: page));
                      },
                      color: Theme.of(context).primaryColor,
                      child: BlocConsumer(
                        listener: (context, state) {
if(state is TasksLoadingState)
  {
    isLoading=true;
  }else{
  isLoading=false;

}
                        },
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is TasksLoadingState) {
                            return const ShimmerList();
                          }
                          if (state is TasksFailedState) {
                            return const Center(
                              child: Text("خطأ في الاتصال"),
                            );
                          }
                          if (state is TasksSuccessState) {
                            return NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent&&!state.isAllLoaded) {
                                  isLoading = true;

                                  Future.delayed(const Duration(milliseconds: 300), () {
                                    page++;
                                    print("page: $page");
                                    print(!state.isAllLoaded);

                                    bloc.add(GetTasksEvent(taskType, page: page, allTask: state.model));

                                    isLoading = false;
                                  });
                                  return true;
                                }
                                return false;
                              },
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.model.length+1,
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                itemBuilder: (context, index) {
                                  if(state.model.length==index){
                                    return SizedBox(
                                      height: state.isAllLoaded?16.h:100.h,
                                      child:state.isAllLoaded||state.model.length<=9?null: const Center(child: CircularProgressIndicator()),
                                    );
                                  }

                                  return GestureDetector(
                                    onTap: (){
GoRouter.of(context).go(AppRouter.rTaskDetails,extra: state.model[index]);
                                    },
                                    child: SizedBox(
                                      height: 100.h,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.symmetric(vertical: 8.0.h),
                                            child: AppImage(
                                              path: state.model[index].image,
                                              fit: BoxFit.cover,
                                              width: 64.w,
                                              height: 64.h,
                                            ),
                                          ),
                                          SizedBox(width: 12.w),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 28.h,
                                                width: 236.w,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      state.model[index].title,
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.w700,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const Spacer(),
                                                    Container(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 6.w,
                                                            vertical: 2.h),
                                                        decoration: BoxDecoration(
                                                          color: state.model[index]
                                                              .taskTypeColor,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                        ),
                                                        child: Text(
                                                          state.model[index].status??'',
                                                          style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500,
                                                            color: state.model[index]
                                                                .taskTypeFontColor,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              SizedBox(
                                                width: 236.w,
                                                child: Text(
                                                  state.model[index].desc,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color(0xff24252C),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              SizedBox(
                                                  height: 18.h,
                                                  width: 236.w,
                                                  child: Row(
                                                    children: [
                                                      AppImage(
                                                        path: DataAssets.flag,
                                                        fit: BoxFit.scaleDown,
                                                        width: 16.w,
                                                        height: 16.h,
                                                        color: state.model[index]
                                                            .taskPriorityFontColor,
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Text(
                                                        state.model[index].priority??'',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color: state.model[index]
                                                              .taskPriorityFontColor,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Text(
                                                        state.model[index].createdAt,
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w400,
                                                          color:
                                                          const Color(0xff24252C),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                          const Spacer(),
                                          AppMenu(
                                            scale: .8,
                                            taskModel: state.model[index],
                                            onTapDeleted: (){
                                              setState(() {
                                                state.model.removeAt(index);
                                              });

                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ),
                ],
              ),
              PositionedDirectional(
                end: 32.w,
                bottom: 110.h,
                child: GestureDetector(
                  onTap: (){
                    GoRouter.of(context).go(AppRouter.rBarcode);

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(24.r),
                      color: const Color(0xffEBE5FF),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 32,
                          offset: const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    width: 50.r,
                    height: 50.r,
                    child: const AppImage(
                      path: DataAssets.scan,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                end: 24.w,
                bottom: 32.h,
                child: GestureDetector(
                  onTap: (){
                    GoRouter.of(context).go(AppRouter.rAdd,extra: {'fromEdit': false, 'taskModel': null});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(32.r),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.34),
                          blurRadius: 32,
                          offset: const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    width: 64.r,
                    height: 64.r,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 32.r,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}