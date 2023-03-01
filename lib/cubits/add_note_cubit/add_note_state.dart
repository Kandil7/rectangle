part of 'add_note_cubit.dart';

@immutable
abstract class AddNoteState {}

class AddNoteInitial extends AddNoteState {}

class AddNoteLoading extends AddNoteState {}

class AddNoteSuccess extends AddNoteState {}

class AddNoteFailure extends AddNoteState {
  final String errMessage;

  AddNoteFailure(this.errMessage);
}
class AddNoteValues extends AddNoteState {
  final NoteModel note;

  AddNoteValues(this.note);
}
class AddNoteValueSuccess extends AddNoteState {}