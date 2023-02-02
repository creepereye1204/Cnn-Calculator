import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:side_sheet/side_sheet.dart';

final logger=Logger(printer: PrettyPrinter());
List<Widget> Layers=[];
List<List<String>> Code=[];

dynamic Conv2d_Address;
dynamic Pooling_Address;
dynamic Linear_Address;
dynamic Trans2d_Address;



int In_channel=3;
int Out_channel=64;
int Kernel_size=3;
int Stride=1;
int Padding=1;
int Width=224;
int Height=224;
int Type=1;


void Result(Address,Choice){
  switch(Choice){
    case 'Conv2d':

      Width=(((Width+2*Padding-(Kernel_size-1)-1)~/Stride)+1);
      Height=(((Height+2*Padding-(Kernel_size-1)-1)~/Stride)+1);
      Layers.add(Text('('+Out_channel.toString()+','+Width.toString()+','+Height.toString()+')'));
      Code.add(['Cond2d',Out_channel.toString(),Kernel_size.toString(),Stride.toString(),Padding.toString(),Width.toString(),Height.toString()]);
      break;
    case 'Pooling':

      Width=(((Width+2*Padding-(Kernel_size-1)-1)~/Stride)+1);
      Height=(((Height+2*Padding-(Kernel_size-1)-1)~/Stride)+1);
      Layers.add(Text('('+Out_channel.toString()+','+Width.toString()+','+Height.toString()+')'));
      Code.add(['Pooling',Out_channel.toString(),Kernel_size.toString(),Stride.toString(),Padding.toString(),Width.toString(),Height.toString()]);
      break;
    case 'Linear':
      final Out_Result=Out_channel.toString();
      Layers.add(Text('Out_Channel:'+Out_Result));
      break;
    default:

      Width=(Width-1)*Stride-2*Padding+(Kernel_size-1)+1;
      Height=(Height-1)*Stride-2*Padding+(Kernel_size-1)+1;
      Layers.add(Text('('+Out_channel.toString()+','+Width.toString()+','+Height.toString()+')'));
      Code.add(['Trans2d',Out_channel.toString(),Kernel_size.toString(),Stride.toString(),Padding.toString(),Width.toString(),Height.toString()]);
      break;

  }



  Address.C();
}





class Conv2d{
  dynamic Address;
  dynamic width;
  dynamic height;

  int input_dim=0;
  int output_dim=0;

  int in_width_channels=0;
  int in_height_channels=0;
  int kernel_size=0;
  int stride=0;
  int padding=0;
  int width_output=0;
  int height_output=0;
  Conv2d(width,height,int input_dim,int output_dim,int in_width_channels,int in_height_channels,int kernel_size,int stride,int padding,Address){
    Conv2d_Address=this;
    this.Address=Address;
    this.width=width;
    this.height=height;

    this.input_dim=input_dim;
    this.output_dim=output_dim;

    this.in_width_channels=in_width_channels;
    this.in_height_channels=in_height_channels;
    this.kernel_size=kernel_size;
    this.stride=stride;
    this.padding=padding;

  }

  Widget Layer(){
    final String width_Result=(((this.in_width_channels+2*this.padding-(this.kernel_size-1)-1)~/this.stride)+1).toString();
    final String height_Result=(((this.in_height_channels+2*this.padding-(this.kernel_size-1)-1)~/this.stride)+1).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(

            width: this.width*0.5,
            child: Stack(
              children: [

                Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),

                    width: this.width*0.6,
                    height: this.height*0.03,
                    child: TextButton.icon(onPressed: null,label: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Conv2d',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                              fontSize: 20
                          ),),
                          SizedBox(width: 100,),
                          Text('out channel',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Out_channel.toString()),onChanged: (Text)=>{Out_channel=int.parse(Text),},),
                          ),
                          SizedBox(width: 10,),
                          Text('kernel size',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Kernel_size.toString()),onChanged: (Text)=>{Kernel_size=int.parse(Text)},),
                          ),
                          SizedBox(width: 10,),
                          Text('stride',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Stride.toString()),onChanged: (Text)=>{Stride=int.parse(Text)},),
                          ),
                          SizedBox(width: 10,),
                          Text('padding',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Padding.toString()),onChanged: (Text)=>{Padding=int.parse(Text)},),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey
                              ),
                              onPressed: () {
                                Result(Address,"Conv2d");


                              },

                              child: Icon(Icons.add,)
                          ),

                        ],
                      ),
                    ),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          backgroundColor: Colors.blue
                      ), icon: Icon(Icons.account_tree_rounded),
                    )
                )
              ],
            )
        ),

      ],
    );
  }

