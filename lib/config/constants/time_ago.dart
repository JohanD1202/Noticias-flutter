extension TimeAgo on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inMinutes < 1) {
      return 'Right now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} h ago';
    } else if (difference.inDays < 7) {
      return difference.inDays == 1
        ? '1 day ago'
        : '${difference.inDays} days ago';
    } else {
      return '${(difference.inDays / 7).floor()} week';
    }
  }
}
