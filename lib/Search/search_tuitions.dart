import 'package:flutter/material.dart';
import 'package:tutor_finder/Tuitions/tuitions_screen.dart';
import 'package:tutor_finder/Widgets/bottom_nav_bar.dart';

import 'card_for_dev.dart';

class AllStudentsScreen extends StatefulWidget {
  @override
  State<AllStudentsScreen> createState() => _AllStudentsScreenState();
}

class _AllStudentsScreenState extends State<AllStudentsScreen> {
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
        bottomNavigationBar: BottomNavigationBarForApp(
          indexNum: 1,
        ),
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [
        //           Color.fromARGB(255, 101, 255, 255),
        //           Color.fromARGB(255, 57, 128, 250)
        //         ],
        //         begin: Alignment.centerLeft,
        //         end: Alignment.centerRight,
        //         stops: [0.2, 0.9],
        //       ),
        //     ),
        //   ),
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.pushReplacement(context,
        //           MaterialPageRoute(builder: (context) => TuitionScreen()));
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/devad.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black54,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    '(Beta)',
                    style: TextStyle(
                        color: Color.fromARGB(255, 58, 242, 255),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'BE A DELUXE TUTOR',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Deluxe Tutors are 6X more likely to get hired',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.blueAccent,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 56),
                  const Center(
                    child: Text(
                      'Benifits of becoming a deluxe tutor',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      CardItem(
                        icon: Icons.star,
                        title: 'Influence',
                        text:
                            'You have a larger platform to share your knowledge and expertise',
                      ),
                      CardItem(
                        icon: Icons.money_off_csred_outlined,
                        title: 'Salary',
                        text:
                            'These endeavors can lead to additional income streams beyond regular teaching',
                      ),
                      CardItem(
                        icon: Icons.thumb_up,
                        title: 'Recognition',
                        text:
                            'Can Bring a sense of recognition for your hard work and dedication to education',
                      ),
                      CardItem(
                        icon: Icons.home_max_rounded,
                        title: 'Career',
                        text:
                            'can open doors to various career opportunities and positions in educational institutions',
                      ),
                    ],
                  ),
                  const SizedBox(height: 46),
                  const Center(
                    child: Text(
                      'HOW BE A DELUXE TUTOR?',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 230, 0),
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Send Your CV to us on :',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Row(
                    children: [
                      Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'aagalib2323@gmail.com',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'We may take a short interview of you and maybe a demo class on basis of which you will be ranked on your deluxe level.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(height: 36),
                  const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.copyright,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'All Rights Reserved By',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Center(
                    child: Text(
                      'PG SOLUTIONS LTD',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
