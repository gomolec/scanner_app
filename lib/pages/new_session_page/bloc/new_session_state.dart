part of 'new_session_bloc.dart';

enum NewSessionStatus { initial, loading, success, failure }

extension NewSessionStatusX on NewSessionStatus {
  bool get isLoadingOrSuccess => [
        NewSessionStatus.loading,
        NewSessionStatus.success,
      ].contains(this);
}

class NewSessionState extends Equatable {
  const NewSessionState({
    this.status = NewSessionStatus.initial,
    this.initialSession,
    this.name = "",
    this.note = "",
    this.author = "",
    this.downloadUrls = false,
  });

  final NewSessionStatus status;
  final Session? initialSession;
  final String name;
  final String note;
  final String author;
  final bool downloadUrls;

  bool get isNewSession => initialSession == null;

  NewSessionState copyWith({
    NewSessionStatus? status,
    Session? initialSession,
    String? name,
    String? note,
    String? author,
    bool? downloadUrls,
  }) {
    return NewSessionState(
      status: status ?? this.status,
      initialSession: initialSession ?? this.initialSession,
      name: name ?? this.name,
      note: note ?? this.note,
      author: author ?? this.author,
      downloadUrls: downloadUrls ?? this.downloadUrls,
    );
  }

  @override
  String toString() {
    return 'NewSessionState(status: $status, initialSession: $initialSession, name: $name, note: $note, author: $author, downloadUrls: $downloadUrls)';
  }

  @override
  List<Object?> get props {
    return [status, initialSession, name, note, author, downloadUrls];
  }
}
