import 'package:http/http.dart' as http;

class ServiceNowInstance {
  final String name;
  final String url;

  //Default
  ServiceNowInstance({required this.name})  : url = 'https://$name.service-now.com'{
    if(name.isEmpty) throw ArgumentError.value(name, 'name', 'Name must not be empty');
  }

  //Custom URL
  ServiceNowInstance.withCustomUrl({required this.url}) : name = ""{
    if (!url.startsWith('https://')) {
      throw ArgumentError.value(url, 'url', 'URL must start with https://');
    }
    if(Uri.parse(url).isAbsolute == false) {
      throw ArgumentError.value(url, 'url', 'URL is not valid');
    }
  }
}

class ServiceNowUser{
  final ServiceNowInstance instance;
  final String username;
  final String password;

  ServiceNowUser({required this.instance, required this.username, required this.password});
}


class JsonResponse {
  final http.Response response;
  final Map<String, dynamic> json;
  JsonResponse(this.response, this.json);
}

class ServiceNowApisUtil{
  // static Map<String,String> getHeaders(ServiceNowUser user){
  //   return {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Basic ' + base64Encode(utf8.encode('${user.username}:${user.password}')),
  //   };
  // }

  static Uri getUrl({required baseUrl ,Map<String,String>? params}){
    if(params == null){
      return Uri.parse(baseUrl);
    }else{
      return Uri.parse(baseUrl).replace(queryParameters: params);
    }
  }
}

//ServiceNowQuery.field("hoge").isEqualTo("hoge").and().field("hogehoge").isNotEmpty();

class ServiceNowQuery{
  //開始
  String string = "";
  static ServiceNowQueryField field(String field){
    return ServiceNowQueryField._(field);
  }
}

class ServiceNowQueryElement{
  //完全なクエリとして機能する単位
  final String string;
  ServiceNowQueryElement._(this.string);

  String end(){
    return string;
  }

  ServiceNowQueryConcatOperator and(){
    //^
    return ServiceNowQueryConcatOperator._("$string^");
  }

  ServiceNowQueryConcatOperator or(){
    //^OR
    return ServiceNowQueryConcatOperator._("$string^OR");
  }
}


class ServiceNowQueryField{
  //次に演算子が来る
  final String string;
  ServiceNowQueryField._(this.string);

  ServiceNowQueryElement isEqualTo(String value){
    //active=true
    return ServiceNowQueryElement._("$string=$value");
  }

  ServiceNowQueryElement isNot(String value){
    //active!=true
    return ServiceNowQueryElement._("$string!=$value");
  }

  ServiceNowQueryElement isEmpty(){
    //activeISEMPTY
    return ServiceNowQueryElement._("${string}ISEMPTY");
  }

  ServiceNowQueryElement isNotEmpty(){
    //activeISNOTEMPTY
    return ServiceNowQueryElement._("${string}ISNOTEMPTY");
  }

  ServiceNowQueryElement isAnything(String value){
    //activeANYTHING
    return ServiceNowQueryElement._("${string}ANYTHING");
  }

  ServiceNowQueryElement isSameAs(String value){
    //activeSAMEASactive
    return ServiceNowQueryElement._("${string}SAMEAS$value");
  }

  ServiceNowQueryElement isDifferentFrom(String value){
    //activeNSAMEASactive
    return ServiceNowQueryElement._("${string}NSAMEAS$value");
  }
}

class ServiceNowQueryConcatOperator{
  final String string;
  ServiceNowQueryConcatOperator._(this.string);

  ServiceNowQueryField field(String field){
    return ServiceNowQueryField._(string + field);
  }
}



