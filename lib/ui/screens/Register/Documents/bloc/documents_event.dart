part of 'documents_bloc.dart';

abstract class DocumentsEvent extends Equatable {
  const DocumentsEvent();
  @override
  List<Object> get props => [];
}

class DocumentsStarted extends DocumentsEvent {}

class DocumentsNextPage extends DocumentsEvent {}

class DocumentsClickButton extends DocumentsEvent {
  final UiDocumentsInfo document;

  const DocumentsClickButton(
    this.document,
  );
}
