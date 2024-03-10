

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:register_login/api.dart';
import 'package:register_login/style/buttonstyle.dart';
import 'package:register_login/userid.dart';

late int userId; // Declare userId as late, we'll initialize it in initState
late String userEmail;
final player=AudioPlayer();


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  
  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }
  _getUserDetails() async {
    userId = await UserIdStorage.getUserId() as int; // Wait for the result
    final responseData = await ApiService.getUserDetail(userId);//get Data from Api
    userEmail = await responseData['email'];
    print(userId);//test
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const Page1(),
      const Page2(),
      const Page3(),
      const Page4(),
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "ByeLingual",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 224, 3, 102),
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.pinkAccent,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? const Icon(
                    Icons.home_filled,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? const Icon(
                    Icons.work_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.work_outline_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? const Icon(
                    Icons.widgets_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.widgets_outlined,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 3;
              });
            },
            icon: pageIndex == 3
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 35,
                  ),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Lessons'),
      ),
      body: GridView.count(
        crossAxisCount: 1, // Number of columns in the grid
        children: [
          const LessonCard(title: 'Lesson 1', subtitle: 'Basic Vocabulary'),
          const LessonCard(title: 'Lesson 2', subtitle: 'Grammar Essentials'),
          // Add more LessonCard widgets for additional lessons
        ],
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const LessonCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          // Add navigation to lesson details
        },
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MaterialButton(
              enableFeedback: false,
              // style: buttonAlphabet,
              onPressed: () async{
                await player.play(AssetSource('sounds/a a.m4a'));
              },
              child: Text('a'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: buttonAlphabet,
              onPressed: () => {

              },
              child: Text('b'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: buttonAlphabet,
              onPressed: () => {

              },
              child: Text('k'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: buttonAlphabet,
              onPressed: () => {

              },
              child: Text('d'),
            ),
          ),
        ],
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Center(
        child: Text(
          "Page Number 3",
          style: TextStyle(
          color: Colors.blue[900],
          fontSize: 45,
          fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Dashboard')),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 224, 3, 102),
                radius: 60,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 20),
              _buildUserDetail("User Email:", userEmail),
              const SizedBox(height: 10),
              _buildUserDetail("User ID:", "$userId"),
              const SizedBox(height: 30),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserDetail(String title, String detail) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          detail,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
