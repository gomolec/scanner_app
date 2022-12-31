// part of 'sessions_cubit.dart';

// abstract class SessionsState extends Equatable {
//   const SessionsState();

//   @override
//   List<Object?> get props => [];
// }

// class SessionsInitial extends SessionsState {}

// class SessionsLoaded extends SessionsState {
//   final List<Session> sessions;
//   final String? actualSessionId;

//   const SessionsLoaded({
//     required this.sessions,
//     this.actualSessionId,
//   });

//   SessionsLoaded copyWith({
//     List<Session>? sessions,
//     String? Function()? actualSessionId,
//   }) {
//     return SessionsLoaded(
//       sessions: sessions ?? this.sessions,
//       actualSessionId:
//           actualSessionId != null ? actualSessionId() : this.actualSessionId,
//     );
//   }

//   @override
//   List<Object?> get props => [sessions, actualSessionId];
// }
