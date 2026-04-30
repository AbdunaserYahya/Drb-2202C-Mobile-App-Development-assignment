import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture Basic'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
         child: Center(
          child: Column(
            children: [
              _basicGesture(context),
              Divider(thickness: 2.0,),
              _draggableWidget(),
            ],
            
          ),
         ),
      )),
    );
  }
  GestureDetector _basicGesture(BuildContext context){
    return GestureDetector(
      onTap: (){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tapped')),
        );
         },

         onDoubleTap: (){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Double Tapped')),
        );
         },
        onLongPress: (){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Long Pressed')),
        );
        },
        
        onPanUpdate: (DragUpdateDetails details){
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Panning at: ${details.localPosition}')),
        );
        },

  child: Container(
    width: 200,
    height: 200,
    color: Colors.lightBlueAccent,
    alignment: Alignment.center,
    child:  const Text('Tap, Double Tap, Long Press or Pan me!'),
  ),

      
    );
  }
  Draggable<int> _draggableWidget(){
    return Draggable<int>(
      childWhenDragging: Icon(Icons.palette,size: 50,color: Colors.green,),
      feedback: Icon(Icons.palette,size: 50,color: Colors.tealAccent),
   data: int.parse(Colors.tealAccent.value.toString()),
      child: Column(
      children: [
        Icon(Icons.palette, size: 50, color: Colors.lightBlueAccent,),Text('Drag me!'),
      ],
    ), );
  }


}