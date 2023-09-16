import 'package:flutter_test/flutter_test.dart';
import 'package:servicenow_apis/now/table/v2.dart';

import '../../test_shared.dart';

void main() async {
  //final tableApi = TableApi(user: testUser);
  //final response = await tableApi.getRecords(tableName: 'incident');
  group("Create Instance", ()
  {
    test('TableApi', () async{
      var res = await TableApi(user: testUser).getRecords(tableName: "incident", params: {"sysparm_limit": "10"});
      expect(res.response.statusCode, 200);
    });
  });
}