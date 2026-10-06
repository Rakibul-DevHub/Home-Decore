part of 'list_product_screen.dart';

/// Small monospace label above a form field.
class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: KolekText.mono(
        size: 14,
        weight: FontWeight.w600,
        fontFamily: KolekFonts.ibmPlexMono,
        height: 1.0,
        letterSpacing: 0,
        color: AppearancePage.foreground(context),
      ),
    );
  }
}

/// Text field driven by an external [controller]. The character counter
/// rebuilds on its own via [ValueListenableBuilder] — the rest of the
/// widget doesn't re-render on each keystroke.
class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.maxLength,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: KolekText.mono(
        size: 12,
        weight: FontWeight.w400,
        height: 1.0,
        letterSpacing: 0,
        color: fg,
      ),
      cursorColor: KolekColors.blue600,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: KolekText.mono(
          size: 12,
          weight: FontWeight.w400,
          height: 1.0,
          letterSpacing: 0,
          color: muted,
        ),
        suffix: maxLength == null
            ? null
            : ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, _) => Text(
            '${value.text.length}/$maxLength',
            style: KolekText.mono(
              size: 11,
              color: muted,
            ),
          ),
        ),
        filled: true,
        fillColor: field,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(color: KolekColors.blue600, width: 1.2),
        ),
      ),
    );
  }
}

/// Square-cornered dropdown styled to match [_TextInput].
class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({
    required this.value,
    required this.onSelected,
  });

  final String? value;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    final display = value ?? ListProductData.categoryHint;
    final displayColor = value == null ? muted : fg;

    return PopupMenuButton<String>(
      tooltip: '',
      padding: EdgeInsets.zero,
      position: PopupMenuPosition.under,
      color: AppearancePage.menu(context),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
        side: BorderSide(color: line),
      ),
      onSelected: onSelected,
      itemBuilder: (context) => [
        for (final category in ListProductData.categories)
          PopupMenuItem<String>(
            value: category,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                category,
                style: KolekText.sans(size: 14, color: fg),
              ),
            ),
          ),
      ],
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: field,
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: line),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                display,
                style: KolekText.sans(size: 14, color: displayColor),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 20,
              color: AppearancePage.icon(context),
            ),
          ],
        ),
      ),
    );
  }
}

/// Width × Height row — two text fields split by a multiplication sign.
class _DimensionsRow extends StatelessWidget {
  const _DimensionsRow({
    required this.widthCtrl,
    required this.heightCtrl,
    required this.onWidthChanged,
    required this.onHeightChanged,
  });

  final TextEditingController widthCtrl;
  final TextEditingController heightCtrl;
  final ValueChanged<String> onWidthChanged;
  final ValueChanged<String> onHeightChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _TextInput(
            controller: widthCtrl,
            hint: ListProductData.widthHint,
            onChanged: onWidthChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '×',
            style: KolekText.sans(
              size: 16,
              color: AppearancePage.muted(context),
            ),
          ),
        ),
        Expanded(
          child: _TextInput(
            controller: heightCtrl,
            hint: ListProductData.heightHint,
            onChanged: onHeightChanged,
          ),
        ),
      ],
    );
  }
}