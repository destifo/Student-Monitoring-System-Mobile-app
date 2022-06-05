class UserResponse {
  final String id;
  final String token;
  final String role;

  UserResponse({required this.id, required this.token, required this.role});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        id: json['_id'].toString(),
        token: json['token'].toString(),
        role: json['role'].toString());
  }
}