// String Code(){
//   fi
//   return '';
// }


}



class Pooling{
  dynamic Address;
  dynamic width;
  dynamic height;

  int input_dim=0;
  int output_dim=0;

  int in_width_channels=0;
  int in_height_channels=0;
  int kernel_size=0;
  int stride=0;
  int padding=0;
  int width_output=0;
  int height_output=0;
  Pooling(width,height,int input_dim,int output_dim,int in_width_channels,int in_height_channels,int kernel_size,int stride,int padding,Address){
    Pooling_Address=this;
    this.Address=Address;
    this.width=width;
    this.height=height;

    this.input_dim=input_dim;
    this.output_dim=output_dim;

    this.in_width_channels=in_width_channels;
    this.in_height_channels=in_height_channels;
    this.kernel_size=kernel_size;
    this.stride=stride;
    this.padding=padding;

  }

  Widget Layer(){
    final String width_Result=(((this.in_width_channels+2*this.padding-(this.kernel_size-1)-1)~/this.stride)+1).toString();
    final String height_Result=(((this.in_height_channels+2*this.padding-(this.kernel_size-1)-1)~/this.stride)+1).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(

            width: this.width*0.4,
            child: Stack(
              children: [

                Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),

                    width: this.width*0.6,
                    height: this.height*0.03,
                    child: TextButton.icon(onPressed: null,label: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Pooling',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                              fontSize: 20
                          ),),
                          SizedBox(width: 100,),
                          Text('kernel size',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Kernel_size.toString()),onChanged: (Text)=>{Kernel_size=int.parse(Text)},),
                          ),
                          SizedBox(width: 10,),
                          Text('stride',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Stride.toString()),onChanged: (Text)=>{Stride=int.parse(Text)},),
                          ),
                          SizedBox(width: 10,),
                          Text('padding',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Padding.toString()),onChanged: (Text)=>{Padding=int.parse(Text)},),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey
                              ),
                              onPressed: () {
                                Result(Address,"Pooling");
                              },

                              child: Icon(Icons.add,)
                          ),

                        ],
                      ),
                    ),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          backgroundColor: Colors.pinkAccent
                      ), icon: Icon(Icons.account_tree_rounded),
                    )
                )
              ],
            )
        ),

      ],
    );
  }

// String Code(){
//   fi
//   return '';
// }


}


class Linear{
  dynamic Address;
  dynamic width;
  dynamic height;

  int input_dim=0;
  int output_dim=0;

  int in_width_channels=0;
  int in_height_channels=0;
  int kernel_size=0;
  int stride=0;
  int padding=0;
  int width_output=0;
  int height_output=0;
  Linear(width,height,int input_dim,int output_dim,int in_width_channels,int in_height_channels,int kernel_size,int stride,int padding,Address){
    Linear_Address=this;
    this.Address=Address;
    this.width=width;
    this.height=height;

    this.input_dim=input_dim;
    this.output_dim=output_dim;

    this.in_width_channels=in_width_channels;
    this.in_height_channels=in_height_channels;
    this.kernel_size=kernel_size;
    this.stride=stride;
    this.padding=padding;

  }

