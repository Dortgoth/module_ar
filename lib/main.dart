import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MaterialApp(home: QRScanPage()));

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String currentUrl = '';

  //@override
  //void initState() {
  //  super.initState();
  //  requestLocationPermission();
  //}

  void _launchURL(String? url) {
    if (url != null) {
      setState(() {
        currentUrl = url;
      });
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: currentUrl.isEmpty
                ? QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            )
                : InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(currentUrl)),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: currentUrl.isEmpty
                  ? Text('Scan a QR code')
                  : ElevatedButton(
                onPressed: () => setState(() => currentUrl = ''),
                child: Text('Back to Scanner'),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      await controller.pauseCamera();
      _launchURL(scanData.code); // This now passes a nullable String
    });
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Location permission granted
    } else if (status.isDenied) {
      // Location permission denied
    } else if (status.isPermanentlyDenied) {
      // The user opted not to grant permission and should be informed that they need to manually enable it in the app settings.
      openAppSettings();
    }
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
