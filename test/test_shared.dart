import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:servicenow_apis/shared.dart';
import 'test_secret.dart' as secret;

ServiceNowInstance testInstance = ServiceNowInstance(name: secret.instanceName);
ServiceNowUser testUser = ServiceNowUser(
    instance: testInstance, username: secret.userName, password: secret.password);

HttpClient httpClient = HttpClient();
