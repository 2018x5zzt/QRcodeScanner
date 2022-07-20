import 'package:flutter/material.dart';
import 'package:qr_code_demo/globalvalue/globalval.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  var itemCount = 0;
  ScrollController _controller = ScrollController();
  @override
  void initState(){
    super.initState();
    itemCount= resultList.length;

  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: resultList.isNotEmpty ? ListView.builder(
          itemCount: itemCount,
          controller: _controller,
          itemBuilder: (context,i){
            return Container(
              width: width,
              height: 230,
              padding: const EdgeInsets.all(10),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: const Color(0xc8f1eded),
                  ),
                  child: GestureDetector(
                    onTap: (){print(resultList[i]);},
                      child: Row(children: <Widget>[
                        const SizedBox(width: 20,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: 20,),
                            Text('资产卡片编号: '+resultList[i]['资产卡片编号']),
                            Text('资产名称: '+resultList[i]['资产名称']),
                            Text('资产分类: '+resultList[i]['资产分类']),
                            Text('生产厂家: '+resultList[i]['生产厂家']),
                            Text('设备规格/型号: '+resultList[i]['设备规格/型号']),
                            Text('具体保管部门: '+resultList[i]['具体保管部门']),
                            Text('座落位置或存放地点: '+resultList[i]['座落位置或存放地点']),
                            Text('实验室分类: '+resultList[i]['实验室分类']),
                            Text('设备编码: '+resultList[i]['设备编码']),
                          ],)
                      ],)


                  )
              ),
            );
          }
      ) :
      Center(child: Text('暂无数据！'),),
    );
  }
}
