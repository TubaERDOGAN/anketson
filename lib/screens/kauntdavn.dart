import 'dart:async';

class CountdownTimer {
  final DateTime endTime;

  CountdownTimer(this.endTime);

  Stream<String> get remainingTime {
    Duration remaining = endTime.difference(DateTime.now());
    return Stream.periodic(Duration(seconds: 1), (_) {
      remaining = remaining - Duration(seconds: 1);
      return _formatDuration(remaining);
    }).takeWhile((value) => remaining.inSeconds > 0);
  }

  String _formatDuration(Duration duration) {
    return '${duration.inDays}:${duration.inHours.remainder(24)}:${duration.inMinutes.remainder(60)}:${duration.inSeconds.remainder(60)}';
  }
}