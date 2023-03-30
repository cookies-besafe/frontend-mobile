import 'package:besafe/shared/jwt.dart';

const bool _local = false;

class ApiSchema {
  static const _httpScheme = _local ? 'http' : 'http',
      _wsScheme = _local ? 'ws' : 'ws',
      _domain = _local ? '10.0.2.2:8008' : '35.185.27.27';

  static const String _baseHttpUrl = '$_httpScheme://$_domain/api';
  static const String _baseWsUrl = '$_wsScheme://$_domain/api';

  static final Uri loginEndpoint = Uri.parse('$_baseHttpUrl/auth/login');
  static final Uri registerEndpoint = Uri.parse('$_baseHttpUrl/auth/register');
  static final Uri meEndpoint = Uri.parse('$_baseHttpUrl/auth/me');

  static final Uri sosListUrl = Uri.parse('$_baseHttpUrl/sos-request/');

  static Uri getSosWsDetailUrl(int id) =>
      Uri.parse('$_baseWsUrl/sos-request/$id/location-live-update');

  static Uri getSosHttpDetailUrl(int id) =>
      Uri.parse('$_baseHttpUrl/sos-request/$id');

  static final Uri trustedContactsListUrl =
      Uri.parse('$_baseHttpUrl/trusted-contacts/');

  static Uri getTrustedContactsDetailUrl(int id) =>
      Uri.parse('$_baseHttpUrl/trusted-contacts/$id');

  static final Uri articlesListUrl = Uri.parse('$_baseHttpUrl/posts/');

  static const Map<String, String> unauthenticatedHeaders = {
    'Content-Type': 'application/json'
  };

  static Future<Map<String, String>> getAuthenticatedHeaders() async => {
        'Content-Type': 'application/json',
        'authorization': await JwtUtils.getKey(),
      };
}
