class UserEntityBl {
  final int age;
  UserEntityBl({required this.age});

  UserEntityBl copyWith({int? age}) {
    return UserEntityBl(age: age ?? this.age);
  }
}
