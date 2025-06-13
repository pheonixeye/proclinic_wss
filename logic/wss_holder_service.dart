import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

import '../models/db_type_id/db_type_id.dart';

class WSSHolder {
  const WSSHolder();

  static final Map<DbTypeId, WebSocketChannel> channels = {};

  @override
  String toString() {
    return channels.entries
        .map((e) => '${e.key} ==>> ${e.value.runtimeType}')
        .toList()
        .toString();
  }
}
