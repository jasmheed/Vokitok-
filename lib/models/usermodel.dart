class UserModel {
  String? name;
  String? email;
  String? password;
  String? id;
  String? image;
  String? confirm;

  UserModel({
    this.name,
    this.email,
    this.password,
    this.id,
    this.image,
    this.confirm,
  });
  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "email": this.email,
      "password": this.password,
      "id": this.id,
      "image": this.image,
      "confirm": this.confirm,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map["email"] ?? "",
      name: map["name"] ?? "",
      password: map["password"] ?? "",
      id: map["id"] ?? "",
      image: map["image"] ?? "",
      confirm: map["confirm"] ?? "",
    );
  }

  copyWith({
    String? name,
    String? email,
    String? password,
    String? id,
    String? image,
    String? confirm,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
      image: image ?? this.image,
      confirm: confirm ?? this.confirm,
    );
  }
}
