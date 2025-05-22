import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

import '../logic/wss_holder_service.dart';
import '../models/db_type_id/db_type_id.dart';
import '../models/socket_message/socket_message.dart';

// ignore: non_constant_identifier_names
Future<Response> onRequest(RequestContext context, String query) async {
  final _db_type_id = DbTypeId.fromString(query);

  final handler = webSocketHandler((channel, protocol) {
    // print(query);
    WSSHolder.channels.putIfAbsent(_db_type_id, () => channel);

    print(const WSSHolder());

    WSSHolder.channels[_db_type_id]?.stream.asBroadcastStream().listen(
      (data) {
        print(data);
        if (data is! String) {
          return;
        }
        final _msg = SocketNotificationMessage.fromJson(data);
        switch (_msg.direction) {
          case MessageDirection.receptionToDoctor:
            final _sendTo = DbTypeId(
              db: _db_type_id.db,
              type: 'doctor',
              id: _msg.docid.toString(),
            );
            WSSHolder.channels[_sendTo]?.sink.add(_msg.toJson());

          case MessageDirection.doctorToReception:
            final _sendTo = DbTypeId(
              db: _db_type_id.db,
              type: 'reception',
              id: '0',
            );
            WSSHolder.channels[_sendTo]?.sink.add(_msg.toJson());
        }
      },
      onDone: () => WSSHolder.channels.remove(_db_type_id),
    );
  });
  return handler(context);
}
