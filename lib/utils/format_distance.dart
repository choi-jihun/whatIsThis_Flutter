String formatDistance(double distance) {
  if (distance >= 1000) {
    return '${(distance / 1000).toStringAsFixed(2)}km';
  } else {
    return '${distance}m';
  }
}
