import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:motigraph/core/models/feature_data.dart';
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

      body: CustomScrollView(
        slivers: [
          // --------------------------------------------------
          // Optional Preview Video
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
              padding: EdgeInsets.fromLTRB(
                16,
                8,
                16,
                16,
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
    );
  }


}
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

        const SizedBox(height: 30),

        _ActionButton(
          text: 'enroll_now'.tr(),
          onTap: () {
            debugPrint(
              'Enroll course: ${course.title}',
            );
          },
        ),
      ],
    );
  }
}
class _TrainingDetails extends StatelessWidget {
  final TrainingData training;

  const _TrainingDetails({
    required this.training,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          training.detailsTitle.tr(),
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        const SizedBox(height: 12),

        Text(
          training.detailsDescription.tr(),
          style: TextStyle(
            fontSize: 15,
            height: 1.6,
            color: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.75),
          ),
        ),

        if (training.sections.isNotEmpty) ...[
          const SizedBox(height: 28),

          _DetailSections(
            sections: training.sections,
          ),
        ],

        const SizedBox(height: 30),

        _ActionButton(
          text: 'request_training'.tr(),
          onTap: () {
            debugPrint(
              'Request training: ${training.title}',
            );
          },
        ),
      ],
    );
  }
}
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

        const SizedBox(height: 30),

        _ActionButton(
          text: 'request_service'.tr(),
          onTap: () {
            debugPrint(
              'Request service: ${service.title}',
            );
          },
        ),
      ],
    );
  }
}
// ========================================================
// Video Section
// ========================================================

// ========================================================
// Video Section
// ========================================================
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
            // ==================================================
            // Thumbnail / Placeholder
            // ==================================================

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
                    color: theme.colorScheme.primary
                        .withValues(alpha: 0.35),
                  ),
                ),
              ),

            // ==================================================
            // Dark Overlay
            // ==================================================

            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(
                  alpha: 0.35,
                ),
              ),
            ),

            // ==================================================
            // Play Button
            // ==================================================

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


class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _ActionButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: theme.colorScheme.tertiary,
        borderRadius: BorderRadius.circular(11),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(11),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 13,
            ),
            child: Text(
              text,
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
}