  Widget Layer(){
    final String width_Result=(((this.in_width_channels+2*this.padding-(this.kernel_size-1)-1)~/this.stride)+1).toString();
    final String height_Result=(((this.in_height_channels+2*this.padding-(this.kernel_size-1)-1)~/this.stride)+1).toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(

            width: this.width*0.3,
            child: Stack(
              children: [

                Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),

                    width: this.width*0.8,
                    height: this.height*0.03,
                    child: TextButton.icon(onPressed: null,label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Linear',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                            fontSize: 20
                        ),),
                        SizedBox(width: 100,),
                        Text('out channel',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 18
                        ),),
                        SizedBox(width: 10,),
                        Container(
                          width: this.width*0.02,
                          child: TextFormField(controller: TextEditingController(text: Out_channel.toString()),onChanged: (Text)=>{Out_channel=int.parse(Text)},),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey
                            ),
                            onPressed: () {
                              Result(Address,"Linear");
                            },

                            child: Icon(Icons.add,)
                        ),
                      ],
                    ),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          backgroundColor: Colors.deepPurpleAccent
                      ), icon: Icon(Icons.account_tree_rounded),
                    )
                )
              ],
            )
        ),

      ],
    );
  }

// String Code(){
//   fi
//   return '';
// }


}

class Trans2d{
  dynamic Address;
  dynamic width;
  dynamic height;

  int input_dim=0;
  int output_dim=0;

  int in_width_channels=0;
  int in_height_channels=0;
  int kernel_size=0;
  int stride=0;
  int padding=0;
  int width_output=0;
  int height_output=0;
  Trans2d(width,height,int input_dim,int output_dim,int in_width_channels,int in_height_channels,int kernel_size,int stride,int padding,Address){
    Trans2d_Address=this;
    this.Address=Address;
    this.width=width;
    this.height=height;

    this.input_dim=input_dim;
    this.output_dim=output_dim;

    this.in_width_channels=in_width_channels;
    this.in_height_channels=in_height_channels;
    this.kernel_size=kernel_size;
    this.stride=stride;
    this.padding=padding;

  }

  Widget Layer(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Container(

            width: this.width*0.5,
            child: Stack(
              children: [

                Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),

                    width: this.width*0.6,
                    height: this.height*0.03,
                    child: TextButton.icon(onPressed: null,label: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Trans2d',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.black54,
                              fontSize: 20
                          ),),
                          SizedBox(width: 100,),
                          Text('out channel',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Out_channel.toString()),onChanged: (Text)=>{Out_channel=int.parse(Text)},),
                          ),
                          SizedBox(width: 10,),
                          Text('kernel size',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Kernel_size.toString()),onChanged: (Text)=>{Kernel_size=int.parse(Text)},),
                          ),
                          SizedBox(width: 10,),
                          Text('stride',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Stride.toString()),onChanged: (Text)=>{Stride=int.parse(Text)},),
                          ),
                          SizedBox(width: 10,),
                          Text('padding',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 18
                          ),),
                          SizedBox(width: 10,),
                          Container(
                            width: this.width*0.02,
                            child: TextFormField(controller: TextEditingController(text: Padding.toString()),onChanged: (Text)=>{Padding=int.parse(Text)},),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey
                              ),
                              onPressed: () {

                                Result(Address,"Tras2d");

                              },

                              child: Icon(Icons.add,)
                          ),


                        ],
                      ),
                    ),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        backgroundColor: Colors.deepPurpleAccent,
                      ), icon: Icon(Icons.account_tree_rounded),
                    )
                )
              ],
            )
        ),

      ],
    );
  }

// String Code(){
//   fi
//   return '';
// }


}



class Tensorflow extends StatefulWidget {
  const Tensorflow({Key? key}) : super(key: key);

  @override
  State<Tensorflow> createState() => _TensorflowState();
}

class _TensorflowState extends State<Tensorflow> {

