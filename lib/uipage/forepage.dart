import 'package:flutter/material.dart';
import 'package:qr_code_demo/uipage/scanpage.dart';

class ForePage extends StatefulWidget {
  const ForePage({Key? key}) : super(key: key);

  @override
  State<ForePage> createState() => _ForePageState();
}

class _ForePageState extends State<ForePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Container(
          width: 350,
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            boxShadow: [
              BoxShadow(
                  color:  Color(0x54e1e1e1),
                  blurRadius: 20
              ),
            ],
            color: Color(0x54e1e1e1),
          ),

          child: Center(
            child: InkWell(
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanPage()));
              },
              child: Container(
                width: 250,
                height: 250,
                padding: EdgeInsets.all(20),
                child: ImageIcon(

                  AssetImage('assets/scan.png'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
