
import 'package:flutter/material.dart';

void main() => runApp(const VexoApp());

const bg = Color(0xFF090B12);
const panel = Color(0xFF141827);
const purple = Color(0xFF7957FF);
const cyan = Color(0xFF53DDF5);
const muted = Color(0xFF969DB2);

class VexoApp extends StatelessWidget {
  const VexoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VEXO',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: purple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const VexoHome(),
    );
  }
}

class VexoHome extends StatefulWidget {
  const VexoHome({super.key});

  @override
  State<VexoHome> createState() => _VexoHomeState();
}

class _VexoHomeState extends State<VexoHome> {
  int page = 0;
  String filter = 'الكل';
  String search = '';

  final names = [
    'أحمد العراقي',
    'سارة',
    'مصطفى',
    'نور',
    'حسين',
    'زينب',
  ];

  final messages = [
    'شلونك حبيبي؟ شخبارك',
    'شفت الحالة الجديدة؟ ✨',
    'دزلي الصور من توصل',
    'ههههه والله صحيح 😂',
    'باچر نلتقي إن شاء الله',
    'شكراً على المساعدة ❤️',
  ];

  final times = ['الآن', '2 د', '8 د', '15 د', '32 د', '1 س'];

  final colors = [
    Color(0xFF7559FF),
    Color(0xFFE95DAF),
    Color(0xFF22AFC7),
    Color(0xFFE69C4A),
    Color(0xFF6485F7),
    Color(0xFF38B889),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _header(),
              Expanded(
                child: IndexedStack(
                  index: page,
                  children: [
                    _messagesPage(),
                    _storiesPage(),
                    _channelsPage(),
                    _discoverPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _bottomBar(),
        floatingActionButton: page == 0
            ? FloatingActionButton(
                backgroundColor: purple,
                foregroundColor: Colors.white,
                onPressed: () => _notice(
                  'إنشاء محادثة',
                  'راح نربط البحث عن المستخدمين وقائمة الأصدقاء لاحقاً.',
                ),
                child: const Icon(Icons.edit_square),
              )
            : null,
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 14),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [purple, cyan],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'VEXO',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  'عالمك، تواصلك',
                  style: TextStyle(color: muted, fontSize: 11),
                ),
              ],
            ),
          ),
          _iconButton(Icons.search_rounded, () {
            showSearch(
              context: context,
              delegate: VexoSearch(names: names),
            );
          }),
          const SizedBox(width: 8),
          _iconButton(Icons.notifications_none_rounded, () {
            _notice('الإشعارات', 'ستظهر إشعاراتك هنا عند تفعيلها.');
          }),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _notice('ملفك الشخصي', 'إعداد الملف الشخصي قريباً.'),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: purple, width: 2),
                color: panel,
              ),
              child: const Icon(Icons.person_rounded, color: cyan),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback action) {
    return Material(
      color: panel,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: action,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: Colors.white70, size: 23),
        ),
      ),
    );
  }

  Widget _messagesPage() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      children: [
        _hero(),
        const SizedBox(height: 24),
        _sectionTitle('لحظات الأصدقاء', 'شوف الجديد'),
        const SizedBox(height: 15),
        _storiesStrip(),
        const SizedBox(height: 25),
        Row(
          children: [
            const Expanded(
              child: Text(
                'محادثاتك',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
            _onlineLabel(),
          ],
        ),
        const SizedBox(height: 13),
        _filters(),
        const SizedBox(height: 8),
        ...List.generate(names.length, (i) {
          if (filter == 'غير مقروءة' && i > 1) {
            return const SizedBox.shrink();
          }
          final index = i;
          return _chatTile(index);
        }),
        const SizedBox(height: 18),
        _promoCard(),
      ],
    );
  }

  Widget _hero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27),
        gradient: const LinearGradient(
          colors: [Color(0xFF7654FF), Color(0xFF37216D), Color(0xFF17243D)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -10,
            top: -18,
            child: Icon(
              Icons.auto_awesome,
              size: 100,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'مو مجرد رسائل...',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'هنا تبدأ سوالفك ولحظاتك الجديدة',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: () => setState(() => page = 3),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF4A2BB5),
                  ),
                  icon: const Icon(Icons.explore_outlined, size: 19),
                  label: const Text('اكتشف ڤيكسو'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String action) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: () => setState(() => page = 1),
          child: Text(action, style: const TextStyle(color: cyan)),
        ),
      ],
    );
  }

  Widget _storiesStrip() {
    return SizedBox(
      height: 108,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _story('قصتي', null, true, 0),
          ...List.generate(5, (i) => _story(names[i], i, false, i)),
        ],
      ),
    );
  }

  Widget _story(String name, int? index, bool own, int i) {
    return GestureDetector(
      onTap: () => _notice(
        own ? 'أضف حالة' : 'حالة $name',
        own
            ? 'إضافة الصور والفيديوهات ستتوفر عند بناء ميزة الحالات.'
            : 'عرض الحالات الحقيقية يحتاج ربط قاعدة البيانات.',
      ),
      child: SizedBox(
        width: 75,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: own
                      ? [Colors.white24, Colors.white10]
                      : [purple, cyan, Color(0xFFE95DAF)],
                ),
              ),
              child: CircleAvatar(
                radius: 27,
                backgroundColor: colors[i % colors.length],
                child: own
                    ? const Icon(Icons.add, size: 28)
                    : Text(
                        name.characters.first,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _onlineLabel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF15342F),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.circle, color: Color(0xFF48D7A1), size: 8),
          SizedBox(width: 6),
          Text(
            'مساحتك الخاصة',
            style: TextStyle(color: Color(0xFF75E2B6), fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _filters() {
    final options = ['الكل', 'غير مقروءة'];
    return Row(
      children: options.map((option) {
        final active = filter == option;
        return Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ChoiceChip(
            label: Text(option),
            selected: active,
            onSelected: (_) => setState(() => filter = option),
            selectedColor: purple.withValues(alpha: 0.3),
            side: BorderSide(
              color: active ? purple : Colors.white12,
            ),
            labelStyle: TextStyle(
              color: active ? Colors.white : muted,
              fontSize: 12,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _chatTile(int i) {
    return InkWell(
      onTap: () => _notice(
        names[i],
        'هذه محادثة تجريبية. إرسال الرسائل سيعمل بعد ربط قاعدة البيانات.',
      ),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: panel,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.035)),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: colors[i],
                  child: Text(
                    names[i].characters.first,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (i < 2)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF48D7A1),
                        shape: BoxShape.circle,
                        border: Border.all(color: panel, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    names[i],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    messages[i],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  times[i],
                  style: TextStyle(
                    color: i < 2 ? cyan : muted,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 8),
                if (i < 2)
                  Container(
                    width: 19,
                    height: 19,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: purple,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(fontSize: 10),
                    ),
                  )
                else
                  const Icon(
                    Icons.done_all,
                    size: 16,
                    color: muted,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _promoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111A29),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cyan.withValues(alpha: 0.15)),
      ),
      child: const Row(
        children: [
          Icon(Icons.shield_moon_outlined, color: cyan, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'خصوصيتك تهمنا',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'نبني ڤيكسو مع مراعاة أمان محادثاتك.',
                  style: TextStyle(color: muted, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _storiesPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'الحالات',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        const Text('لحظات قصيرة، تبقى بذاكرة الأصدقاء.',
            style: TextStyle(color: muted)),
        const SizedBox(height: 24),
        _story('قصتي', null, true, 0),
        const SizedBox(height: 20),
        ...List.generate(5, (i) => ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
          leading: CircleAvatar(
            radius: 26,
            backgroundColor: colors[i],
            child: Text(names[i].characters.first),
          ),
          title: Text(names[i]),
          subtitle: const Text('شارك حالة جديدة', style: TextStyle(color: muted)),
          trailing: const Icon(Icons.play_circle_outline, color: purple),
          onTap: () => _notice('الحالات', 'ستتوفر الحالات الفعلية لاحقاً.'),
        )),
      ],
    );
  }

  Widget _channelsPage() {
    final channelNames = ['عالم التقنية', 'ترند العراق', 'اقتباسات يومية', 'كرة القدم'];
    final channelIcons = [
      Icons.memory,
      Icons.local_fire_department,
      Icons.format_quote,
      Icons.sports_soccer,
    ];

    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'القنوات',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        const Text('تابع المواضيع اللي تهمك.', style: TextStyle(color: muted)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(colors: [purple, Color(0xFF28214F)]),
          ),
          child: const Row(
            children: [
              Icon(Icons.campaign, size: 38),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'اكتشف قناتك المفضلة',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ...List.generate(channelNames.length, (i) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: colors[i],
                child: Icon(channelIcons[i], color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(channelNames[i], style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    const Text('قناة مقترحة لك', style: TextStyle(color: muted, fontSize: 12)),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () => _notice('القنوات', 'ميزة متابعة القنوات ستُربط لاحقاً.'),
                child: const Text('استكشف'),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _discoverPage() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'اكتشف',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 8),
        const Text('كل يوم فرصة لسالفة جديدة.', style: TextStyle(color: muted)),
        const SizedBox(height: 22),
        _discoverCard(
          Icons.local_fire_department,
          'الرائج الآن',
          'مواضيع يتفاعل وياها المجتمع',
          const Color(0xFFEA658D),
        ),
        _discoverCard(
          Icons.groups_2_outlined,
          'مجتمعات جديدة',
          'تعرّف على ناس يشاركونك اهتماماتك',
          purple,
        ),
        _discoverCard(
          Icons.campaign_outlined,
          'قنوات تستحق المتابعة',
          'محتوى تختاره حسب ذوقك',
          cyan,
        ),
        const SizedBox(height: 12),
        const Text(
          'راح تظهر هنا اقتراحات فعلية بعد ربط قاعدة البيانات.',
          style: TextStyle(color: muted, fontSize: 12),
        ),
      ],
    );
  }

  Widget _discoverCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(subtitle, style: const TextStyle(color: muted, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_back_ios_new, size: 16, color: muted),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    final labels = ['محادثات', 'حالات', 'قنوات', 'اكتشف'];
    final icons = [
      Icons.chat_bubble_outline_rounded,
      Icons.circle_outlined,
      Icons.campaign_outlined,
      Icons.explore_outlined,
    ];

    return NavigationBar(
      height: 72,
      backgroundColor: const Color(0xFF121522),
      indicatorColor: purple.withValues(alpha: 0.25),
      selectedIndex: page,
      onDestinationSelected: (i) => setState(() => page = i),
      destinations: List.generate(4, (i) => NavigationDestination(
        icon: Icon(icons[i]),
        selectedIcon: Icon(icons[i], color: cyan),
        label: labels[i],
      )),
    );
  }

  void _notice(String title, String message) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: panel,
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تمام'),
          ),
        ],
      ),
    );
  }
}

class VexoSearch extends SearchDelegate<String> {
  VexoSearch({required this.names});

  final List<String> names;

  @override
  String get searchFieldLabel => 'ابحث عن محادثة';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: bg,
      appBarTheme: const AppBarTheme(backgroundColor: panel),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: muted),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      onPressed: () => query = '',
      icon: const Icon(Icons.clear),
    ),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, ''),
    icon: const Icon(Icons.arrow_back),
  );

  @override
  Widget buildResults(BuildContext context) => _results();

  @override
  Widget buildSuggestions(BuildContext context) => _results();

  Widget _results() {
    final results = names
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(
        child: Text('ماكو نتائج', style: TextStyle(color: muted)),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView(
        children: results.map((name) => ListTile(
          leading: const CircleAvatar(
            backgroundColor: purple,
            child: Icon(Icons.person_outline),
          ),
          title: Text(name),
          onTap: () => close(context, name),
        )).toList(),
      ),
    );
  }
}
