class UserEntity {
  final int age;
  UserEntity({required this.age});

  UserEntity copyWith({int? age}) {
    return UserEntity(age: age ?? this.age);
  }
}
