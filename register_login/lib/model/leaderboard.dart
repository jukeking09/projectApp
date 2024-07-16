class LeaderboardEntry {
  final int userId;
  final int score;
  final String email; // Assuming this is retrieved from backend

  LeaderboardEntry({
    required this.userId,
    required this.score,
    required this.email,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic>? json) {
    return LeaderboardEntry(
      userId: json?['user_id'] ?? 0, // Handle null or default to 0
      score: json?['score'] != null ? int.parse(json?['score']) : 0, // Convert String to int or default to 0
      email: json?['email'] ?? 'Unknown User', // Handle null or default
    );
  }
}
