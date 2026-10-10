import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/edit_profile_bloc.dart';
import '../bloc/edit_profile_event.dart';
import '../bloc/edit_profile_state.dart';
import '../data/edit_profile_data.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers live for the screen's lifetime. They're seeded once from
  // the bloc's initial state so hot restarts don't lose in-flight edits.
  late final TextEditingController _nameCtrl;
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _bioCtrl;
  late final TextEditingController _locationCtrl;

  @override
  void initState() {
    super.initState();
    final initial = context.read<EditProfileBloc>().state.draft;
    _nameCtrl = TextEditingController(text: initial.name);
    _usernameCtrl = TextEditingController(text: initial.username);
    _bioCtrl = TextEditingController(text: initial.bio);
    _locationCtrl = TextEditingController(text: initial.location);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _bioCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: BlocListener<EditProfileBloc, EditProfileState>(
          listenWhen: (prev, next) =>
          prev.saving && !next.saving,
          listener: (context, state) {
            // Save finished — pop with a confirmation snackbar.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated')),
            );
            Navigator.of(context).pop();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _EditProfileAppBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(18, 20, 18, 32),
                  children: [
                    const _AvatarSection(),
                    const SizedBox(height: 28),
                    _EditField(
                      label: EditProfileData.nameLabel,
                      hint: EditProfileData.nameHint,
                      controller: _nameCtrl,
                      onChanged: (v) => context
                          .read<EditProfileBloc>()
                          .add(EditProfileNameChanged(v)),
                    ),
                    const SizedBox(height: 20),
                    _EditField(
                      label: EditProfileData.usernameLabel,
                      hint: EditProfileData.usernameHint,
                      controller: _usernameCtrl,
                      onChanged: (v) => context
                          .read<EditProfileBloc>()
                          .add(EditProfileUsernameChanged(v)),
                      helperBuilder: (ctx) => BlocSelector<
                          EditProfileBloc, EditProfileState, String>(
                        selector: (s) => s.profileUrl,
                        builder: (_, url) => Text(
                          url,
                          style: KolekText.mono(
                            size: 12,
                            weight: FontWeight.w400,
                            height: 1.3,
                            color: AppearancePage.muted(ctx),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _EditField(
                      label: EditProfileData.bioLabel,
                      hint: EditProfileData.bioHint,
                      controller: _bioCtrl,
                      maxLines: 4,
                      onChanged: (v) => context
                          .read<EditProfileBloc>()
                          .add(EditProfileBioChanged(v)),
                    ),
                    const SizedBox(height: 20),
                    _EditField(
                      label: EditProfileData.locationLabel,
                      hint: EditProfileData.locationHint,
                      controller: _locationCtrl,
                      onChanged: (v) => context
                          .read<EditProfileBloc>()
                          .add(EditProfileLocationChanged(v)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// App bar — back arrow + title + Save (right)
// ─────────────────────────────────────────────────────────────────────────

class _EditProfileAppBar extends StatelessWidget {
  const _EditProfileAppBar();

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints:
            const BoxConstraints(minWidth: 40, minHeight: 40),
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back, size: 24, color: fg),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              EditProfileData.appBarTitle,
              style: KolekText.sans(
                size: 20,
                weight: FontWeight.w600,
                height: 1.0,
                color: fg,
              ),
            ),
          ),
          BlocSelector<EditProfileBloc, EditProfileState, bool>(
            selector: (s) => s.canSave,
            builder: (context, enabled) => TextButton(
              onPressed: enabled
                  ? () => context
                  .read<EditProfileBloc>()
                  .add(const EditProfileSaveRequested())
                  : null,
              child: Text(
                EditProfileData.saveLabel,
                style: KolekText.sans(
                  size: 16,
                  weight: FontWeight.w500,
                  height: 1.0,
                  color: enabled
                      ? KolekColors.blue600
                      : KolekColors.blue600.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Avatar — circular photo + "Change Profile Photo" link
// ─────────────────────────────────────────────────────────────────────────

class _AvatarSection extends StatelessWidget {
  const _AvatarSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            EditProfileData.avatarAsset,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => context
              .read<EditProfileBloc>()
              .add(const EditProfilePhotoChangeRequested()),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              EditProfileData.changePhotoLabel,
              style: KolekText.sans(
                size: 14,
                weight: FontWeight.w500,
                height: 1.0,
                color: KolekColors.blue600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Edit field — uppercase label + bordered input + optional helper
// ─────────────────────────────────────────────────────────────────────────

class _EditField extends StatelessWidget {
  const _EditField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.onChanged,
    this.maxLines = 1,
    this.helperBuilder,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final int maxLines;

  /// Optional builder for a helper row below the field. Receives a
  /// `BuildContext` so it can read from blocs.
  final Widget Function(BuildContext context)? helperBuilder;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: KolekText.mono(
            size: 11,
            weight: FontWeight.w500,
            height: 1.0,
            letterSpacing: 1.2,
            color: muted,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: field,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: line),
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            maxLines: maxLines,
            minLines: maxLines,
            textInputAction: maxLines == 1
                ? TextInputAction.next
                : TextInputAction.newline,
            style: KolekText.mono(
              size: 14,
              weight: FontWeight.w400,
              height: 1.4,
              letterSpacing: 0,
              color: fg,
            ),
            cursorColor: KolekColors.blue600,
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle: KolekText.mono(
                size: 14,
                weight: FontWeight.w400,
                height: 1.4,
                color: muted,
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: InputBorder.none,
            ),
          ),
        ),
        if (helperBuilder != null) ...[
          const SizedBox(height: 8),
          helperBuilder!(context),
        ],
      ],
    );
  }
}