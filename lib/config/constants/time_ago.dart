extension TimeAgo on DateTime {
  String timeAgo() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inMinutes < 1) {
      return 'Justo ahora';
    } else if (difference.inMinutes < 60) {
      return 'Hace ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Hace ${difference.inHours} h';
    } else if (difference.inDays < 7) {
      return difference.inDays == 1
        ? 'Hace 1 día'
        : 'Hace ${difference.inDays} días';
    } else {
      return 'Hace ${(difference.inDays / 7).floor()} sem';
    }
  }
}
