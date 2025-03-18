class UserToken {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  UserToken({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
    );
  }
}
