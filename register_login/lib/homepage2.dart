import 'package:flutter/material.dart';
import 'package:register_login/api/api.dart';
import 'package:register_login/dailystreaks.dart';
// import 'package:register_login/home.dart';
import 'package:register_login/model/leaderboard.dart';
import 'package:register_login/model/lesson.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:register_login/style/buttonstyle.dart';
import 'package:register_login/userid.dart';
late int userId;
late String userEmail;
final player=AudioPlayer();
class HomePage1 extends StatefulWidget {
  final int languageId;

  const HomePage1({super.key, required this.languageId});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  late Future<List<Lesson>> futureLessons;
  int pageIndex = 0;
  int userId = 0;
  String userEmail = '';
  
  @override
  void initState() {
    super.initState();
    _getUserDetails();
    futureLessons = ApiService.fetchLessons(widget.languageId);
  }

  _getUserDetails() async {
    userId = (await UserIdStorage.getUserId())!;
    final responseData = await ApiService.getUserDetail(userId);
    userEmail = responseData['email'];
    await _updateStreak();
  }

  Future<void> _updateStreak() async {
    StreakManager streakManager = StreakManager(userId);
    await streakManager.updateStreakAfterLogin();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildLessonsPage(),
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

  Widget _buildLessonsPage() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Lessons'),
      ),
      body: FutureBuilder<List<Lesson>>(
        future: futureLessons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No lessons available'));
          } else {
            List<Lesson> lessons = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of columns in the grid
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                Lesson lesson = lessons[index];
                return LessonCard(
                  title: lesson.title,
                  subtitle: lesson.description,
                  lessonId: lesson.id,
                );
              },
            );
          }
        },
      ),
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
                    Icons.book_online,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.book_online_outlined,
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
                    Icons.leaderboard_rounded,
                    color: Colors.white,
                    size: 35,
                  )
                : const Icon(
                    Icons.leaderboard_outlined,
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

class LessonCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int lessonId;

  const LessonCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.lessonId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/lesson1',
            arguments: {'lessonId': lessonId},
          );
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
  const Page2({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: buttonAlphabet,
              onPressed: () async {
                await player.play(AssetSource('sounds/a a.m4a'));
              },
              child: const Text('a'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: buttonAlphabet,
              onPressed: () async {
                await player.play(AssetSource('sounds/b.m4a'));
              },
              child: const Text('b'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: buttonAlphabet,
              onPressed: () async {
                await player.play(AssetSource('sounds/k.m4a'));
              },
              child: const Text('k'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: buttonAlphabet,
              onPressed: () async {
                await player.play(AssetSource('sounds/d.m4a'));
              },
              child: const Text('d'),
            ),
          ),
        ],
      ),
    );
  }
}

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  late Future<List<LeaderboardEntry>> leaderboardDataFuture;

  @override
  void initState() {
    super.initState();
    leaderboardDataFuture = ApiService.fetchLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: FutureBuilder<List<LeaderboardEntry>>(
        future: leaderboardDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No leaderboard data available'));
          } else {
            List<LeaderboardEntry> leaderboardData = snapshot.data!;
            return ListView.builder(
              itemCount: leaderboardData.length,
              itemBuilder: (context, index) {
                final entry = leaderboardData[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(entry.email),
                  trailing: Text('${entry.score}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Page4 extends StatefulWidget {

  const Page4({super.key});

  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  int streak = 0; // Placeholder for streak count
  String userEmail = ''; // Placeholder for user email
  int userId=0;
  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  _loadUserDetails() async {
    userId = (await UserIdStorage.getUserId())!;
    final responseData = await ApiService.getUserDetail(userId);
    userEmail = responseData['email'];
    await _loadStreak(userId);
  }

  Future<void> _loadStreak(int userId) async {
    StreakManager streakManager = StreakManager(userId);
    int savedStreak = await streakManager.getStreak();

    setState(() {
      streak = savedStreak;
    });
  }

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
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 224, 3, 102),
                radius: 60,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
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
              const SizedBox(height: 10),
              _buildUserDetail("Streak:", "$streak"), // Display streak here
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
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          detail,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
