import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutor_finder/Services/global_methods.dart';
import 'package:tutor_finder/Services/global_variables.dart';
import 'package:tutor_finder/Tuitions/tuitions_screen.dart';
import 'package:tutor_finder/Widgets/comments_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:uuid/uuid.dart';

class TuitionDetailsScreen extends StatefulWidget {
  final String uploadedBy;
  final String tuitionId;

  const TuitionDetailsScreen({
    required this.uploadedBy,
    required this.tuitionId,
  });

  @override
  State<TuitionDetailsScreen> createState() => _TuitionDetailsScreenState();
}

class _TuitionDetailsScreenState extends State<TuitionDetailsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _commentController = TextEditingController();
  bool _isCommenting = false;

  String? authorName;
  String? userImageUrl;
  String? tuitionCategory;
  String? tuitionDescription;
  String? subject;
  bool? hiring;
  Timestamp? postedDateTimeStamp;
  Timestamp? deadlineDateTimeStamp;
  String? postedDate;
  String? deadlineDate;
  String? location = '';
  String? email = '';
  int hiredBy = 0;
  bool isDeadlineAvailable = false;
  bool showComment = false;

  void getTuitionData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uploadedBy)
        .get();

    if (userDoc == null) {
      return;
    } else {
      setState(() {
        authorName = userDoc.get('name');
        userImageUrl = userDoc.get('userImage');
      });
    }
    final DocumentSnapshot tuitionDatabase = await FirebaseFirestore.instance
        .collection('tuitions')
        .doc(widget.tuitionId)
        .get();
    if (tuitionDatabase == null) {
      return;
    } else {
      setState(() {
        subject = tuitionDatabase.get('subject');
        tuitionDescription = tuitionDatabase.get('tuitionDescription');
        hiring = tuitionDatabase.get('hiring');
        email = tuitionDatabase.get('email');
        location = tuitionDatabase.get('location');
        hiredBy = tuitionDatabase.get('hiredBy');
        postedDateTimeStamp = tuitionDatabase.get('createdAt');
        deadlineDateTimeStamp = tuitionDatabase.get('deadlineDateTimeStamp');
        deadlineDate = tuitionDatabase.get('availability');
        var postDate = postedDateTimeStamp!.toDate();
        postedDate = '${postDate.year}-${postDate.month}-${postDate.day}';
      });

      var date = deadlineDateTimeStamp!.toDate();
      isDeadlineAvailable = date.isAfter(DateTime.now());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTuitionData();
  }

  Widget dividerWidget() {
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  hireTutor() {
    final Uri params = Uri(
        scheme: 'mailto',
        path: email,
        query:
            'subject=Inquiry Regarding Tutoring Services&body=I am eager to commence our tutoring sessions and gain valuable knowledge from your expertise. Please let me know when you are available for a brief consultation or if there is a convenient time for us to connect and Please send me your contacts.');
    final url = params.toString();
    launchUrlString(url);
    addNewHirers();
  }

  void addNewHirers() async {
    var docRef =
        FirebaseFirestore.instance.collection('tuitions').doc(widget.tuitionId);
    docRef.update({
      'hiredBy': hiredBy + 1,
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              size: 40,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TuitionScreen()));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            subject == null ? '' : subject!,
                            maxLines: 3,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Color.fromARGB(172, 12, 11, 15),
                                ),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    userImageUrl == null
                                        ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/User-avatar.svg/2048px-User-avatar.svg.png'
                                        : userImageUrl!,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    authorName == null ? '' : authorName!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    location!,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 105, 105, 105),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        dividerWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.how_to_reg_sharp,
                              color: Color.fromARGB(255, 105, 105, 105),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Tuition Requests Recieved : ',
                              style: TextStyle(
                                color: Color.fromARGB(255, 105, 105, 105),
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              hiredBy.toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        FirebaseAuth.instance.currentUser!.uid !=
                                widget.uploadedBy
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerWidget(),
                                  const Text(
                                    'Hiring : ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          User? user = _auth.currentUser;
                                          final _uid = user!.uid;
                                          if (_uid == widget.uploadedBy) {
                                            try {
                                              // ignore: avoid_single_cascade_in_expression_statements
                                              FirebaseFirestore.instance
                                                  .collection('tuitions')
                                                ..doc(widget.tuitionId)
                                                    .update({'hiring': true});
                                            } catch (error) {
                                              GlobalMethod.showErrorDialog(
                                                error:
                                                    'Action cannot be performed ',
                                                ctx: context,
                                              );
                                            }
                                          } else {
                                            GlobalMethod.showErrorDialog(
                                              error:
                                                  'You Cannot Perform This Action',
                                              ctx: context,
                                            );
                                          }
                                          getTuitionData();
                                        },
                                        child: const Text(
                                          'ON',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Opacity(
                                        opacity: hiring == true ? 1 : 0,
                                        child: const Icon(
                                          Icons.check_box,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 40,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          User? user = _auth.currentUser;
                                          final _uid = user!.uid;
                                          if (_uid == widget.uploadedBy) {
                                            try {
                                              // ignore: avoid_single_cascade_in_expression_statements
                                              FirebaseFirestore.instance
                                                  .collection('tuitions')
                                                ..doc(widget.tuitionId)
                                                    .update({'hiring': false});
                                            } catch (error) {
                                              GlobalMethod.showErrorDialog(
                                                error:
                                                    'Action cannot be performed ',
                                                ctx: context,
                                              );
                                            }
                                          } else {
                                            GlobalMethod.showErrorDialog(
                                              error:
                                                  'You Cannot Perform This Action',
                                              ctx: context,
                                            );
                                          }
                                          getTuitionData();
                                        },
                                        child: const Text(
                                          'OFF',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                      Opacity(
                                        opacity: hiring == false ? 1 : 0,
                                        child: const Icon(
                                          Icons.check_box,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                        dividerWidget(),
                        const Text(
                          'Tuition Description',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          tuitionDescription == null ? '' : tuitionDescription!,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        //dividerWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            isDeadlineAvailable
                                ? 'Actively Accepting Tuition Request'
                                : 'Currently Not Recieving Tuition Request',
                            style: TextStyle(
                              color: isDeadlineAvailable
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Center(
                          child: MaterialButton(
                            onPressed: () {
                              hireTutor();
                            },
                            color: Colors.blueAccent,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                'Hire Now',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        dividerWidget(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Uploaded On : ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              postedDate == null ? '' : postedDate!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Available Upto : ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              deadlineDate == null ? '' : deadlineDate!,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        dividerWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          child: _isCommenting
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: TextField(
                                        controller: _commentController,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        maxLength: 200,
                                        keyboardType: TextInputType.text,
                                        maxLines: 6,
                                        decoration: const InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: MaterialButton(
                                              onPressed: () async {
                                                if (_commentController
                                                        .text.length <
                                                    7) {
                                                  GlobalMethod.showErrorDialog(
                                                    error:
                                                        'Comment cannot be Less than 7 Characters',
                                                    ctx: context,
                                                  );
                                                } else {
                                                  final _generatedId =
                                                      const Uuid().v4();
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('tuitions')
                                                      .doc(widget.tuitionId)
                                                      .update({
                                                    'tuitionComments':
                                                        FieldValue.arrayUnion([
                                                      {
                                                        'userId': FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid,
                                                        'commentId':
                                                            _generatedId,
                                                        'name': name,
                                                        'userImageUrl':
                                                            userImage,
                                                        'commentBody':
                                                            _commentController
                                                                .text,
                                                        'time': Timestamp.now(),
                                                      }
                                                    ]),
                                                  });
                                                  await Fluttertoast.showToast(
                                                    msg:
                                                        'Your comment has been added',
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                    backgroundColor:
                                                        Colors.grey,
                                                    fontSize: 18.0,
                                                  );
                                                  _commentController.clear();
                                                }
                                                setState(() {
                                                  showComment = true;
                                                });
                                              },
                                              color: Colors.blueAccent,
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: const Text(
                                                'Post',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _isCommenting = !_isCommenting;
                                                showComment = false;
                                              });
                                            },
                                            child: const Text(
                                              'Cancel',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Comments ',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isCommenting = !_isCommenting;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add_comment,
                                        color: Colors.blueAccent,
                                        size: 40,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          showComment = true;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.arrow_drop_down_circle,
                                        color: Colors.blueAccent,
                                        size: 40,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        showComment == false
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: FutureBuilder<DocumentSnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection('tuitions')
                                      .doc(widget.tuitionId)
                                      .get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      if (snapshot.data == null) {
                                        const Center(
                                          child: Text(
                                              'No Comments For this Tuition'),
                                        );
                                      }
                                    }
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return CommentWidget(
                                          commentId:
                                              snapshot.data!['tuitionComments']
                                                  [index]['commentId'],
                                          commenterId:
                                              snapshot.data!['tuitionComments']
                                                  [index]['userId'],
                                          commenterName:
                                              snapshot.data!['tuitionComments']
                                                  [index]['name'],
                                          commentBody:
                                              snapshot.data!['tuitionComments']
                                                  [index]['commentBody'],
                                          commenterImageUrl:
                                              snapshot.data!['tuitionComments']
                                                  [index]['userImageUrl'],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return const Divider(
                                          thickness: 1,
                                          color: Colors.grey,
                                        );
                                      },
                                      itemCount: snapshot
                                          .data!['tuitionComments'].length,
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
