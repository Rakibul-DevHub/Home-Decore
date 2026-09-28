part of 'home_screen.dart';

class _SharePerson {
  const _SharePerson({
    required this.id,
    required this.name,
    required this.avatar,
  });

  final String id;
  final String name;
  final String avatar;
}

const _sharePeople = [
  _SharePerson(
    id: 'syra-1',
    name: 'Syra S,23',
    avatar: 'assets/images/search_user_1.png',
  ),
  _SharePerson(
    id: 'syra-2',
    name: 'Syra S, 23',
    avatar: 'assets/images/search_user_2.png',
  ),
  _SharePerson(
    id: 'syra-3',
    name: 'Syra S, 23',
    avatar: 'assets/images/search_user_3.png',
  ),
  _SharePerson(
    id: 'syra-4',
    name: 'Syra S, 23',
    avatar: 'assets/images/search_user_4.png',
  ),
  _SharePerson(
    id: 'syra-5',
    name: 'Syra S, 23',
    avatar: 'assets/images/demo_user.png',
  ),
  _SharePerson(
    id: 'syra-6',
    name: 'Syra S, 23',
    avatar: 'assets/images/search_user_2.png',
  ),
  _SharePerson(
    id: 'syra-7',
    name: 'Syra S, 23',
    avatar: 'assets/images/search_user_1.png',
  ),
  _SharePerson(
    id: 'syra-8',
    name: 'Syra S, 23',
    avatar: 'assets/images/search_user_3.png',
  ),
];

const _inviteLink = 'kolek.io/invite/khairuldado';

Future<void> _showShareSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _ShareSheet(),
  );
}

class _ShareSheet extends StatefulWidget {
  const _ShareSheet();

  @override
  State<_ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<_ShareSheet> {
  static const _sendBlue = Color(0xFF2B7FFF);

  final _selected = <String>{'syra-1', 'syra-2'};
  String _query = '';
  bool _copied = false;

  List<_SharePerson> get _visible {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return _sharePeople;
    return _sharePeople
        .where((person) => person.name.toLowerCase().contains(query))
        .toList();
  }

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: _inviteLink));
    if (!mounted) return;
    setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final people = _visible;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _InviteLink(copied: _copied, onCopy: _copy),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (value) => setState(() => _query = value),
                  style: const TextStyle(
                    fontFamily: 'IBMPlexMono-Regular',
                    fontSize: 14,
                    color: KolekColors.neutral900,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'search people',
                    hintStyle: const TextStyle(
                      fontFamily: 'IBMPlexMono-Regular',
                      fontSize: 14,
                      color: KolekColors.neutral400,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 8),
                      child: SvgPicture.asset(
                        'assets/icons/search.svg',
                        width: 18,
                        height: 18,
                      ),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 38,
                      minHeight: 18,
                    ),
                    filled: true,
                    fillColor: KolekColors.neutral100,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: KolekColors.neutral200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: KolekColors.neutral200,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: KolekColors.neutral300,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: people.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final person = people[index];
                    return _SharePersonTile(
                      person: person,
                      selected: _selected.contains(person.id),
                      onTap: () {
                        setState(() {
                          if (!_selected.add(person.id)) {
                            _selected.remove(person.id);
                          }
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: FilledButton.styleFrom(
                      backgroundColor: _sendBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: const TextStyle(
                        fontFamily: 'GeneralSans-Medium',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    child: const Text('Send'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InviteLink extends StatelessWidget {
  const _InviteLink({required this.copied, required this.onCopy});

  final bool copied;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 14, right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: KolekColors.neutral200),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              _inviteLink,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'IBMPlexMono-Regular',
                fontSize: 14,
                color: KolekColors.neutral900,
              ),
            ),
          ),
          TextButton(
            onPressed: onCopy,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF2B7FFF),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              textStyle: const TextStyle(
                fontFamily: 'GeneralSans-Medium',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            child: Text(copied ? 'Copied' : 'Copy'),
          ),
        ],
      ),
    );
  }
}

class _SharePersonTile extends StatelessWidget {
  const _SharePersonTile({
    required this.person,
    required this.selected,
    required this.onTap,
  });

  final _SharePerson person;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipOval(
                  child: Image.asset(
                    person.avatar,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                if (selected)
                  Positioned(
                    right: -1,
                    bottom: -1,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B7FFF),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            person.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'IBMPlexMono-Regular',
              fontSize: 11,
              color: KolekColors.neutral700,
            ),
          ),
        ],
      ),
    );
  }
}
