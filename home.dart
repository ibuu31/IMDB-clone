import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'authController.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firestore = FirebaseFirestore.instance;

  Future getPosts() async {
    QuerySnapshot qn = await firestore.collection("movie").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: Text('Do you want to exit an App?'),
              actions: [
                IconButton(
                    onPressed: () {
                      AuthController.logOut();
                    },
                    icon: Icon(Icons.logout)),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => SystemChannels.platform
                      .invokeMethod('SystemNavigator.pop'),
                  //return true when click on "Yes"
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                  child: Card(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('categories')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var snap = snapshot.data;
                          return ListView.builder(
                              itemCount: snap.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var snaps = snapshot.data.docs[index];
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color: Colors.amber),
                                      height: 30,
                                      width: 90,
                                      margin: EdgeInsets.all(10),
                                      // color: Colors.black87,
                                      child: Center(
                                        child: Text(
                                          snaps['name'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Featured Today: ",
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Poppins',
                      color: Colors.amber.shade600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                  child: Card(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('movies')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          var snap = snapshot.data;
                          return ListView.builder(
                              itemCount: snap.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var snaps = snapshot.data.docs[index];
                                return Column(
                                  children: [
                                    Container(
                                      height: 190,
                                      width: 150,
                                      margin: EdgeInsets.all(10),
                                      color: Colors.black87,
                                      child: Center(
                                        child: Image.network(
                                          snaps['Thumbnail'],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: [
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              Text(
                                                snaps['Rating'].toString(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            snaps['Name'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            snaps['Year'],
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              });
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addData() {
    firestore.collection('users').doc('JLVT8wlqA5gvYAYAbFsZ').set({
      "name": "ibuu",
      "email": "ib@gmail.com",
      "phone": "123456",
      'char': FieldValue.arrayUnion(['actor', 'actress', 'villain'])
    });
  }
  // void retriveData(){
  //   firestore.collection('users').doc('JLVT8wlqA5gvYAYAbFsZ').snapshots();
  // }
}
