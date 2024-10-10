import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tasky/core/unit/app_assets.dart';
import 'package:tasky/core/widget/app_image.dart';
import 'package:tasky/feature/home/get_one_task/bloc.dart';
import '../../../core/unit/routes.dart';

class QrScanView extends StatefulWidget {
  const QrScanView({super.key});

  @override
  State<QrScanView> createState() => _QrScanViewState();
}

class _QrScanViewState extends State<QrScanView> {
  BarcodeCapture? result;
  MobileScannerController scannerController = MobileScannerController();
final     bloc = TasksOneTaskBloc();

  @override
  void dispose() {
    scannerController.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          buildQrScanner(context),
          _buildOverlay(context),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => GoRouter.of(context).go(AppRouter.rHome),
        icon: AppImage(
          path: DataAssets.arrow,
          fit: BoxFit.scaleDown,
          height: 25.h,
          color: Colors.black,
        ),
      ),
      title: Text(
        "Scan QR",
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget buildQrScanner(BuildContext context) {
    return BlocConsumer(
      bloc: bloc,
      listener: (context,state){
        if(state is TaskOneTaskSuccessState){
          GoRouter.of(context).go(AppRouter.rTaskDetails,extra: state.taskModel);

        }
      },
      builder:(context,state){
    return    MobileScanner(
          controller: scannerController,
          onDetect: (BarcodeCapture capture) {
            final String? code = capture.barcodes.first.rawValue;
            if (code != null) {
              setState(() {
                result = capture;
bloc.add(TaskOneTaskEvent(code));
              });
            }
          },
        );
      }

    );
  }


  // Custom overlay to mimic the previous 'overlay' property
  Widget _buildOverlay(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 0.7.sw,
        height: 0.7.sw,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 10.w,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }
}
