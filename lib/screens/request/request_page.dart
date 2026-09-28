import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:motigraph/widgets/moti_glass_card.dart';

enum RequestType {
  course,
  training,
  service,
}

class RequestPage extends StatefulWidget {
  final RequestType type;
  final String title;

  const RequestPage({
    super.key,
    required this.type,
    required this.title,
  });

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  String? _selectedOption;
  String _preferredContact = 'whatsapp';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();

    super.dispose();
  }

  List<String> get _options {
    switch (widget.type) {
      case RequestType.course:
        return [
          'flutter',
          'programming',
          'other',
        ];

      case RequestType.training:
        return [
          'mobile_development',
          'web_development',
          'cybersecurity',
          'other',
        ];

      case RequestType.service:
        return [
          'website',
          'mobile_application',
          'digital_marketing',
          'motion_graphics',
          'cybersecurity',
          'other',
        ];
    }
  }

  String get _pageTitle {
    switch (widget.type) {
      case RequestType.course:
        return 'enroll_request';

      case RequestType.training:
        return 'training_request';

      case RequestType.service:
        return 'service_request';
    }
  }

  String get _pageDescription {
    switch (widget.type) {
      case RequestType.course:
        return 'course_request_description';

      case RequestType.training:
        return 'training_request_description';

      case RequestType.service:
        return 'service_request_description';
    }
  }

  void _submitRequest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    debugPrint('Request Type: ${widget.type}');
    debugPrint('Title: ${widget.title}');
    debugPrint('Name: ${_nameController.text}');
    debugPrint('Phone: ${_phoneController.text}');
    debugPrint('Email: ${_emailController.text}');
    debugPrint('Option: $_selectedOption');
    debugPrint('Contact: $_preferredContact');
    debugPrint('Message: ${_messageController.text}');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'request_sent_successfully'.tr(),
        ),
      ),
    );
  }

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
          _pageTitle.tr(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                16,
                16,
                16,
                30,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    // Header
                    MotiGlassCard(
                      child: _HeaderSection(
                        title: _pageTitle.tr(),
                        description: _pageDescription.tr(),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Personal Information
                    MotiGlassCard(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            _SectionTitle(
                              title: 'your_information'.tr(),
                            ),

                            const SizedBox(height: 20),

                            _InputField(
                              controller: _nameController,
                              label: 'name'.tr(),
                              hint: 'enter_your_name'.tr(),
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'name_required'.tr();
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            _InputField(
                              controller: _phoneController,
                              label: 'phone'.tr(),
                              hint: 'enter_phone_number'.tr(),
                              icon: Icons.phone_outlined,
                              keyboardType:
                              TextInputType.phone,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty) {
                                  return 'phone_required'.tr();
                                }

                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            _InputField(
                              controller: _emailController,
                              label: 'email'.tr(),
                              hint: 'enter_email'.tr(),
                              icon: Icons.email_outlined,
                              keyboardType:
                              TextInputType.emailAddress,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Request Details
                    MotiGlassCard(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            _SectionTitle(
                              title: 'request_details'.tr(),
                            ),

                            const SizedBox(height: 20),

                            _SelectedItem(
                              title: 'selected_item'.tr(),
                              value: widget.title.tr(),
                            ),

                            const SizedBox(height: 20),

                            _InputLabel(
                              text: 'what_do_you_need'.tr(),
                            ),

                            const SizedBox(height: 8),

                            _GlassDropdown(
                              value: _selectedOption,
                              options: _options,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value;
                                });
                              },
                            ),

                            const SizedBox(height: 20),

                            _InputField(
                              controller: _messageController,
                              label: 'project_details'.tr(),
                              hint: 'describe_your_request'.tr(),
                              icon: Icons.notes_outlined,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Preferred Contact
                    MotiGlassCard(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            _SectionTitle(
                              title: 'preferred_contact'.tr(),
                            ),

                            const SizedBox(height: 12),

                            _GlassRadio(
                              value: 'whatsapp',
                              groupValue:
                              _preferredContact,
                              icon: Icons.chat_outlined,
                              title: 'whatsapp'.tr(),
                              onChanged: (value) {
                                setState(() {
                                  _preferredContact = value;
                                });
                              },
                            ),

                            _GlassRadio(
                              value: 'phone_call',
                              groupValue:
                              _preferredContact,
                              icon: Icons.call_outlined,
                              title: 'phone_call'.tr(),
                              onChanged: (value) {
                                setState(() {
                                  _preferredContact = value;
                                });
                              },
                            ),

                            _GlassRadio(
                              value: 'email',
                              groupValue:
                              _preferredContact,
                              icon: Icons.email_outlined,
                              title: 'email'.tr(),
                              onChanged: (value) {
                                setState(() {
                                  _preferredContact = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    _SubmitButton(
                      text: 'send_request'.tr(),
                      onTap: _submitRequest,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _HeaderSection extends StatelessWidget {
  final String title;
  final String description;

  const _HeaderSection({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CREATE | LEARN | GROW',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: theme.colorScheme.tertiary,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          title,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            height: 1.6,
            color: theme.colorScheme.onSurface
                .withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}


class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: TextStyle(
        color: theme.colorScheme.onSurface,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        filled: true,
        fillColor: theme.colorScheme.onSurface
            .withValues(alpha: 0.035),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface
                .withValues(alpha: 0.10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface
                .withValues(alpha: 0.10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: theme.colorScheme.tertiary,
            width: 1.2,
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _SubmitButton({
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
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class _SelectedItem extends StatelessWidget {
  final String title;
  final String value;

  const _SelectedItem({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InputLabel(
          text: title,
        ),

        const SizedBox(height: 8),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.035,
            ),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(
                alpha: 0.10,
              ),
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
class _InputLabel extends StatelessWidget {
  final String text;

  const _InputLabel({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.onSurface.withValues(
          alpha: 0.7,
        ),
      ),
    );
  }
}
class _GlassDropdown extends StatelessWidget {
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  const _GlassDropdown({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.category_outlined,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        filled: true,
        fillColor: theme.colorScheme.onSurface.withValues(
          alpha: 0.035,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.10,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: theme.colorScheme.onSurface.withValues(
              alpha: 0.10,
            ),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: theme.colorScheme.tertiary,
            width: 1.2,
          ),
        ),
      ),
      items: options.map(
            (option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(
              option.tr(),
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ).toList(),
      onChanged: onChanged,
    );
  }
}
class _GlassRadio extends StatelessWidget {
  final String value;
  final String groupValue;
  final IconData icon;
  final String title;
  final ValueChanged<String> onChanged;

  const _GlassRadio({
    required this.value,
    required this.groupValue,
    required this.icon,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final selected = value == groupValue;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: selected
              ? theme.colorScheme.tertiary.withValues(
            alpha: 0.10,
          )
              : theme.colorScheme.onSurface.withValues(
            alpha: 0.025,
          ),
          border: Border.all(
            color: selected
                ? theme.colorScheme.tertiary
                : theme.colorScheme.onSurface.withValues(
              alpha: 0.08,
            ),
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: selected
                  ? theme.colorScheme.tertiary
                  : theme.colorScheme.onSurface.withValues(
                alpha: 0.65,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: selected
                      ? FontWeight.w600
                      : FontWeight.normal,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? theme.colorScheme.tertiary
                      : theme.colorScheme.onSurface
                      .withValues(alpha: 0.35),
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.tertiary,
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}