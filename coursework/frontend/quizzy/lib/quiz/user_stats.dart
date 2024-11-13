class UserStatistic {
  final String username;
  final int score;
  final int sessionCount;
  final String mode;

  UserStatistic({
    required this.username,
    required this.score,
    required this.mode,
    required this.sessionCount,
  });

  // Factory constructor for creating a new UserStatistic instance from JSON data
  factory UserStatistic.fromJson(Map<String, dynamic> json) {
    return UserStatistic(
      username: json['username'],
      score: json['score'] ?? 0,
      sessionCount: json['sessions'] ?? 0,
      mode: json['mode'],
    );
  }
}

// modifying the above class to handle different quiz mode stats from server
class UserStatistics {
  final UserStatistic? normalModeStats;
  final UserStatistic? timedModeStats;

  UserStatistics({this.normalModeStats, this.timedModeStats});

  // Factory constructor to extract UserStatistics from JSON data
  factory UserStatistics.fromJson(List<dynamic> jsonList) {
    UserStatistic? normalStats;
    UserStatistic? timedStats;

    for (var stat in jsonList) {
      var userStat = UserStatistic.fromJson(stat);
      if (userStat.mode == "normal") {
        normalStats = userStat;
      } else if (userStat.mode == "timed") {
        timedStats = userStat;
      }
    }

    return UserStatistics(
      normalModeStats: normalStats,
      timedModeStats: timedStats,
    );
  }
}
