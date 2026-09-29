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
                  width: 16,
                  height: 16,
                )
              : SvgPicture.string(
                  _saveIcon,
                  width: 22,
                  height: 22,
                  colorFilter: colors.textFilter,
                ),
        ),
      ),
      HomeMenuAction.message => SvgPicture.string(
        _messageIcon,
        width: 22,
        height: 22,
        colorFilter: colors.textFilter,
      ),
      HomeMenuAction.report => SvgPicture.string(
        _reportIcon,
        width: 22,
        height: 22,
        colorFilter: colors.textFilter,
      ),
    };
  }
}

const _saveIcon = '''
<svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M19 21L12 17L5 21V5C5 4.46957 5.21071 3.96086 5.58579 3.58579C5.96086 3.21071 6.46957 3 7 3H17C17.5304 3 18.0391 3.21071 18.4142 3.58579C18.7893 3.96086 19 4.46957 19 5V21Z" stroke="#FAFAFA" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
''';

const _messageIcon = '''
<svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12 20.2C16.6 20.2 20.3 16.7 20.3 12.4C20.3 8.1 16.6 4.6 12 4.6C7.4 4.6 3.7 8.1 3.7 12.4C3.7 14.3 4.4 16.1 5.6 17.4L4.8 19.8L7.5 18.9C8.8 19.7 10.3 20.2 12 20.2Z" stroke="#FAFAFA" stroke-width="1.6" stroke-linejoin="round"/>
<circle cx="8.7" cy="12.4" r="1" fill="#FAFAFA"/>
<circle cx="12" cy="12.4" r="1" fill="#FAFAFA"/>
<circle cx="15.3" cy="12.4" r="1" fill="#FAFAFA"/>
</svg>
''';

const _reportIcon = '''
<svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<circle cx="12" cy="12" r="8.15" stroke="#FAFAFA" stroke-width="1.6"/>
<path d="M12 8.1V12.8" stroke="#FAFAFA" stroke-width="1.6" stroke-linecap="round"/>
<circle cx="12" cy="15.6" r="0.95" fill="#FAFAFA"/>
</svg>
''';
