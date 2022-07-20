import 'package:flutter/material.dart';
class NewUi extends StatefulWidget {
  final data;
  const NewUi({Key? key,this.data}) : super(key: key);

  @override
  State<NewUi> createState() => _NewUiState(data);
}

class _NewUiState extends State<NewUi> {
  Map<String,dynamic> res = Map();
  _NewUiState(this.res);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('扫描结果'),
      ),

      body: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          const SizedBox(height: 20,),
          Text('资产卡片编号: '+res['资产卡片编号']),
          Text('资产名称: '+res['资产名称']),
          Text('资产分类: '+res['资产分类']),
          Text('生产厂家: '+res['生产厂家']),
          Text('设备规格/型号: '+res['设备规格/型号']),
          Text('具体保管部门: '+res['具体保管部门']),
          Text('座落位置或存放地点: '+res['座落位置或存放地点']),
          Text('实验室分类: '+res['实验室分类']),
          Text('设备编码: '+res['设备编码']),
        ],),
      ),
    );
  }
}
