import 'package:flutter/material.dart';
import 'package:clc/model/Tensorflow.dart';
import 'package:clc/model/pytorch.dart';
import 'package:sidebarx/sidebarx.dart';

Pytorch pytorch=Pytorch();
Tensorflow tensorflow=Tensorflow();

void main(){
  print('object');
  runApp(const CnnCalc());
}

class CnnCalc extends StatelessWidget {
  const CnnCalc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blueGrey,
      ),
      home: DefaultTabController(
        // 탭의 수 설정
        length: 2,
        child: Scaffold(
          appBar: AppBar(

            title: const Text('Cnn Calculator',style: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.black54
            ),),
            // TabBar 구현. 각 컨텐트를 호출할 탭들을 등록
            bottom: const TabBar(
              tabs: [
                Tab(child: Text('Pytorch'),),
                Tab(child: Text('Tensorflow'),),
              ],
            ),
          ),
          // TabVarView 구현. 각 탭에 해당하는 컨텐트 구성
          body: TabBarView(
            children: [

              pytorch,
              tensorflow,
            ],
          ),
        ),
      ),
    );
  }
}