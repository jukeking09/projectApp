import 'package:shared_preferences/shared_preferences.dart';

class StreakManager {
  static const String _streakKeyPrefix = 'daily_streak_';
  static const String _lastLoginKeyPrefix = 'last_login_date_';

  final int userId;

  StreakManager(this.userId);

  String get _streakKey => '$_streakKeyPrefix$userId';
  String get _lastLoginKey => '$_lastLoginKeyPrefix$userId';

  Future<int> getStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_streakKey) ?? 0;
  }

  Future<void> incrementStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentStreak = prefs.getInt(_streakKey) ?? 0;
    await prefs.setInt(_streakKey, currentStreak + 1);
  }

  Future<void> resetStreak() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_streakKey, 0);
  }

  Future<void> updateStreakAfterLogin() async {
    DateTime now = DateTime.now();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? lastLoginDateString = prefs.getString(_lastLoginKey);
    if (lastLoginDateString != null) {
      DateTime lastLoginDate = DateTime.parse(lastLoginDateString);
      if (!_isSameDay(now, lastLoginDate)) {
        if (_isNextDay(now, lastLoginDate)) {
          await incrementStreak();
        } else {
          await resetStreak();
          await incrementStreak(); // Start a new streak
        }
      }
    } else {
      await incrementStreak(); // First time login
    }

    await prefs.setString(_lastLoginKey, now.toIso8601String());
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  bool _isNextDay(DateTime d1, DateTime d2) {
    DateTime nextDay = DateTime(d2.year, d2.month, d2.day + 1);
    return _isSameDay(d1, nextDay);
  }
}
