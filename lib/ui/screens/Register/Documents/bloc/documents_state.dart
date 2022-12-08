part of 'documents_bloc.dart';

abstract class DocumentsState extends Equatable {
  @override
  List<Object> get props => [];
}

class DocumentsInitial extends DocumentsState {}

class DocumentsError extends DocumentsState {
  final AppException exception;
  DocumentsError(this.exception);
}

class DocumentsSuccess extends DocumentsState {}

class DocumentsLoading extends DocumentsState {}
