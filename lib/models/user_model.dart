class UserModel {
  String id;
  String name;
  String email;
  List<String> favoriteEventsIds;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.favoriteEventsIds,
  });

  UserModel.fromjson(Map<String, dynamic> json)
    : this(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        favoriteEventsIds: (json['favoriteEventsIds'] as List).cast<String>(),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'favoriteEventsIds': favoriteEventsIds,
  };
}
