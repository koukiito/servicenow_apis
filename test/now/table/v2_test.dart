import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:servicenow_apis/now/table/v2.dart';

import '../../test_shared.dart';

void main() async {
  final tableApi = TableApi(user: testUser);
  final response = await tableApi.getRecords(tableName: 'incident');
  print(response);

  group("Create Instance", ()
  {
    test('TableApi', () async{
      var res = await TableApi(user: testUser).getRecords(tableName: "incident", params: {"sysparm_limit": "10"});
      print((res.body).length);
      print((res.body).records[0].fields);
      expect(res.response.statusCode, 200);
    });
  });
}