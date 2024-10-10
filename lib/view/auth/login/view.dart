import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:tasky/core/widget/app_input.dart';
import 'package:tasky/feature/auth/login/bloc.dart';

import '../../../core/logic/get_it.dart';
import '../../../core/unit/app_assets.dart';
import '../../../core/unit/app_strings.dart';
import '../../../core/unit/routes.dart';
import '../../../core/widget/app_button.dart';
import '../../../core/widget/app_image.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();

  final passwordController = TextEditingController();
   String? countryCode ;
  late final LoginBloc bloc;

  @override
  initState() {
    bloc = getIt<LoginBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formKey,
      child: ListView(
        children: [
          SizedBox(
            height: 482.h,
            width: double.infinity,
            child: Stack(
              children: [
                PositionedDirectional(
                  height: 482.h,
                  width: 408.w,
                  start: -15,
                  child: Image.asset(
                    height: 482.h,
                    width: 408.w,
                    DataAssets.imagesIntro,
                    fit: BoxFit.fill,
                  ),
                ),
                PositionedDirectional(
                  top: 432.h,
                  width: 1.sw,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Text(
                      DataString.login,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff24252C),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CountryPhone(
            phoneController: phoneController,
            onChanged: (PhoneNumber? number) {
              countryCode = number!.countryCode;
            },
          ),
          AppInput(
            label: DataString.password,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return DataString.empty(DataString.password);
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            controller: passwordController,
            isPassword: true,
            isEnable: true,
            maxLine: 1,
          ),
          SizedBox(
            height: 24.h,
          ),
          BlocConsumer(
            bloc: bloc,
            listener: (BuildContext context, state) {
              if (state is LoginSuccessState) {
                GoRouter.of(context).go(AppRouter.rHome);
              }
            },
            builder: (BuildContext context, state) {
              return AppButton(
                onPressed: () {
                  if (formKey.currentState!.validate() &&
                      phoneController.text.isNotEmpty) {
                    bloc.add(LoginEvent(
                      phone: '$countryCode${phoneController.text}',
                      password: passwordController.text,
                    ));
                    print('Login');
                  }
                },
                isLoading: state is LoginLoadingState,
                text: DataString.signIn,
                icon: SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: const AppImage(
                      path: DataAssets.arrow,
                      fit: BoxFit.scaleDown,
                    )),
              );
            },
          ),
          SizedBox(
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DataString.noAccount,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff7F7F7F),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).go(AppRouter.rSignUp);
                  },
                  child: Text(
                    DataString.signUp,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
        ],
      ),
    ));
  }
}
