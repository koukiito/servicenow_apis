import 'package:flutter/material.dart';
import 'package:servicenow_apis/now/table/v2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  ServiceNowUser user = ServiceNowUser(instance: ServiceNowInstance(name: 'YOUR INSTANCE NAME'), username: 'YOUR USER NAME', password: 'PASSWORD');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder(
          future: TableApi(user: user).getRecords(tableName: 'incident',params: {'sysparm_query': ServiceNowQuery.field('active').isEqualTo('true').end(),'sysparm_limit': '3'}),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  for (var record in snapshot.data!.body.records)
                    ListTile(
                      title: Text(record.fields['short_description']),
                      subtitle: Text(record.fields['number']),
                    )
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
