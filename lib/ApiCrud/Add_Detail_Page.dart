import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modelClass.dart';

class Add_Detail_Page extends StatefulWidget{
  dynamic map;
  Add_Detail_Page(this.map);
  var nameController=TextEditingController();
  var imageController=TextEditingController();
  @override
  State<Add_Detail_Page> createState() => _Add_Detail_PageState();
}

class _Add_Detail_PageState extends State<Add_Detail_Page> {

  @override
  void initState() {
    widget.nameController.text=widget.map==null?'':widget.map['name'];
    widget.imageController.text=widget.map==null?'':widget.map['avatar'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Enter Name "),
              controller: widget.nameController,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: widget.imageController,
              decoration: InputDecoration(hintText: "Enter Path Of Image "),
            ),
          ),
          Center(
            child: Container(
              child: ElevatedButton(
                  onPressed: () async {
                    if(widget.map==null){
                      await addData().then((value){});
                    }else{
                      await editData().then((value){
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text("submit")),
            ),
          )
        ],
      ),
    );
  }

  Future<void> addData()async{
    // var map={};
    // map['name']=widget.nameController.text;
    // map['avatar']=widget.imageController.text;
    // var res=await http.post(Uri.parse("https://64a23471b45881cc0ae4e04a.mockapi.io/faculties"),body: map);

    ApiModel user=ApiModel();
    user.name=widget.nameController.text;
    user.avatar=widget.imageController.text;
    var map=user.mapConverter();
    await http.post(Uri.parse("https://64a23471b45881cc0ae4e04a.mockapi.io/faculties"),body: map);
  }

  Future<void> editData()async{
    // var map={};
    // map['name']=widget.nameController.text;
    // map['avatar']=widget.imageController.text;

    ApiModel user=ApiModel();
    user.name=widget.nameController.text;
    user.avatar=widget.imageController.text;
    var map=user.mapConverter();
    await http.put(Uri.parse("https://64a23471b45881cc0ae4e04a.mockapi.io/faculties/"+widget.map!['id'].toString()),body: map);
  }
}