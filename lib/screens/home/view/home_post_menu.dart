part of 'home_screen.dart';

class _PostMenu extends StatelessWidget {
  const _PostMenu({required this.onSelected});

  final ValueChanged<HomeMenuAction> onSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF4F4F4),
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
              if (i > 0)
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFE4E4E4),
                ),
              _PostMenuRow(
                item: HomeData.menuItems[i],
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
  const _PostMenuRow({required this.item, required this.onTap});

  final HomeMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            _PostMenuIcon(action: item.action),
            const SizedBox(width: 12),
            Text(
              item.label,
              style: const TextStyle(
                fontFamily: 'GeneralSans-Medium',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: KolekColors.neutral900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostMenuIcon extends StatelessWidget {
  const _PostMenuIcon({required this.action});

  final HomeMenuAction action;

  @override
  Widget build(BuildContext context) {
    return switch (action) {
      HomeMenuAction.savePost => SvgPicture.asset(
        'assets/icons/save_post.svg',
        width: 22,
        height: 22,
        colorFilter: const ColorFilter.mode(
          KolekColors.neutral900,
          BlendMode.srcIn,
        ),
      ),
      HomeMenuAction.message => SvgPicture.string(
        _messageIcon,
        width: 22,
        height: 22,
      ),
      HomeMenuAction.report => SvgPicture.string(
        _reportIcon,
        width: 22,
        height: 22,
      ),
    };
  }
}

const _messageIcon = '''
<svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M12 20.2C16.6 20.2 20.3 16.7 20.3 12.4C20.3 8.1 16.6 4.6 12 4.6C7.4 4.6 3.7 8.1 3.7 12.4C3.7 14.3 4.4 16.1 5.6 17.4L4.8 19.8L7.5 18.9C8.8 19.7 10.3 20.2 12 20.2Z" stroke="#171717" stroke-width="1.6" stroke-linejoin="round"/>
<circle cx="8.7" cy="12.4" r="1" fill="#171717"/>
<circle cx="12" cy="12.4" r="1" fill="#171717"/>
<circle cx="15.3" cy="12.4" r="1" fill="#171717"/>
</svg>
''';

const _reportIcon = '''
<svg width="22" height="22" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
<circle cx="12" cy="12" r="8.15" stroke="#171717" stroke-width="1.6"/>
<path d="M12 8.1V12.8" stroke="#171717" stroke-width="1.6" stroke-linecap="round"/>
<circle cx="12" cy="15.6" r="0.95" fill="#171717"/>
</svg>
''';
