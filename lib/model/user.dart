
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
  // late int id;
  late String lastName;
  late String firstName;
  late String middleName;
  late String address;
  late String empId;
  late String position;
  late String password;

  User({
    // required this.id,
    required this.lastName,
    required this.firstName,
    required this.middleName,
    required this.address,
    required this.empId,
    required this.position,
    required this.password,
  });

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



    return map;
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        lastName: map[colLN],
        firstName: map[colFN],
        middleName: map[colMN],
        address: map[colAddress],
        empId: map[colEmpId],
        position: map[colPosition],
        password: map[colPassword]);
  }
  User.fromMap(Map<String, dynamic> map){
    lastName= map[colLN];
    firstName= map[colFN];
    middleName= map[colMN];
    address= map[colAddress];
    empId= map[colEmpId];
    position= map[colPosition];
    password= map[colPassword];
  }
}
