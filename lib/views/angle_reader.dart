import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../adfruit/adfruit_api_helper.dart';
import '../cubits/add_note_cubit/add_note_cubit.dart';



class angleReader extends StatefulWidget {
  @override
  _angleReaderState createState() => _angleReaderState();
}
class _angleReaderState extends State<angleReader> {
  var angel;
  @override
  void initState() {
    super.initState();
    TempHumidAPI.getAngleData().then((value) {

      setState(() {
        angel = value.lastValue;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AddNoteCubit()..getValues(),
        child: BlocConsumer<AddNoteCubit,AddNoteState>(
        listener: (context, state) {},
    builder: (context, state) {
          return Scaffold
    (
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Result',style:TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ) ,),
              SizedBox(height: 30,),
              Container(
                  height: 200,
                  child: LottieBuilder.asset('assets/images/98428-arrow-down-purple.json')),
              SizedBox(height: 60,),

              StreamBuilder(
                stream: TempHumidAPI.getAngleData().asStream(),
                builder: (context, snapshot) {
                  return ConditionalBuilder(
                    condition: snapshot.hasData,
                    fallback: (context) => Center(child: CircularProgressIndicator()),
                    builder:(context)=> CircularPercentIndicator(
                      backgroundColor: Colors.blue,
                      radius: 80.0,
                      lineWidth: 30.0,
                      animation: true,
                      percent: int.parse(angel)/360,
                      center:  Text("${angel.toString()+"°"}",style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0)),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.white,
                    ),
                  );
                }
              ),

            ],
          ),
        ),
      );
    }
    )
    );
  }
}