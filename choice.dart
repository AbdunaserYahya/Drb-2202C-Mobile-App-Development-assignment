import 'package:finalproject/easy.dart';
import 'package:finalproject/hard.dart';
import 'package:finalproject/medium.dart';
import 'package:flutter/material.dart';

class Choice extends StatelessWidget {
  const Choice({super.key});

    void _easyDemo({
         required BuildContext context,
      bool fullpageDialog = false,

       }){

        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Easy(),
      fullscreenDialog: fullpageDialog,),);
     

    }
   void _hardDemo({
         required BuildContext context,
      bool fullpageDialog = false,

       }){

Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Hard(),
      fullscreenDialog: fullpageDialog,),);
     

   }

   void _mediumDemo({
         required BuildContext context,
      bool fullpageDialog = false,

       }){
Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Medium(),
      fullscreenDialog: fullpageDialog,),);
     


   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choice Dashboard'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Row(
        children: [
          ElevatedButton(onPressed:() =>  _hardDemo(context: context,
              fullpageDialog: true), child: Text('hard') ),
          ElevatedButton(onPressed:() => _mediumDemo(context: context,
              fullpageDialog: true), child: Text('medium') ),
          ElevatedButton(onPressed: () => _easyDemo(context: context,
              fullpageDialog: true), child: Text('easy') ),
        ],
      ),
    );
  }
}