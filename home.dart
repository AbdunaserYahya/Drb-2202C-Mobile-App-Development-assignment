import 'package:flutter/material.dart';
import 'easy.dart';
class Home extends StatelessWidget {
  const Home({super.key});

   void _loginEvent({
         required BuildContext context,
      bool fullpageDialog = false,

       }){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Easy(),
      fullscreenDialog: fullpageDialog,),);
     
      }

  @override
  
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snake Demo'),
      backgroundColor: Colors.lightBlueAccent,
      ),
    
      body: SafeArea(
        child: Container(
          width: 500,
    height: 300,
    color: Colors.white70,
    alignment: Alignment.center,
    child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText:'UserName',
              hintText:'example@hilcoeschool.com'),
        ),
        TextFormField(
   decoration: InputDecoration(labelText:'Password',
              hintText:'!example&'),
        ),
      IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: () => _loginEvent(
              context: context,
              fullpageDialog: true
              )
              
          )
      ],
    ),
        ),
      ),
      );

     
    
  }
}