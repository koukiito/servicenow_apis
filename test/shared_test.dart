import 'package:flutter_test/flutter_test.dart';
import 'package:servicenow_apis/now/table/v2.dart';

import 'package:servicenow_apis/shared.dart';

//import 'test_shared.dart';

void main() {
  group("Create Instance", () {
    test('Create ServiceNowInstance and get URL', () {
      final instance = ServiceNowInstance(name: 'dev12345');
      expect(instance.url, 'https://dev12345.service-now.com');
    });

    test('Empty Name', () {
      expect(()=>ServiceNowInstance(name: ""), throwsArgumentError);
    });

    test('Create ServiceNowInstance with CustomURL and get URL', () {
      final instance = ServiceNowInstance.withCustomUrl(url: "https://dev12345.example.com");
      expect(
        instance.url, 'https://dev12345.example.com');
    });

    test('Invalid CustomURL (http)', () {
      expect(()=>ServiceNowInstance.withCustomUrl(url: "http://dev12345.example.com"), throwsArgumentError);
    });

    test('Invalid CustomURL (not URL)', () {
      expect(()=>ServiceNowInstance.withCustomUrl(url: "hogehoge"), throwsArgumentError);
    });
  });

  group("Utils", () {
    test('Create ServiceNowInstance and get URL', () {
      final params = <String,String>{
        'sysparm_limit': '10',
        'sysparm_display_value': 'false',
      };
      final url = ServiceNowApisUtil.getUrl(baseUrl: 'https://dev12345.service-now.com/api/now/table/incident', params: params);
      expect(url, Uri.parse("https://dev12345.service-now.com/api/now/table/incident?sysparm_limit=10&sysparm_display_value=false"));
    });
  });

  group("ServiceNowQuery", () {
    test('Create Query', () {
      final query = ServiceNowQuery.field("hoge").isEqualTo("hoge").and().field("hogehoge").isNotEmpty().end();
      expect(query, "hoge=hoge^hogehogeISNOTEMPTY");
    });
  });





}