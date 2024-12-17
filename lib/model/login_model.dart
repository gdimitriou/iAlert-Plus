class LoginModel {
  final String pin;
  final String challenge;
  final double latitude;
  final double longitude;
  final String deviceId;
  final int buildVersion;

  LoginModel({
    required this.pin,
    required this.challenge,
    required this.latitude,
    required this.longitude,
    required this.deviceId,
    required this.buildVersion,
  });

  Map<String, dynamic> toJson() => {
        'token': pin,
        'challenge': challenge,
        'latitude': latitude,
        'longitude': longitude,
        'imei': deviceId,
        'build': buildVersion,
      };
}