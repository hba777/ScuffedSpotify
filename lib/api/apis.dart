import 'package:mysql1/mysql1.dart';

class APIs{

  static final String host ='';

  static final String user ='';

  static final String password ='';

  static final int port  =1234;

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
}