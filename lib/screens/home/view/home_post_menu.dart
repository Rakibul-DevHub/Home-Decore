part of 'home_screen.dart';

class _PostMenu extends StatelessWidget {
  const _PostMenu({required this.saved, required this.onSelected});

  final bool saved;
  final ValueChanged<HomeMenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    final colors = _HomeColors.of(context);
    return Material(
      color: colors.menu,
      elevation: 10,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < HomeData.menuItems.length; i++) ...[
              if (i > 0) Divider(height: 1, thickness: 1, color: colors.line),
              _PostMenuRow(
                item: HomeData.menuItems[i],
                saved: saved,
                onTap: () => onSelected(HomeData.menuItems[i].action),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PostMenuRow extends StatelessWidget {
  const _PostMenuRow({
    required this.item,
    required this.saved,
    required this.onTap,
  });

  final HomeMenuItem item;
  final bool saved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = _HomeColors.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _PostMenuIcon(action: item.action, saved: saved),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: TextStyle(
                fontFamily: 'GeneralSans-Medium',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: colors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostMenuIcon extends StatelessWidget {
  const _PostMenuIcon({required this.action, required this.saved});

  final HomeMenuAction action;
  final bool saved;

  @override
  Widget build(BuildContext context) {
    final colors = _HomeColors.of(context);
    return switch (action) {
      HomeMenuAction.savePost => SizedBox(
        width: 22,
        height: 22,
        child: Center(
          child: saved
              ? SvgPicture.asset(
                  'assets/icons/save_active.svg',
                  width: 22,
                  height: 22,
                )
              : SvgPicture.asset(
            'assets/icons/save_post.svg',
                  width: 22,
                  height: 22,
                ),
        ),
      ),
      HomeMenuAction.message => SvgPicture.asset(
        'assets/icons/message_circular.svg',
        width: 22,
        height: 22,
        colorFilter: colors.textFilter,
      ),
      HomeMenuAction.report => SvgPicture.asset(
        'assets/icons/report.svg',
        width: 22,
        height: 22,
        colorFilter: colors.textFilter,
      ),
    };
  }
}

