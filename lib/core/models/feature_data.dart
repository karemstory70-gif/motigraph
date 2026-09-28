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
  final String? videoUrl;

  final FeatureType type;

  /// Original price.
  final double? price;

  /// Discount percentage.
  /// Example: 20 means 20%.
  final double? discount;

  const FeatureData({
    required this.title,
    required this.description,
    this.image,
    required this.detailsTitle,
    required this.detailsDescription,
    this.sections = const [],
    this.videoUrl,
    required this.type,
    this.price,
    this.discount,
  });

  /// Price after applying the discount.
  double? get finalPrice {
    if (price == null) {
      return null;
    }

    if (discount == null || discount! <= 0) {
      return price;
    }

    return price! - (price! * discount! / 100);
  }

  /// Whether this feature has an active discount.
  bool get hasDiscount {
    return price != null &&
        discount != null &&
        discount! > 0 &&
        discount! < 100;
  }
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
    super.price,
    super.discount,
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
    super.price,
    super.discount,
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
    super.price,
    super.discount,
  }) : super(
    type: FeatureType.training,
  );
}