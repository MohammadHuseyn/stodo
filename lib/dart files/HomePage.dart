import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            children: [
              Container(
                decoration: new BoxDecoration(boxShadow: [
                  new BoxShadow(
                      color: Colors.indigo, blurRadius: 100, spreadRadius: 0.01)
                ]),
                child: Card(
                  margin: EdgeInsets.all(25),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: CircleAvatar(
                          minRadius: MediaQuery.of(context).size.width * 0.16,
                          backgroundImage: const AssetImage("avatar.png"),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Name",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 25),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "username",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 130,left: 10),
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container());
  }
}
