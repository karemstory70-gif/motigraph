import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:motigraph/core/models/feature_data.dart';
import 'package:motigraph/screens/request/request_page.dart';
import 'package:motigraph/widgets/moti_glass_card.dart';

class DetailsPage extends StatelessWidget {
  final FeatureData item;

  const DetailsPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      // ======================================================
      // App Bar
      // ======================================================

      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(
          item.title.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ),

      // ======================================================
      // Scrollable Content
      // ======================================================

      body: CustomScrollView(
        slivers: [
          // --------------------------------------------------
          // Video
          // --------------------------------------------------

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                8,
              ),
              child: MotiGlassCard(
                child: _VideoSection(
                  item: item,
                ),
              ),
            ),
          ),

          // --------------------------------------------------
          // Details
          // --------------------------------------------------

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                8,
                16,
                120,
              ),
              child: MotiGlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: _DetailsContent(
                    item: item,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // ======================================================
      // Fixed Bottom Action
      // ======================================================

      bottomNavigationBar: _BottomActionBar(
        item: item,
      ),
    );
  }
}

// ============================================================
// Details Content
// ============================================================

class _DetailsContent extends StatelessWidget {
  final FeatureData item;

  const _DetailsContent({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    switch (item) {
      case CourseData course:
        return _CourseDetails(
          course: course,
        );

      case TrainingData training:
        return _TrainingDetails(
          training: training,
        );

      case ServiceData service:
        return _ServiceDetails(
          service: service,
        );
    }
  }
}

// ============================================================
// Detail Sections
// ============================================================

class _DetailSections extends StatelessWidget {
  final List<DetailSection> sections;

  const _DetailSections({
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (sections.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < sections.length; i++) ...[
          if (i > 0)
            const SizedBox(height: 28),

          Text(
            sections[i].title.tr(),
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            sections[i].description.tr(),
            style: TextStyle(
              fontSize: 14,
              height: 1.7,
              color: theme.colorScheme.onSurface.withValues(
                alpha: 0.72,
              ),
            ),
          ),

          if (sections[i].points.isNotEmpty) ...[
            const SizedBox(height: 14),

            ...sections[i].points.map(
                  (point) => _DetailPoint(
                text: point.tr(),
              ),
            ),
          ],
        ],
      ],
    );
  }
}

// ============================================================
// Detail Point
// ============================================================

class _DetailPoint extends StatelessWidget {
  final String text;

  const _DetailPoint({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiary,
                shape: BoxShape.circle,
              ),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: theme.colorScheme.onSurface.withValues(
                  alpha: 0.75,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// Course Details
// ============================================================

class _CourseDetails extends StatelessWidget {
  final CourseData course;

  const _CourseDetails({
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          course.detailsTitle.tr(),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          course.detailsDescription.tr(),
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.75,
            ),
          ),
        ),

        if (course.sections.isNotEmpty) ...[
          const SizedBox(height: 28),

          _DetailSections(
            sections: course.sections,
          ),
        ],
      ],
    );
  }
}

// ============================================================
// Training Details
// ============================================================

class _TrainingDetails extends StatelessWidget {
  final TrainingData training;

  const _TrainingDetails({
    required this.training,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          training.detailsTitle.tr(),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          training.detailsDescription.tr(),
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.75,
            ),
          ),
        ),

        if (training.sections.isNotEmpty) ...[
          const SizedBox(height: 28),

          _DetailSections(
            sections: training.sections,
          ),
        ],
      ],
    );
  }
}

// ============================================================
// Service Details
// ============================================================

class _ServiceDetails extends StatelessWidget {
  final ServiceData service;

  const _ServiceDetails({
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service.detailsTitle.tr(),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          service.detailsDescription.tr(),
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.75,
            ),
          ),
        ),

        if (service.sections.isNotEmpty) ...[
          const SizedBox(height: 28),

          _DetailSections(
            sections: service.sections,
          ),
        ],
      ],
    );
  }
}

// ============================================================
// Video Section
// ============================================================

class _VideoSection extends StatelessWidget {
  final FeatureData item;

