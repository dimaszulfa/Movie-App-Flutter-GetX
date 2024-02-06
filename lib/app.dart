import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/controllers/controller.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
        final Controller c = Get.put(Controller());
        c.getData();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
      ),
      body: Text("hallo")
    );
  }
}

class Other extends StatelessWidget {
  Other({super.key});

  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${c.obj["results"][0]["adult"].toString()}"),
      ),
    );
  }
}
