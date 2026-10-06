part of 'pricing_screen.dart';

/// Static USD badge | segmented price input with static ".00".
class _PriceField extends StatelessWidget {
  const _PriceField({
    required this.controller,
    required this.onPriceChanged,
    this.hint = PricingData.priceHint,
  });

  final TextEditingController controller;
  final ValueChanged<String> onPriceChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    return Row(
      children: [
        // ── Static USD box ─────────────────────────────────────
        Container(
          width: 68,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: field,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: line),
          ),
          child: Text(
            'USD',
            style: KolekText.sans(
              size: 14,
              weight: FontWeight.w600,
              height: 1.0,
              color: fg,
            ),
          ),
        ),
        const SizedBox(width: 12),
        // ── Amount input with .00 suffix ────────────────────────
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: field,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: line),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onPriceChanged,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: KolekText.mono(
                      size: 14,
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
                        size: 14,
                        weight: FontWeight.w400,
                        height: 1.0,
                        color: muted,
                      ),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppearancePage.isDark(context)
                        ? line
                        : const Color(0xFFEBEBEB),
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(9),
                    ),
                  ),
                  child: Text(
                    PricingData.priceSuffix,
                    style: KolekText.mono(
                      size: 14,
                      weight: FontWeight.w400,
                      height: 1.0,
                      color: muted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// The set of fields shown when "Auction" listing type is chosen.
class _AuctionPricingSection extends StatelessWidget {
  const _AuctionPricingSection({
    required this.startingBidCtrl,
    required this.reservePriceCtrl,
    required this.bidIncrementCtrl,
  });

  final TextEditingController startingBidCtrl;
  final TextEditingController reservePriceCtrl;
  final TextEditingController bidIncrementCtrl;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ListProductBloc>();

    return BlocBuilder<ListProductBloc, ListProductState>(
      buildWhen: (prev, curr) =>
          prev.startDate != curr.startDate ||
          prev.startTime != curr.startTime ||
          prev.endDate != curr.endDate ||
          prev.endTime != curr.endTime,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Starting Bid ────────────────────────────────────
          const _SectionLabel(PricingData.startingBidLabel),
          const SizedBox(height: 12),
          _PriceField(
            controller: startingBidCtrl,
            onPriceChanged: (v) => bloc.add(ListProductStartingBidChanged(v)),
          ),
          const SizedBox(height: 24),

          // ── Reserve Price (Optional) ─────────────────────────
          const _SectionLabel(PricingData.reservePriceLabel),
          const SizedBox(height: 12),
          _PriceField(
            controller: reservePriceCtrl,
            onPriceChanged: (v) => bloc.add(ListProductReservePriceChanged(v)),
          ),
          const SizedBox(height: 24),

          // ── Bid Increment ───────────────────────────────────
          const _SectionLabel(PricingData.bidIncrementLabel),
          const SizedBox(height: 12),
          _PriceField(
            controller: bidIncrementCtrl,
            hint: PricingData.bidIncrementHint,
            onPriceChanged: (v) => bloc.add(ListProductBidIncrementChanged(v)),
          ),
          const SizedBox(height: 24),

          // ── Start date and time ─────────────────────────────
          const _SectionLabel(PricingData.startDateTimeLabel),
          const SizedBox(height: 12),
          _DateTimeRow(
            date: state.startDate,
            time: state.startTime,
            onDateSelected: (v) => bloc.add(ListProductStartDateChanged(v)),
            onTimeSelected: (v) => bloc.add(ListProductStartTimeChanged(v)),
          ),
          const SizedBox(height: 24),

          // ── End date and time ───────────────────────────────
          const _SectionLabel(PricingData.endDateTimeLabel),
          const SizedBox(height: 12),
          _DateTimeRow(
            date: state.endDate,
            time: state.endTime,
            onDateSelected: (v) => bloc.add(ListProductEndDateChanged(v)),
            onTimeSelected: (v) => bloc.add(ListProductEndTimeChanged(v)),
          ),
        ],
      ),
    );
  }
}

/// A side-by-side row with a Date field and a Time field.
class _DateTimeRow extends StatelessWidget {
  const _DateTimeRow({
    required this.date,
    required this.time,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  final String date;
  final String time;
  final ValueChanged<String> onDateSelected;
  final ValueChanged<String> onTimeSelected;

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      final formatted =
          '${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}-${picked.year}';
      onDateSelected(formatted);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
      onTimeSelected('$hour:$minute $period');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _DateTimePickerTile(
            text: date.isNotEmpty ? date : PricingData.dateHint,
            isPlaceholder: date.isEmpty,
            icon: Icons.calendar_today_outlined,
            onTap: () => _pickDate(context),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _DateTimePickerTile(
            text: time.isNotEmpty ? time : PricingData.timeHint,
            isPlaceholder: time.isEmpty,
            icon: Icons.access_time_outlined,
            onTap: () => _pickTime(context),
          ),
        ),
      ],
    );
  }
}

/// Individual tile for picking either Date or Time.
class _DateTimePickerTile extends StatelessWidget {
  const _DateTimePickerTile({
    required this.text,
    required this.isPlaceholder,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final bool isPlaceholder;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final fg = AppearancePage.foreground(context);
    final muted = AppearancePage.muted(context);
    final line = AppearancePage.line(context);
    final field = AppearancePage.field(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: field,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: line),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: KolekText.mono(
                  size: 13,
                  weight: FontWeight.w400,
                  height: 1.0,
                  letterSpacing: 0,
                  color: isPlaceholder ? muted : fg,
                ),
              ),
            ),
            Icon(
              icon,
              size: 18,
              color: fg,
            ),
          ],
        ),
      ),
    );
  }
}