class FeatureData {
  final String title;
  final String description;
  final String? image;

  const FeatureData({
    required this.title,
    required this.description,
    this.image,
  });
}