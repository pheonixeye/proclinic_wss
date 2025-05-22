part of './socket_message.dart';

enum MessageDirection implements EquatableMixin {
  receptionToDoctor,
  doctorToReception;

  @override
  factory MessageDirection.fromString(String value) {
    return switch (value) {
      'receptionToDoctor' => MessageDirection.receptionToDoctor,
      'doctorToReception' => MessageDirection.doctorToReception,
      _ => throw UnimplementedError(),
    };
  }
  @override
  List<Object> get props => [
        receptionToDoctor,
        doctorToReception,
      ];

  @override
  bool get stringify => true;

  @override
  String toString() {
    return name.split('.').last;
  }
}
