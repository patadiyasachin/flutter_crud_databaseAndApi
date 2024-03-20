import 'package:crud_evaluation/AddDetail.dart';
import 'package:crud_evaluation/MyDatabase.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("home page"),actions: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddDetail(null);
            },)).then((value) {
              setState(() {

              });
            },);
          },
            child: Icon(Icons.add))
      ]),
      body: FutureBuilder(
        future: MyDatabase().getAllStudent(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount:snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      children: [
                        Text("${snapshot.data[index]['name']}"),
                        ElevatedButton(onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return AddDetail(snapshot.data![index]);
                          },)).then((value) {
                            setState(() {});
                          },);
                        }, child: Icon(Icons.edit)),
                        ElevatedButton(onPressed: () async {
                            await MyDatabase().deleteStudent(snapshot.data![index]['id']).then((value) {
                              setState(() {});
                            },);
                        }, child:Icon(Icons.delete))
                      ],
                    ),
                  );
                },);
          }
          else if(snapshot.hasError){
            return Text("${snapshot.error}");
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
