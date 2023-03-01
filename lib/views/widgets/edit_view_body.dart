import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/views/widgets/colors_list_view.dart';
import 'package:notes_app/views/widgets/custom_app_bar.dart';
import 'package:notes_app/views/widgets/custom_text_field.dart';

import '../../constants.dart';
import 'edit_note_colors_list_view.dart';

class EditNoteViewBody extends StatefulWidget {
  const EditNoteViewBody({Key? key, required this.note}) : super(key: key);

  final NoteModel note;

  @override
  State<EditNoteViewBody> createState() => _EditNoteViewBodyState();
}

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  String? name,status;

  int? age;
  String? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          CustomAppBar(
            onPressed: () {
              widget.note.name = name ?? widget.note.name;
              widget.note.age = age ?? widget.note.age;
              widget.note.value = value ?? widget.note.value;
              widget.note.status = status ?? widget.note.status;

              widget.note.save();
              BlocProvider.of<NotesCubit>(context).fetchAllNotes();
              Navigator.pop(context);
            },
            title: 'Edit Note',
            icon: Icons.check,
          ),
          const SizedBox(
            height: 50,
          ),
          CustomTextField(
            onChanged: (value) {
name = value;
            },
            hint: widget.note.name,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextField(hint: widget.note.age.toString(),onChanged: (value) {
            age = int.parse(value);
          },),
          SizedBox(
            height: 16
          ),
          CustomTextField(hint: widget.note.value.toString(),onChanged: (value) {
            value = double.parse(value) as String;
          },),
          const SizedBox(
            height: 16,
          ),

          CustomTextField(
            onChanged: (value) {
              status = value;
            },
            hint: widget.note.status,
            maxLines: 5,
          ),
          const SizedBox(
            height: 16,
          ),
          EditNoteColorsList(
            note: widget.note,
          ),
        ],
      ),
    );
  }
}
