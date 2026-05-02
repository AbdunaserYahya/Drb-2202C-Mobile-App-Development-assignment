import 'package:flutter/material.dart';

class Easy extends StatelessWidget {
  const Easy({super.key});

    void _Down(){

    }

    void _Left(){

    }

    void _Right(){

    }

 void _Up(){

 }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
   title: const Text('Easy Demo'),
   backgroundColor: Colors.lightBlueAccent,
   ),
  body: SafeArea(
    child: Padding(padding: EdgeInsets.all(20.0),
    child: Column(
      children: [
        Container(
          width: 700,
          height: 400,
          alignment: Alignment.topCenter,
          color: Colors.lightBlueAccent,
          margin: EdgeInsets.all(10.0),
     child:  Image(image: AssetImage("assets/images/zm1i_579s_210409-removebg-preview.png")),
        ),
         ElevatedButton(onPressed: _Up, child: Text('Up'),
     ),
      ElevatedButton(onPressed: _Down, child: Text('Down'),
     ),
      ElevatedButton(onPressed: _Right, child: Text('Right'),
     ),
      ElevatedButton(onPressed: _Left, child: Text('Left'),
     ),
      ],
    ),
    )
  
  ),
    );
  }

 /* Draggable<int> _draggableWidget(){
    return Draggable<int>(
      childWhenDragging: Image(image: AssetImage("assets/images/zm1i_579s_210409-removebg-preview.png")),
      feedback: Image(image: AssetImage("assets/images/zm1i_579s_210409-removebg-preview.png")),
   data: int.parse(Colors.tealAccent.value.toString()),
      child: Column(
      children: [
        Image(image: AssetImage("assets/images/zm1i_579s_210409-removebg-preview.png")),
      ],
    ), );
}*/

}