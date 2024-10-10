import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/core/unit/app_assets.dart';
import 'package:tasky/core/unit/routes.dart';
import 'package:tasky/core/widget/app_drop_button.dart';
import 'package:tasky/core/widget/app_image.dart';
import 'package:tasky/core/widget/app_input.dart';
import 'package:tasky/feature/home/tasks/model.dart';
import 'package:tasky/feature/home/upload_image/bloc.dart';
import '../../core/logic/helper_methods.dart';
import '../../feature/home/add_task/bloc.dart';

class AddTaskBody extends StatefulWidget {
  AddTaskBody({
    super.key,
    required this.fromEdit,
    required this.taskModel,
  });

  TaskModel? taskModel;
  final bool fromEdit;

  @override
  State<AddTaskBody> createState() => _AddTaskBodyState();
}

class _AddTaskBodyState extends State<AddTaskBody> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime? _dueDate;
  File? _image;
  final _uploadImageBloc = UploadImageBloc();
  late TasksAddedBloc _tasksAddedBloc;
  String priority = '';
  String status = '';

  @override
  void initState() {
    super.initState();
    _tasksAddedBloc = TasksAddedBloc(uploadImageBloc: _uploadImageBloc);
    if (widget.fromEdit && widget.taskModel != null) {
      titleController.text = widget.taskModel!.title;
      descriptionController.text = widget.taskModel!.desc;
      _image = File(widget.taskModel?.image ?? "");
      _dueDate = widget.taskModel?.updatedAt != null
          ? DateTime.parse(widget.taskModel!.updatedAt)
          : null;
      priority = widget.taskModel?.priority ?? "Choose experience Level";
      status = widget.taskModel?.status ?? "Choose Task status";
    } else {
      widget.taskModel = TaskModel(
        title: '',
        desc: '',
        priority: "Choose experience Level",
        status: "Choose Task status",
        image: '',
        updatedAt: DateTime.now().toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => GoRouter.of(context).go(AppRouter.rHome),
          icon: AppImage(
            path: DataAssets.arrow,
            color: Colors.black,
            fit: BoxFit.scaleDown,
            height: 25.h,
          ),
        ),
        title: Text(
          widget.fromEdit ? "Edit Task" : "Add New Task",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _uploadImageBloc),
          BlocProvider(create: (context) => _tasksAddedBloc),
        ],
        child: BlocListener<TasksAddedBloc, TaskAddedState>(
          listener: (context, state) {
            if (state is TaskAddedSuccessState) {

              showMessage(message: "Task successfully added or edited.");
              GoRouter.of(context).go(AppRouter.rHome);
            } else if (state is TaskAddedFailedState) {
              showMessage(message: state.message);
            }
          },
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: BlocBuilder<UploadImageBloc, TaskUploadImageState>(
                      builder: (context, state) {
                        if (state is TaskUploadImageLoadingState) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator()),
                            ),
                          );
                        } else if (state is TaskUploadImageSuccessState) {
                          return AppImage(
                            path: state.image,
                            height: 0.3.sh,
                            fit: BoxFit.scaleDown,
                          );
                        } else {
                          return _image == null
                              ? const AppImage(
                                  path: DataAssets.img,
                                  fit: BoxFit.scaleDown,
                                )
                              : widget.fromEdit &&
                                      widget.taskModel?.image != null
                                  ? Image.network(
                                      widget.taskModel?.image ?? "",
                                      height: 0.3.sh,
                                      fit: BoxFit.scaleDown,
                                    )
                                  : Image.file(
                                      _image!,
                                      height: 0.3.sh,
                                      fit: BoxFit.scaleDown,
                                    );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 0.03.sh),
                  // Task Title Section
                  Text(
                    "Task Title",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Transform.scale(
                    scale: 1.1,
                    child: AppInput(
                      controller: titleController,
                      label: "Enter title here...",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter title";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 0.02.sh),
                  Text(
                    "Task Description",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 180.h,
                    child: Transform.scale(
                      scale: 1.1,
                      child: AppInput(
                        controller: descriptionController,
                        label: "Enter description here...",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter description";
                          }
                          return null;
                        },
                        maxLine: 10,
                        minLine: 8,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.02.sh),
                  Text(
                    "Priority",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xffBABABA).withOpacity(.2),
                      ),
                    ),
                    margin: EdgeInsets.zero,
                    child: AppDropButton(
                      isPriority: true,
                      text: priority,
                      onChange: (value) {
                        setState(() {
                          priority = value!;
                          widget.taskModel?.priority = priority;

                          print(
                              " widget.taskModel?.priority${widget.taskModel?.priority}");
                        });
                      },
                      fontColor: Theme.of(context).primaryColor,
                      color: const Color(0xffF0ECFF),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Status",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: const Color(0xffBABABA).withOpacity(.2),
                      ),
                    ),
                    margin: EdgeInsets.zero,
                    child: AppDropButton(
                      isState: true,
                      text: status,
                      onChange: (value) {
                        setState(() {
                          status = value ?? '';
                          widget.taskModel?.status = status;
                        });
                      },
                      fontColor: Theme.of(context).primaryColor,
                      color: const Color(0xffF0ECFF),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Due date",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: () => _selectDueDate(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _dueDate != null
                                      ? _dueDate!.toString().split(" ").first
                                      : "Choose due date...",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppImage(
                            path: DataAssets.calendar,
                            height: 30.h,
                            fit: BoxFit.scaleDown,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(top: 0.01.sh),
                    child: BlocBuilder<TasksAddedBloc, TaskAddedState>(

                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            if (widget.taskModel != null) {
                              widget.taskModel?.title = titleController.text;
                              widget.taskModel?.desc =
                                  descriptionController.text;
                              widget.taskModel?.priority = priority;
                              widget.taskModel?.status = status;
                              widget.taskModel?.image = _image?.path ??
                                  '';
                              widget.taskModel?.updatedAt = DateTime.now()
                                  .toString();
                              if (titleController.text.isNotEmpty &&
                                  descriptionController.text.isNotEmpty) {
                                _tasksAddedBloc.add(TaskAddedEvent(
                                    widget.taskModel!,
                                    _image,
                                    widget
                                        .fromEdit));         } else {
                                showMessage(
                                    message:
                                        'Title and Description cannot be empty.');
                              }
                            }
                          },
                          child: Container(
                            height: 50.h,
                            width: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: state is TaskAddedLoadingState
                                ?  SizedBox(height: 32.h,

                              width: 32.w,

                                  child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                )
                                : Text(
                                    widget.fromEdit
                                        ? 'Save Changes'
                                        : 'Add Task',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 0.1.sh),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _uploadImageBloc.add(TaskUploadImageEvent(_image!));
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final currentDate = DateTime.now(); // Get the current date
    final initialDate = _dueDate != null && _dueDate!.isAfter(currentDate)
        ? _dueDate!
        : currentDate; // Ensure initialDate is not before currentDate

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dueDate = pickedDate;
      });
    }
  }
}
