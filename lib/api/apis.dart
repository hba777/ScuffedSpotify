import 'dart:developer';

import 'package:mysql1/mysql1.dart';

class APIs {

  static final String host = '192.168.100.5';

  static final String user = 'haris';

  static final String password = 'Postpone777';

  static final int port = 1433;

  // static Future<void> ConnectSql() async{
  //   await SqlConn.connect(
  //       ip: "192.168.167.176",
  //       port: "1433",
  //       databaseName: "MyDatabase",
  //       username: "admin123",
  //       password: "Pass@123");
  // }

  //Use Future for anything that will happen in some time
  //Use await and async to wait for a response
  static Future<MySqlConnection> ConnectSql() async {
    var settings = new ConnectionSettings(
        host: host,
        user: user,
        password: password,
        port: port
    );

    return await MySqlConnection.connect(settings);
  }

  static Future main() async {
    try {
      final conn = await MySqlConnection.connect(ConnectionSettings(
          host: '192.168.100.5',
          port: 3306,
          user: 'hba777',
          db: 'lab',
          password: 'Postpone777',
          timeout: const Duration(seconds: 60)
      ));

      print("YOU FUCKING DID IT");

      await conn.close();
    } catch (e) {
      print('Error: $e');
    }
  }
}
