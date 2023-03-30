import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import 'package:besafe/models.dart';
import 'package:besafe/api_utils.dart';
import 'package:besafe/shared/jwt.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserApi {
  static Future<UserModel> registrationRequest(UserModel requestUser) async {
    final http.Response response;
    final Map data;

    String body = userToJson(requestUser);

    response = await http.post(ApiSchema.registerEndpoint,
        headers: ApiSchema.unauthenticatedHeaders, body: body);
    data = json.decode(response.body);

    if (response.statusCode == 200) {
      // Save token to storage
      final String jwtToken = data['token'];
      JwtUtils.storeKey(jwtToken);

      // Return user
      final UserModel responseUser = userFromJson(json.encode(data['user']));
      return responseUser;
    } else {
      print(body);
      throw 'Api error:\n$data';
    }
  }

  static Future<void> loginRequest(String email, String password) async {
    final http.Response response;
    Map data;
    final String body;

    data = {'email': email, 'password': password};
    body = json.encode(data);

    response = await http.post(ApiSchema.loginEndpoint,
        headers: ApiSchema.unauthenticatedHeaders, body: body);
    data = json.decode(response.body);

    if (response.statusCode == 200) {
      // Save token to storage
      final String jwtToken = data['token'];
      JwtUtils.storeKey(jwtToken);
    } else {
      print(body);
      throw 'Api error:\n$data';
    }
  }

  static Future<void> logout() async {
    JwtUtils.deleteKey();
  }

  static Future<UserModel> getMe() async {
    final http.Response response;
    final Map data;

    response = await http.get(ApiSchema.meEndpoint,
        headers: await ApiSchema.getAuthenticatedHeaders());
    data = json.decode(response.body);

    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      throw 'Api error:\n$data';
    }
  }
}

class TrustedContactApi {
  static Future<List<TrustedContactModel>> list() async {
    final http.Response response;
    final List data;

    response = await http.get(ApiSchema.trustedContactsListUrl,
        headers: await ApiSchema.getAuthenticatedHeaders());
    data = json.decode(response.body);

    if (response.statusCode == 200) {
      final List<TrustedContactModel> models =
          multipleTrustedContactsFromJson(response.body);
      return models;
    } else {
      throw 'Api error:\n$data';
    }
  }

  static Future<TrustedContactModel> create(
      TrustedContactModel trustedContact) async {
    final http.Response response;
    final Map data;

    String body = trustedContactToJson(trustedContact);

    response = await http.post(ApiSchema.trustedContactsListUrl,
        headers: await ApiSchema.getAuthenticatedHeaders(), body: body);
    data = json.decode(response.body);

    if (response.statusCode == 200) {
      return trustedContactFromJson(response.body);
    } else {
      print(body);
      throw 'Api error:\n$data';
    }
  }

  static Future<TrustedContactModel> update(
      TrustedContactModel trustedContact) async {
    final http.Response response;
    final Map data;
    final Uri uri = ApiSchema.getTrustedContactsDetailUrl(trustedContact.id!);

    String body = trustedContactToJson(trustedContact);

    response = await http.patch(uri,
        headers: await ApiSchema.getAuthenticatedHeaders(), body: body);
    data = json.decode(response.body);

    if (response.statusCode == 200) {
      return trustedContactFromJson(response.body);
    } else {
      print(body);
      throw 'Api error:\n$data';
    }
  }

  static Future<TrustedContactModel> delete(
      TrustedContactModel trustedContact) async {
    final http.Response response;
    final Uri uri = ApiSchema.getTrustedContactsDetailUrl(trustedContact.id!);

    response = await http.delete(uri,
        headers: await ApiSchema.getAuthenticatedHeaders());

    if (response.statusCode == 200) {
      return trustedContactFromJson(response.body);
    } else {
      final Map data = json.decode(response.body);
      throw 'Api error:\n$data';
    }
  }
}

class SosRequestApi {
  static Future<List<SosRequestModel>> list() async {
    final http.Response response;
    final List data;

    response = await http.get(ApiSchema.sosListUrl,
        headers: await ApiSchema.getAuthenticatedHeaders());
    data = json.decode(response.body);

    if (response.statusCode == 200) {
      final List<SosRequestModel> models =
          multipleSosRequestHistoryEntriesFromJson(response.body);
      return models;
    } else {
      throw 'Api error:\n$data';
    }
  }

  WebSocketChannel? _channel;
  late int _requestId;
  int? _userId;
  Stream<Position> locationStream;
  StreamSubscription<Position>? locationStreamSubscription;

  SosRequestApi({required this.locationStream});

  int getUserId() => _userId!;

  Future<int> start() async {
    print('DIAG init sos request');
    // Create a new sos request
    _requestId = await _sendSosRequest();
    _channel =
        WebSocketChannel.connect(ApiSchema.getSosWsDetailUrl(_requestId));
    _initLocationTracking();
    return _requestId;
  }

  Future<void> stop() async {
    // Close existing connection if there is
    print('DIAG: Stopping location tracking');
    _channel?.sink.close();
    _deactivateSosRequest();
    locationStreamSubscription?.pause();
  }

  Future<int> _sendSosRequest() async {
    final http.Response response;
    final Map data;

    response = await http.post(ApiSchema.sosListUrl,
        headers: await ApiSchema.getAuthenticatedHeaders());
    print(response.body);
    data = json.decode(response.body);

    if (response.statusCode == 200) {
      final int id = data['id'];
      _userId = data['user']['id'];
      return id;
    } else {
      throw 'Api error:\n$data';
    }
  }

  Future<void> _deactivateSosRequest() async {
    final http.Response response;
    final Map data;

    response = await http.patch(ApiSchema.getSosHttpDetailUrl(_requestId),
        headers: await ApiSchema.getAuthenticatedHeaders());
    data = json.decode(response.body);

    if (response.statusCode == 200) {
      if (data['is_active'] == true) {
        throw '_deactivateSosRequest() was called on deactivated instance';
      }
    } else {
      throw 'Api error:\n$data';
    }
  }

  void _initLocationTracking() {
    print('DIAG startinng listening to stream');
    if (locationStreamSubscription != null &&
        locationStreamSubscription!.isPaused) {
      locationStreamSubscription!.resume();
    } else {
      locationStreamSubscription = locationStream.listen((Position? position) {
        print('DIAG received position $position');
        if (position != null) {
          _sendLocationUpdate({
            'lat': position.latitude,
            'long': position.longitude,
          });
        }
      });
    }
  }

  void _sendLocationUpdate(Map<String, double> data) {
    _channel!.sink.add(json.encode(data));
  }
}

class ArticleApi {
  static Future<List<ArticleModel>> list() async {
    final http.Response response;

    response = await http.get(ApiSchema.articlesListUrl,
        headers: await ApiSchema.getAuthenticatedHeaders());

    if (response.statusCode == 200) {
      final List<ArticleModel> models = multipleArticlesFromJson(response.body);
      return models;
    } else {
      final List data = json.decode(response.body);
      throw 'Api error:\n$data';
    }
  }
}
