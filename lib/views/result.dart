import 'package:flutter/material.dart';


import 'angle_reader.dart';

import 'notes_view.dart';

class Result extends StatefulWidget {
   Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {

    super.initState();
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 1,),
            Container(
              width: 200,
                height: 200,
                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  angleReader()));

                }, icon: Image.asset('assets/images/result.png'))),
            Spacer(flex: 1,),
            Container(
              width: 200,
                height: 200,
                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotesView()));
                }, icon: Image.asset('assets/images/folder.png'))),
            Spacer(flex: 1,),



          ],
        ),
      ),
    );
  }
}