  const _VideoSection({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasVideo =
        item.videoUrl != null &&
            item.videoUrl!.trim().isNotEmpty;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ------------------------------------------------
            // Thumbnail / Placeholder
            // ------------------------------------------------

            if (item.image != null)
              Positioned.fill(
                child: Image.asset(
                  item.image!,
                  fit: BoxFit.cover,
                ),
              )
            else
              Positioned.fill(
                child: Container(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.play_circle_outline_rounded,
                    size: 70,
                    color: theme.colorScheme.primary.withValues(
                      alpha: 0.35,
                    ),
                  ),
                ),
              ),

            // ------------------------------------------------
            // Overlay
            // ------------------------------------------------

            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(
                  alpha: 0.35,
                ),
              ),
            ),

            // ------------------------------------------------
            // Play Button
            // ------------------------------------------------

            Material(
              color: theme.colorScheme.tertiary,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: hasVideo
                    ? () {
                  debugPrint(
                    'Play video: ${item.videoUrl}',
                  );
                }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Icon(
                    hasVideo
                        ? Icons.play_arrow_rounded
                        : Icons.play_disabled_rounded,
                    size: 34,
                    color: theme.colorScheme.onTertiary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Fixed Bottom Action Bar
// ============================================================

class _BottomActionBar extends StatelessWidget {
  final FeatureData item;

  const _BottomActionBar({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          16,
          10,
          16,
          10,
        ),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.onSurface.withValues(
                alpha: 0.08,
              ),
            ),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, -6),
              color: Colors.black.withValues(
                alpha: 0.10,
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            // ------------------------------------------------
            // Price
            // ------------------------------------------------

            Expanded(
              flex: 2,
              child: _PriceSection(
                item: item,
              ),
            ),

            const SizedBox(width: 14),

            // ------------------------------------------------
            // Action
            // ------------------------------------------------

            Expanded(
              flex: 3,
              child: _ActionButton(
                item: item,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// Price Section
// ============================================================

// ============================================================
// Price Section
// ============================================================

class _PriceSection extends StatelessWidget {
  final FeatureData item;

  const _PriceSection({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final price = item.price;
    final finalPrice = item.finalPrice;

    // --------------------------------------------------------
    // No Price
    // --------------------------------------------------------

    if (price == null) {
      return Text(
        'contact_us'.tr(),
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.primary,
        ),
      );
    }

    final hasDiscount = item.hasDiscount;

    // --------------------------------------------------------
    // Price
    // --------------------------------------------------------

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ----------------------------------------------------
        // Discount Badge
        // ----------------------------------------------------

        if (hasDiscount)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.tertiary.withValues(
                alpha: 0.12,
              ),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: theme.colorScheme.tertiary.withValues(
                  alpha: 0.25,
                ),
              ),
            ),
            child: Text(
              '${item.discount!.toStringAsFixed(0)}% ${'off'.tr()}',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.tertiary,
              ),
            ),
          ),

        if (hasDiscount)
          const SizedBox(height: 4),

        // ----------------------------------------------------
        // Current Price
        // ----------------------------------------------------

        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '${(finalPrice ?? price).toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(width: 3),

            Text(
              'EGP',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface.withValues(
                  alpha: 0.55,
                ),
              ),
            ),
          ],
        ),

        // ----------------------------------------------------
        // Original Price
        // ----------------------------------------------------

        if (hasDiscount) ...[
          const SizedBox(height: 1),

          Text(
            '${price.toStringAsFixed(0)} EGP',
            style: TextStyle(
              fontSize: 12,
              decoration: TextDecoration.lineThrough,
              decorationThickness: 1.2,
              color: theme.colorScheme.onSurface.withValues(
                alpha: 0.38,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

// ============================================================
// Action Button
// ============================================================

class _ActionButton extends StatelessWidget {
  final FeatureData item;

  const _ActionButton({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 50,
      child: Material(
        color: theme.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: () {
            switch (item) {
              case CourseData course:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestPage(
                      type: RequestType.course,
                      title: course.title,
                    ),
                  ),
                );

              case TrainingData training:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestPage(
                      type: RequestType.training,
                      title: training.title,
                    ),
                  ),
                );

              case ServiceData service:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestPage(
                      type: RequestType.service,
                      title: service.title,
                    ),
                  ),
                );
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: Text(
              _getButtonText(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getButtonText() {
    switch (item) {
      case CourseData _:
        return 'enroll_request'.tr();

      case TrainingData _:
        return 'training_request'.tr();

      case ServiceData _:
        return 'service_request'.tr();
    }
  }
}