import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_finder/Search/search_single_tuitions.dart';
import 'package:tutor_finder/Widgets/bottom_nav_bar.dart';
import 'package:tutor_finder/Widgets/tuition_widget.dart';

import '../Persistent/persistent.dart';

class TuitionScreen extends StatefulWidget {
  @override
  State<TuitionScreen> createState() => _TuitionScreenState();
}

class _TuitionScreenState extends State<TuitionScreen> {
  String? tuitionCategoryFilter;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _showTuitionCategoriesDialog({required Size size}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Colors.black54,
            title: const Text(
              'Filter Districts',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            content: Container(
              width: size.width * 0.9,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Persistent.tuitionCategoryList.length,
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          tuitionCategoryFilter =
                              Persistent.tuitionCategoryList[index];
                        });
                        Navigator.canPop(context)
                            ? Navigator.pop(context)
                            : null;
                        print(
                            'tuitionCategoryList[index], ${Persistent.tuitionCategoryList[index]}');
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.arrow_right_alt_outlined,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              Persistent.tuitionCategoryList[index],
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    tuitionCategoryFilter = null;
                  });
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: const Text(
                  'Cancel Filter',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Persistent persistentObject = Persistent();
    persistentObject.getMyData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.2, 0.9],
        ),
      ),
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBarForApp(
            indexNum: 0,
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(
              child: Text(
                'Edu Mingle',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 101, 255, 255),
                    Color.fromARGB(255, 57, 128, 250)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.2, 0.9],
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.filter_list_alt,
                color: Colors.black,
              ),
              onPressed: () {
                _showTuitionCategoriesDialog(size: size);
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (c) => SearchScreen()));
                },
              ),
            ],
          ),
          body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('tuitions')
                  .where('tuitionCategory', isEqualTo: tuitionCategoryFilter)
                  .where('hiring', isEqualTo: true)
                  .orderBy('createdAt', descending: false)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data?.docs.isNotEmpty == true) {
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TuitionWidget(
                            subject: snapshot.data?.docs[index]['subject'],
                            tuitionDescription: snapshot.data?.docs[index]
                                ['tuitionDescription'],
                            tuitionId: snapshot.data?.docs[index]['tuitionId'],
                            uploadedBy: snapshot.data?.docs[index]
                                ['uploadedBy'],
                            userImage: snapshot.data?.docs[index]['userImage'],
                            name: snapshot.data?.docs[index]['name'],
                            hiring: snapshot.data?.docs[index]['hiring'],
                            email: snapshot.data?.docs[index]['email'],
                            location: snapshot.data?.docs[index]['location'],
                          );
                        });
                  } else {
                    return const Center(
                      child: Text('There is No Tuitions Available'),
                    );
                  }
                }
                return const Center(
                  child: Text(
                    'Something Went Wrong',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                );
              })),
    );
  }
}