  void C(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [

              Stack(
                  children: [


                    Container(

                        width: MediaQuery.of(context).size.width * 0.6,
                        child:
                        Container(
                            margin: EdgeInsets.only(top: 30,bottom: 30),

                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: MaterialApp(
                              debugShowCheckedModeBanner: false,
                              home: Stack(
                                  children: [
                                    DefaultTabController(
                                      // 탭의 수 설정
                                      length: 3,
                                      child: Scaffold(
                                        appBar: AppBar(

                                          title: const Text('',style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54
                                          ),),

                                          // TabBar 구현. 각 컨텐트를 호출할 탭들을 등록
                                          bottom: const TabBar(

                                            tabs: [
                                              Tab(child: Text('Conv2d'),),
                                              Tab(child: Text('Pool'),),

                                              Tab(child: Text('Trans2d'),),
                                            ],
                                          ),
                                        ),
                                        // TabVarView 구현. 각 탭에 해당하는 컨텐트 구성
                                        body: TabBarView(
                                          children: [
                                            Conv2d(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*2, In_channel, Out_channel, Width, Height, Kernel_size, Stride, Padding,this).Layer(),
                                            Pooling(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*2, In_channel, Out_channel, Width, Height, Kernel_size, Stride, Padding,this).Layer(),

                                            Trans2d(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height*2, In_channel, Out_channel, Width, Height, Kernel_size, Stride, Padding,this).Layer()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            )
                        )



                    ),
                    Container(margin:EdgeInsets.only(top: 30,bottom: 30),width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          ElevatedButton(
                              onPressed: ()
                              {
                                String Tensorflow_Code='';
                                for(int i=0;i<Code.length;i++){

                                  switch(Code[i][0].toString()) {
                                    case "Cond2d":
                                      Tensorflow_Code+='model.add(Conv2D('+(i!=0?Code[i-1][1]:In_channel.toString())+','+Code[i][1]+','+Code[i][2]+','+Code[i][3]+(int.parse(Code[i][4])>0?',"valid"':'')+'))'+'\n';
                                      break;
                                    case "Pooling":
                                      Tensorflow_Code+='model.add(MaxPooling2D('+Code[i][1]+','+Code[i][2]+','+Code[i][3]+','+Code[i][4]+'))'+'\n';
                                      break;
                                    case "Trans2d":
                                      Tensorflow_Code+='model.add(Conv2DTranspose('+(i!=0?Code[i-1][1]:In_channel.toString())+','+Code[i][1]+','+Code[i][2]+','+Code[i][3]+','+Code[i][3]+(int.parse(Code[i][4])>0?',"valid"':'')+'))'+'\n';
                                      break;
                                    default:
                                      break;
                                  }


                                }


                                SideSheet.right(
                                  body: Scaffold(appBar: AppBar(title: Text('Tensorflow')),body: Text(Tensorflow_Code,style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold
                                  )),),
                                  context: context,
                                  width: MediaQuery.of(context).size.width * 0.4,
                                );
                              },

                              child: Icon(Icons.code)
                          ),
                          TextButton(onPressed: (){}, child: ElevatedButton(
                              onPressed: () {
                                try{
                                  Layers.removeAt(Layers.length-1);
                                  Code.removeAt(Code.length-1);
                                }
                                catch(e){
                                  logger.e('Hey You...');
                                }

                                setState(() {});
                              },

                              child: Icon(Icons.remove)
                          ),),

                        ],
                      ),),
                  ]
              ),

              Center(
                child: Container(

                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Stack(
                      children: [

                        Container(
                            margin: EdgeInsets.only(top: 30,bottom: 30),

                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.06,
                            child: TextButton.icon(onPressed: null,label: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Input',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                      color: Colors.black54
                                  ),),
                                  SizedBox(width: 100,),
                                  Text('in channel',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,

                                  ),),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.02,
                                    child: TextFormField(controller: TextEditingController(text: In_channel.toString()),onChanged: (Text)=>{In_channel=int.parse(Text)},),
                                  ),
                                  SizedBox(width: 10,),
                                  Text('width',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18
                                  ),),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.02,
                                    child: TextFormField(controller: TextEditingController(text: Width.toString()),onChanged: (Text)=>{Width=int.parse(Text)},),
                                  ),
                                  SizedBox(width: 10,),
                                  Text('height',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 18
                                  ),),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.02,
                                    child: TextFormField(controller: TextEditingController(text: Height.toString()),onChanged: (Text)=>{Height=int.parse(Text)},),
                                  )
                                ],
                              ),
                            ),
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  backgroundColor: Colors.cyanAccent
                              ), icon: Icon(Icons.settings_input_svideo),
                            )
                        )
                      ],
                    )
                ),
              ),
              Column(children: Layers,),


              SizedBox(height: 1000,)
            ],
          ),
        )
    );
  }
}
