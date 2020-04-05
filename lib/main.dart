



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:randomticketgenerator/ticket.dart';
import 'package:randomticketgenerator/ticket_generator.dart';
import 'package:screenshot/screenshot.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScreenshotController screenshotController = ScreenshotController();
  List<List<String>> _gridState = ListGenerator.generateTicketList();
  File _imageFile;
  final _nameController = TextEditingController();
  String _name = "";
  Future<void> permitGallery() async {

      if (await Permission.storage
          .request()
          .isGranted)
        return;
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      print(statuses[Permission.storage]);

    return;
  }
  @override
  void initState(){
    super.initState();
    permitGallery();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "TicketGenerator",
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 100,),
              Screenshot(
                controller: screenshotController,
              child: Card(
                child: Ticket(gridState: _gridState,name: _name,),
              )
              ),
              SizedBox(height: 40,),
              RaisedButton(
                child: Text('GENERATE TICKET'),
                elevation: 8.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                onPressed: () {
                  String name = _nameController.text;
                  setState(() {
                    _name = name;
                    _gridState = ListGenerator.generateTicketList();
                  });
                },
              ),
              SizedBox(height: 100.0,),
              RaisedButton(
                child: Text('TAKE SCREENSHOT'),
                elevation: 8.0,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                onPressed: () {
                  screenshotController.capture().then((image) async {
                    final result = await ImageGallerySaver.saveImage(image.readAsBytesSync());
                    print(result.toString());
                  }).catchError((onError) {
                    print(onError);
                  });
                },
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}