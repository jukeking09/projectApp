import 'package:flutter/material.dart';
import 'package:register_login/api/api.dart';
import 'package:register_login/dailystreaks.dart';
import 'package:register_login/model/alphabet.dart';
import 'package:register_login/model/completion.dart';
import 'package:register_login/home.dart';
import 'package:register_login/model/leaderboard.dart';
import 'package:register_login/model/lesson.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:register_login/style/buttonstyle.dart';
import 'package:register_login/userLanguages.dart';
import 'package:register_login/userid.dart';

late int userId;
late String userEmail;
final player = AudioPlayer();

class HomePage2 extends StatefulWidget {
  final int languageId;

  const HomePage2({Key? key, required this.languageId}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage2> {
  late Future<List<LessonWithCompletion>> futureLessons;
  int pageIndex = 0;
  late int userId = 0;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
    futureLessons = ApiService.fetchLessonsWithCompletionStatus(widget.languageId, userId);
  }

  Future<void> _getUserDetails() async {
    userId = (await UserIdStorage.getUserId())!;
    final responseData = await ApiService.getUserDetail(userId);
    setState(() {
      userEmail = responseData['email'];
    });
    await _updateStreak();
    await _fetchLessons(); // Fetch lessons after user details are loaded
  }

  Future<void> _fetchLessons() async {
  setState(() {
    futureLessons = ApiService.fetchLessonsWithCompletionStatus(widget.languageId, userId);
  });
}


 Future<void> _updateStreak() async {
  StreakManager streakManager = StreakManager(userId);
  int previousStreak = await streakManager.getStreak();
  await streakManager.updateStreakAfterLogin();
  int currentStreak = await streakManager.getStreak();
  
  if (currentStreak > previousStreak) {
    _showStreakIncreasedDialog(currentStreak);
  }
}

void _showStreakIncreasedDialog(int newStreak) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Streak Increased!'),
        content: Text('Your streak has increased to $newStreak days. Keep it up!'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildLessonsPage(),
      Page2(languageId: widget.languageId),
      const Page3(),
      const Page4(),
    ];
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        automaticallyImplyLeading: true,
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
      body: FutureBuilder<List<LessonWithCompletion>>(
        future: futureLessons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No lessons available'));
          } else {
            List<LessonWithCompletion> lessons = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Number of columns in the grid
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                LessonWithCompletion lesson = lessons[index];
                return LessonCard(
  title: lesson.title,
  subtitle: lesson.description,
  lessonId: lesson.id,
  isCompleted: lesson.isCompleted,
  onTap: () {
    if (index == 0 || lessons[index - 1].isCompleted) {
      Navigator.pushNamed(
        context,
        '/lesson1',
        arguments: {'lessonId': lesson.id},
      ).then((_) {
        _fetchLessons(); // Refresh lessons after completing a lesson
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete previous lessons to unlock this lesson.'),
        ),
      );
    }
  },
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
  final bool isCompleted;
  final VoidCallback onTap;

  const LessonCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.lessonId,
    required this.isCompleted,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: onTap,
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

class Page2 extends StatefulWidget {
  final int languageId;

  const Page2({Key? key, required this.languageId}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late Future<List<Alphabet>> futureAlphabets;

  @override
  void initState() {
    super.initState();
    futureAlphabets = ApiService.fetchAlphabets(widget.languageId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Alphabet>>(
        future: futureAlphabets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No alphabets available'));
          } else {
            List<Alphabet> alphabets = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: alphabets.length,
              itemBuilder: (context, index) {
                Alphabet alphabet = alphabets[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: buttonAlphabet,
                    onPressed: () async {
                      _playAudio(alphabet.audioUrl);
                    },
                    child: Text(alphabet.alphabet),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

void _playAudio(String url) async {
  AudioPlayer audioPlayer = AudioPlayer();
  try {
    await audioPlayer.play(AssetSource(url));
  } catch (e) {
    print('Error playing audio: $e');
  }
}

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  late Future<List<LeaderboardEntry>> leaderboardDataFuture;

  @override
  void initState() {
    super.initState();
    // Initially fetch leaderboard data
    leaderboardDataFuture = ApiService.fetchLeaderboard();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch leaderboard data whenever the widget's dependencies change (e.g., tab selection)
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
  int userId = 0;

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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserLanguagesPage(userId: userId),
                    ),
                  );
                },
                child: const Text('View Progress'),
              ),
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
