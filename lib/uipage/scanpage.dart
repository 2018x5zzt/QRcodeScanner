import 'dart:convert';
import 'dart:developer';


import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_demo/uipage/newui.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:qr_code_demo/globalvalue/globalval.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Map<String,dynamic> resultZzt=Map();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    //controller!.pauseCamera();
    controller!.resumeCamera();
  }
  Future<void> getData(String? res) async{
    String url = res!;
    Dio dio = Dio();
    Response response = await dio.get(url);
    Map<String,dynamic> data = jsonDecode(response.data);
    print(data);
    resultZzt=data;
    //print(resultZzt);
    resultList.add(data);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(100, 7, 182, 95),
        title: Text('识别二维码'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    GestureDetector(
                      onTap: (){
                        resultZzt.clear();
                        getData(result!.code.toString()).then((value) {
                          //Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewUi(data: resultZzt,)));
                          showOkCancelAlertDialog(
                            title: '二维码结果',
                            message: '资产卡片编号: '+resultZzt["资产卡片编号"]+'\n资产名称: '+resultZzt["资产名称"]
                                +'\n资产分类: '+resultZzt["资产分类"]+'\n生产厂家: '+resultZzt["生产厂家"]
                                +'\n设备规格/型号: '+resultZzt["设备规格/型号"]+'\n具体保管部门: '+resultZzt["具体保管部门"]
                                +'\n座落位置或存放地点: '+resultZzt["座落位置或存放地点"]+'\n实验室分类: '+resultZzt["实验室分类"]
                                +'\n设备编码: '+resultZzt["设备编码"],
                            context: context,
                          );
                        });

                        //resultList.add(result!.code.toString());

                      },
                      child: Text(
                        '已扫描到结果，类型：${describeEnum(result!.format)}，点击查看并保存'
                      ),
                    )

                        //'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('扫描一个二维码'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(100, 7, 182, 95),
                                )
                            ),
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('闪光灯: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(100, 7, 182, 95),
                                )
                            ),
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      '摄像头 ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(100, 7, 182, 95),
                            )
                          ),
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('暂停摄像头',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(100, 7, 182, 95),
                              )
                          ),
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('启动摄像头',
                              style: TextStyle(fontSize: 16)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
