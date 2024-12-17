import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../models/login_model.dart';

class AuthService {
  final Dio _dio = Dio();
  final _storage = FlutterSecureStorage();

  Future<String> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.androidId ?? 'unknown';
  }

  Future<int> getBuildVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return int.parse(packageInfo.buildNumber);
  }

  Future<bool> login(LoginModel loginModel) async {
    try {
      final response = await _dio.post(
        'https://api.ialertfacility.com/authentication_log',
        data: loginModel.toJson(),
      );
      if (response.data['status'] == 1) {
        await _storage.write(key: 'user_token', value: response.data['body']['token']);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> qrLogin(String afm, String id) async {
    try {
      final response = await _dio.post(
        'https://api.ialertfacility.com/authentication_qr',
        data: {
          'afm': afm,
          'id': id,
          'deviceId': await getDeviceId(),
          'buildVersion': await getBuildVersion(),
        },
      );
      return response.data['status'] == 1;
    } catch (e) {
      return false;
    }
  }
}