part of 'new_session_bloc.dart';

abstract class NewSessionEvent extends Equatable {
  const NewSessionEvent();

  @override
  List<Object> get props => [];
}

class NewSessionSubscriptionRequested extends NewSessionEvent {
  const NewSessionSubscriptionRequested();
}

class NewSessionNameChanged extends NewSessionEvent {
  const NewSessionNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class NewSessionNoteChanged extends NewSessionEvent {
  const NewSessionNoteChanged(this.note);

  final String note;

  @override
  List<Object> get props => [note];
}

class NewSessionAuthorChanged extends NewSessionEvent {
  const NewSessionAuthorChanged(this.author);

  final String author;

  @override
  List<Object> get props => [author];
}

class NewSessionDownloadUrlsChanged extends NewSessionEvent {
  const NewSessionDownloadUrlsChanged(this.downloadUrls);

  final bool downloadUrls;

  @override
  List<Object> get props => [downloadUrls];
}

class NewSessionSubmitted extends NewSessionEvent {
  const NewSessionSubmitted();
}
