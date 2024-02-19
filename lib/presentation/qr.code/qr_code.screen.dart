import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import '../station.details/controllers/station_details.controller.dart';
import 'controllers/qr_code.controller.dart';

class QrCodeScreen extends GetView<QrCodeController> {
  QrCodeScreen({Key? key}) : super(key: key);
  final MobileScannerController cameraController =
      MobileScannerController(returnImage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('QrCodeScreen'),
          centerTitle: true,
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            // IconButton(
            //   color: Colors.white,
            //   icon: ValueListenableBuilder(
            //     valueListenable: cameraController.cameraFacingState,
            //     builder: (context, state, child) {
            //       switch (state as CameraFacing) {
            //         case CameraFacing.front:
            //           return const Icon(Icons.camera_front);
            //         case CameraFacing.back:
            //           return const Icon(Icons.camera_rear);
            //       }
            //     },
            //   ),
            //   iconSize: 32.0,
            //   onPressed: () => cameraController.switchCamera(),
            // ),
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
              fit: BoxFit.cover,
              controller: cameraController,
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;
                // for (final barcode in barcodes) {
                //   debugPrint('Barcode found! ${barcode.rawValue}');
                //   // CustomSnackBar.showSuccessSnackBar(
                //   //     "Barcode found!", "${barcode.rawValue}");
                // }
                print("barcode details ${barcodes.first.rawValue}");
                if (!Get.isRegistered<StationDetailsController>()) {
                  Get.lazyPut(() => StationDetailsController());
                  NavigationUtils().callChargingSessionDetailsFromQRCOde(
                      connectorId: 3, fromQrCode: 'fromQrCode');
                }

                // if (image != null) {
                //   showDialog(
                //     context: context,
                //     builder: (context) => Image(image: MemoryImage(image)),
                //   );

                // } else {
                //   print("image null");
                // }
              },
            ),
            // Container(
            //   child: Center(
            //     child:
            //         RoundedRectangleButton(onPressed: () {}, text: 'Proceed'),
            //   ),
            // )
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: RichText(
                    text: TextSpan(
                        text: 'Unable to scan QR code? ',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                        children: [
                      TextSpan(
                          text: 'Click here',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('tapped');
                              NavigationUtils().callScreenYetToBeDone();
                            },
                          style: TextStyle(color: AppColors.greenColor))
                    ])),
              ),
            )
          ],
        ));
  }
}
