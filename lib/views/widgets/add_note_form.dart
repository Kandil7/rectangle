import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/main.dart';
import 'package:notes_app/models/note_model.dart';

import '../../adfruit/adfruit_api_helper.dart';
import 'colors_list_view.dart';
import 'custom_button.dart';
import 'custom_text_field.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? name,status;
  int? age;
  String? value;
  @override
  void initState() {
    TempHumidAPI.getAngleData().then((value) => {
      setState(() {    BlocProvider.of<AddNoteCubit>(context).angle = value.lastValue;}),

        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          CustomTextField(
            onSaved: (value) {
              name = value;
            },
            hint: 'name',
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            child: DropdownButton(
              hint: Text('Select Age'),
              value: age,
              onChanged: (newValue) {
                setState(() {
                  age = newValue as int;
                });
              },
              items: List.generate(100, (index) => index + 1)
                  .map<DropdownMenuItem<int>>(( value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onSaved: (value) {
              status = value;
            },
            hint: 'status',
          ),

          const SizedBox(
            height: 16,
          ),
          CustomTextField(
            onSaved: (values) {
              value = values;
            },
            hint: 'value',
          ),


          const SizedBox(
            height: 16,
          ),

          // ConditionalBuilder(
          //   condition: AddNoteCubit.get(context).angle != null,
          //   builder: (context) => Container(
          //     decoration: BoxDecoration(
          //       color: Colors.white.withOpacity(0.2),
          //       borderRadius: BorderRadius.circular(16),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(16.0),
          //       child: Column(
          //         children: [
          //           Text(
          //             AddNoteCubit.get(context).angle.toString(),
          //             style: TextStyle(
          //               fontSize: 28,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 16,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          //   fallback: (context) => Container(
          //     decoration: BoxDecoration(
          //       color: Colors.white.withOpacity(0.2),
          //       borderRadius: BorderRadius.circular(16),
          //     ),
          //     child:Center(
          //       child:CircularProgressIndicator(),
          // ),
          //   ),
          // ),
          const SizedBox(
            height: 16,
          ),

          const ColorsListView(),
          const SizedBox(
            height: 32,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              var cubit = BlocProvider.of<AddNoteCubit>(context);
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();


                    var formattedCurrentDate =
                        DateFormat('dd-mm-yyyy').format(DateTime.now());
                    var noteModel = NoteModel(
                        name: name!,
                        age: age!,
                        status: status!,

                        value: value!,
                        date: formattedCurrentDate,
                        color: Colors.blue.value);
                    BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),


    );

  }
}


