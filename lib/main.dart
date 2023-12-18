import 'dart:io';

import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:url_launcher/url_launcher.dart';

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

  Future<void> openInChrome(String url) async {
    String chromeUrl;

    if (Platform.isAndroid) {
      chromeUrl = 'googlechrome://navigate?url=$url';
    } else if (Platform.isIOS) {
      chromeUrl = 'googlechrome://$url';
    } else {
      chromeUrl = url; // Fallback for other platforms
    }

    if (await canLaunch(chromeUrl)) {
      await launch(chromeUrl);
    } else {
      throw 'Could not launch $chromeUrl';
    }
  }

  void _launchURL(String? url) {
    if (url != null) {
      openInChrome(url);
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
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(currentUrl.isEmpty
                  ? 'Scan a QR code'
                  : 'URL Opened in Chrome'),
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

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }
}
