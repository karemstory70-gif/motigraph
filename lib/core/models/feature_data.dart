enum FeatureType {
  course,
  training,
  service,
}

class DetailSection {
  final String title;
  final String description;
  final List<String> points;

  const DetailSection({
    required this.title,
    required this.description,
    this.points = const [],
  });
}

sealed class FeatureData {
  final String title;
  final String description;
  final String? image;

  final String detailsTitle;
  final String detailsDescription;

  final List<DetailSection> sections;

  /// Optional preview video.
  /// If null or empty, no video section is shown.
  final String? videoUrl;

  final FeatureType type;

  const FeatureData({
    required this.title,
    required this.description,
    this.image,
    required this.detailsTitle,
    required this.detailsDescription,
    this.sections = const [],
    this.videoUrl,
    required this.type,
  });
}

class ServiceData extends FeatureData {
  const ServiceData({
    required super.title,
    required super.description,
    super.image,
    required super.detailsTitle,
    required super.detailsDescription,
    super.sections,
    super.videoUrl,
  }) : super(
    type: FeatureType.service,
  );
}

class CourseData extends FeatureData {
  const CourseData({
    required super.title,
    required super.description,
    super.image,
    required super.detailsTitle,
    required super.detailsDescription,
    super.sections,
    super.videoUrl,
  }) : super(
    type: FeatureType.course,
  );
}

class TrainingData extends FeatureData {
  const TrainingData({
    required super.title,
    required super.description,
    super.image,
    required super.detailsTitle,
    required super.detailsDescription,
    super.sections,
    super.videoUrl,
  }) : super(
    type: FeatureType.training,
  );
}