import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/appearance/appearance_page.dart';
import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../bloc/account_information_bloc.dart';
import '../bloc/account_information_event.dart';
import '../bloc/account_information_state.dart';
import '../data/account_information_data.dart';

class AccountInformationScreen extends StatefulWidget {
  const AccountInformationScreen({super.key});

  @override
  State<AccountInformationScreen> createState() =>
      _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _passwordCtrl;

  @override
  void initState() {
    super.initState();
    final initial = context.read<AccountInformationBloc>().state.draft;
    _nameCtrl = TextEditingController(text: initial.fullName);
    _emailCtrl = TextEditingController(text: initial.email);
    _phoneCtrl = TextEditingController(text: initial.phone);
    _passwordCtrl = TextEditingController(text: initial.password);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppearancePage.background(context),
      body: SafeArea(
        child: BlocListener<AccountInformationBloc, AccountInformationState>(
          listenWhen: (prev, next) => prev.saving && !next.saving,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account updated')),
            );
            Navigator.of(context).pop();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _AccountAppBar(),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                  children: [
                    // ── Subtitle ────────────────────────────────────
                    Text(
                      AccountInformationData.subtitle,
                      style: KolekText.sans(
                        size: 13,
                        weight: FontWeight.w400,
                        height: 1.5,
                        color: AppearancePage.muted(context),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Editable fields ─────────────────────────────
                    _AccountField(
                      label: AccountInformationData.fullNameLabel,
                      hint: AccountInformationData.fullNameHint,
                      controller: _nameCtrl,
                      onChanged: (v) => context
                          .read<AccountInformationBloc>()
                          .add(AccountFullNameChanged(v)),
                    ),
                    const SizedBox(height: 18),
                    _AccountField(
                      label: AccountInformationData.emailLabel,
                      hint: AccountInformationData.emailHint,
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (v) => context
                          .read<AccountInformationBloc>()
                          .add(AccountEmailChanged(v)),
                      helper: AccountInformationData.emailHelper,
                    ),
                    const SizedBox(height: 18),
                    _AccountField(
                      label: AccountInformationData.phoneLabel,
                      hint: AccountInformationData.phoneHint,
                      controller: _phoneCtrl,
                      keyboardType: TextInputType.phone,
                      onChanged: (v) => context
                          .read<AccountInformationBloc>()
                          .add(AccountPhoneChanged(v)),
                    ),
                    const SizedBox(height: 18),
                    _AccountField(
                      label: AccountInformationData.passwordLabel,
                      hint: AccountInformationData.passwordHint,
                      controller: _passwordCtrl,
                      obscureText: true,
                      onChanged: (v) => context
                          .read<AccountInformationBloc>()
                          .add(AccountPasswordChanged(v)),
                      trailing: GestureDetector(
                        onTap: () => context
                            .read<AccountInformationBloc>()
                            .add(const AccountPasswordChangeRequested()),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                          child: Text(
                            AccountInformationData.changeLabel,
                            style: KolekText.sans(
                              size: 14,
                              weight: FontWeight.w500,
                              height: 1.0,
                              color: KolekColors.blue600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // ── Divider before ACCOUNT section ──────────────
                    Divider(
                      height: 1,
                      thickness: 0.5,
                      color: AppearancePage.line(context),
                    ),
                    const SizedBox(height: 24),

                    // ── ACCOUNT section label ───────────────────────
                    Text(
                      AccountInformationData.accountSectionLabel,
                      style: KolekText.mono(
                        size: 11,
                        weight: FontWeight.w500,
                        height: 1.0,
                        letterSpacing: 1.2,
                        color: AppearancePage.muted(context),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // ── Read-only fields ────────────────────────────
                    _ReadOnlyField(
                      label: AccountInformationData.usernameLabel,
                      value: context
                          .read<AccountInformationBloc>()
                          .state
                          .draft
                          .username,
                    ),
                    const SizedBox(height: 18),
                    _ReadOnlyField(
                      label: AccountInformationData.memberSinceLabel,
                      value: context
                          .read<AccountInformationBloc>()
                          .state
                          .draft
                          .memberSince,
                    ),
                    const SizedBox(height: 28),

                    // ── Save button ─────────────────────────────────
                    BlocSelector<AccountInformationBloc,
                        AccountInformationState, bool>(
                      selector: (s) => s.canSave,
                      builder: (context, enabled) => SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          onPressed: enabled
                              ? () => context
                              .read<AccountInformationBloc>()
                              .add(const AccountSaveRequested())
                              : null,
                          style: FilledButton.styleFrom(
                            backgroundColor: KolekColors.blue600,
                            disabledBackgroundColor: KolekColors.blue600
                                .withValues(alpha: 0.5),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            textStyle: KolekText.sans(
                              size: 15,
                              weight: FontWeight.w600,
                            ),
                          ),
                          child: const Text(
                            AccountInformationData.saveLabel,
                          ),
                        ),
                      ),
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
// App bar — back arrow + title (no bell, no save in bar)
// ─────────────────────────────────────────────────────────────────────────

class _AccountAppBar extends StatelessWidget {
  const _AccountAppBar();

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
          Text(
            AccountInformationData.appBarTitle,
            style: KolekText.sans(
              size: 20,
              weight: FontWeight.w600,
              height: 1.0,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Editable field — label + bordered input + optional helper + optional
// trailing widget (used for the "Change" link next to password)
// ─────────────────────────────────────────────────────────────────────────

class _AccountField extends StatelessWidget {
  const _AccountField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.helper,
    this.trailing,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? helper;

  /// Optional widget shown to the right of the input. Used for the
  /// "Change" link next to the password field.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    // When a trailing widget is present, the field and the widget sit
    // side by side in a Row. Otherwise the field takes the full width.
    final input = Container(
      height: 48,
      decoration: BoxDecoration(
        color: field,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: line),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        obscuringCharacter: '•',
        style: KolekText.mono(
          size: 14,
          weight: FontWeight.w400,
          height: 1.2,
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
            height: 1.2,
            color: muted,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );

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
        if (trailing != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: input),
              const SizedBox(width: 12),
              trailing!,
            ],
          )
        else
          input,
        if (helper != null) ...[
          const SizedBox(height: 8),
          Text(
            helper!,
            style: KolekText.sans(
              size: 11,
              weight: FontWeight.w400,
              height: 1.4,
              color: muted,
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// Read-only field — same look, no input
// ─────────────────────────────────────────────────────────────────────────

class _ReadOnlyField extends StatelessWidget {
  const _ReadOnlyField({required this.label, required this.value});

  final String label;
  final String value;

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
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: field,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: line),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: KolekText.mono(
              size: 14,
              weight: FontWeight.w400,
              height: 1.2,
              letterSpacing: 0,
              color: fg,
            ),
          ),
        ),
      ],
    );
  }
}