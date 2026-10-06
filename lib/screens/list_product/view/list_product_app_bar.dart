part of 'list_product_screen.dart';

/// Logo left, close button right.
class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 14, 4),
      child: Row(
        children: [
          SvgPicture.asset(
            ListProductData.logoAsset,
            height: 30,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppearancePage.foreground(context),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 16,
                color: AppearancePage.background(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}