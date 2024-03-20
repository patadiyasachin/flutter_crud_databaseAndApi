import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Add_Detail_Page.dart';
class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'API CRUD',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          Container(
            margin: EdgeInsets.all(10),
            child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return Add_Detail_Page(null);
                  })).then((value){
                    setState(() {});
                  });
                },
                child: Icon(Icons.add)
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: getDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: 100,
                          child: Image.network(snapshot.data![index]["avatar"].toString())
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                              style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                              snapshot.data![index]['name'].toString()),
                        ),
                      ),
                      Container(
                        child: InkWell(
                            onTap: (){
                              deleteData(snapshot.data![index]['id']).then((value){
                                setState(() {});
                              });
                            },
                            child: Icon(Icons.delete,color: Colors.red,size: 40)
                        ),
                      ),
                      Container(
                        child: InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return Add_Detail_Page(snapshot.data![index]);
                              })).then((value){
                                setState(() {});
                              });
                            },
                            child: Icon(Icons.mode_edit_sharp,color: Colors.yellow,size: 40,)
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }

          else if(snapshot.hasError){
            return Center(child: Text("${snapshot.error}"));
          }

          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List> getDetails() async {
    var res = await http.get(Uri.parse("https://64a23471b45881cc0ae4e04a.mockapi.io/faculties"));
    print("Data is ${res.body}");
    return jsonDecode(res.body);
  }

  Future<void> deleteData(id) async {
    await http.delete(Uri.parse("https://64a23471b45881cc0ae4e04a.mockapi.io/faculties/"+id));
  }
}
