import 'package:sqflite/sqflite.dart';

const String tableUSER = 'user';
const String colID = '_id';
const String colLN = 'lastname';
const String colFN = 'firstname';
const String colMN = 'middleName';
const String colAddress = 'address';
const String colEmpId = 'empId';
const String colPosition = 'position';
const String colPassword = 'password';

class User {
  late int id;
  late String lastName;
  late String firstName;
  late String middleName;
  late String address;
  late String empId;
  late String position;
  late String password;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      colLN: lastName,
      colFN: firstName,
      colMN: middleName,
      colAddress: address,
      colEmpId: empId,
      colPosition: position,
      colPassword: password,
    };

    if (id > 0) {
      map[colID] = id;
    }

    return map;
  }

  User();
  User.fromMap(Map<String, Object?> map) {
    id = map[colID] as int;
    lastName = map[colLN] as String;
    firstName = map[colFN] as String;
    middleName = map[colMN] as String;
    address = map[colAddress] as String;
    empId = map[colEmpId] as String;
    position = map[colPosition] as String;
    password = map[colPassword] as String;
  }
}

class UserProvider {
  late Database db;

  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableUSER ( 
  $colID integer primary key autoincrement, 
  $colLN text not null,
  $colFN text not null,
  $colMN text not null,
  
  $colAddress text not null,
  $colEmpId text not null,
  $colPosition text not null,
  $colPassword text not null)
''');
    });
  }

  Future<User> insert(User user) async {
    user.id = await db.insert(tableUSER, user.toMap());
    return user;
  }


}
