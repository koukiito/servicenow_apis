import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:servicenow_apis/shared.dart';
export 'package:servicenow_apis/shared.dart';

class TableApi {
  final ServiceNowUser user;
  TableApi({required this.user});

  Future<ServiceNowResponse<ServiceNowRecords>> getRecords(
      {required String tableName, Map<String, String>? params}) async {
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization':
          'Basic ${base64Encode(utf8.encode('${user.username}:${user.password}'))}',
    };
    final url = ServiceNowApisUtil.getUrl(
        baseUrl: '${user.instance.url}/api/now/v2/table/$tableName',
        params: params);
    final response = await http.get(url, headers: headers);

    //print(jsonDecode(response.body)["result"]);
    List<ServiceNowRecord> records =
        (jsonDecode(response.body)["result"] as List<dynamic>)
            .map((e) => ServiceNowRecord(e))
            .toList();
    return ServiceNowResponse(
        response, ServiceNowRecords(records: records, tableName: tableName));
  }
}

class ServiceNowResponse<T> {
  final http.Response response;
  final T body;
  ServiceNowResponse(this.response, this.body);
}

class ServiceNowRecords {
  final List<ServiceNowRecord> records;
  final String tableName;
  get length => records.length;
  ServiceNowRecords({required this.records, required this.tableName});
}

class ServiceNowRecord {
  final Map<String, dynamic> fields;
  ServiceNowRecord(this.fields);
}
