class AuthRequest {
  final String id;
  final String token;

  AuthRequest({required this.id, required this.token});

  AuthRequest.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        token = json['token'];
}
