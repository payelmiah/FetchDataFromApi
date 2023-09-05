import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String? stringResponse;
Map? mapResponse;
Map? dataResponse;
List? listResponse;

class _HomeState extends State<Home> {

  Future apicall() async{
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if(response.statusCode == 200){
      setState(() {
        //stringResponse = response.body;
        mapResponse = json.decode( response.body);
        listResponse = mapResponse!['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('API')),
      ),
      /*body:  Center(
        child: Container(
          height: 200,
          width: 200,
          child: Center(
              child: listResponse ==null?  Text('Data is loading'): Text(listResponse![0]['first_name'].toString())),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blue,

          ),
        ),
      ), */
      body: ListView.builder(
          itemCount: listResponse == null? 0: listResponse!.length,
        itemBuilder: (context , index) {
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(listResponse![index]['avatar']),
                  ),
                  Text(listResponse![index]['id'].toString()),
                  Text(listResponse![index]['email'].toString()),
                  Text(listResponse![index]['first_name'].toString()),
                  Text(listResponse![index]['last_name'].toString()),

                ],
              ),
            );
        },
      ),
    );
  }
}
