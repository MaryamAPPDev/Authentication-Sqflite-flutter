class User {
  final int? id;
  final String? fullName;
  final String? email;
  final String userName;
  final String password;

  const User({
    this.id,
    this.fullName,
    this.email,
    required this.userName,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['usrId'],
      fullName: map['fullName'],
      email: map['email'],
      userName: map['usrName'],
      password: map['usrPassword'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usrId': id,
      'fullName': fullName,
      'email': email,
      'usrName': userName,
      'usrPassword': password,
    };
  }

  User copyWith({
    int? id,
    String? fullName,
    String? email,
    String? userName,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      password: password ?? this.password,
    );
  }
}
