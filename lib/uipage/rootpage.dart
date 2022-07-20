import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_demo/uipage/resultpage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'forepage.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  DateTime? lastPopTime;
  int currentIndex=0;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }
  final pages = [ForePage(),ResultPage()];
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.zoom_out_map),
      label: "扫描",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.done),
      label: "结果",
    ),
  ];
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(100, 7, 182, 95),
          title: const Text('二维码识别小程序'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavItems,
          currentIndex: currentIndex,
          onTap: (index) {
            _changePage(index);
          },
        ),
        body: pages[currentIndex]
      ),
      onWillPop: () async {
        if (lastPopTime == null ||
            DateTime.now().difference(lastPopTime!) >
                const Duration(seconds: 2)) {
          lastPopTime = DateTime.now();
          print('退出');
          Fluttertoast.showToast(msg: '再按一次退出!');
          return false;
        } else {
          lastPopTime = DateTime.now();
          return await SystemChannels.platform
              .invokeMethod('SystemNavigator.pop');
        }
      },
    );
  }
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
