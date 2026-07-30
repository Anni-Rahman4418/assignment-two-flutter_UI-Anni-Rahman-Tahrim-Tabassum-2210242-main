import 'package:flutter/material.dart';

void main() {
  runApp(const StudentFinanceApp());
}

class StudentFinanceApp extends StatelessWidget {
  const StudentFinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Finance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4361EE)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    ReportsPage(),
    CardsPage(),
    ProfilePage(),
  ];

  final List<String> _labels = ['Home', 'Reports', 'Cards', 'Profile'];
  final List<IconData> _icons = [
    Icons.home_rounded,
    Icons.bar_chart_rounded,
    Icons.credit_card_rounded,
    Icons.person_rounded,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _onNavTap(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(15),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_labels.length, (i) {
                final selected = _currentIndex == i;
                return GestureDetector(
                  onTap: () => _onNavTap(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? const Color(0xFF4361EE).withAlpha(15) : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _icons[i],
                          color: selected ? const Color(0xFF4361EE) : Colors.grey,
                          size: 22,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _labels[i],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                            color: selected ? const Color(0xFF4361EE) : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
// PAGE 1 – HOME
// ─────────────────────────────────────────
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildBalanceCard(),
              const SizedBox(height: 24),
              _buildActionButtons(),
              const SizedBox(height: 28),
              _buildRecentTransactions(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back,', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            const Text(
              'Anni Rahman Tahrim Tabassum',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
            ),
          ],
        ),
        Row(
          children: [
            _iconBtn(Icons.notifications_none_rounded),
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 18,
              backgroundColor: const Color(0xFF4361EE),
              child: const Text('AT', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _iconBtn(IconData icon) {
    return Container(
      width: 36, height: 36,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 6)]),
      child: Icon(icon, size: 20, color: Colors.grey[700]),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4361EE), Color(0xFF3A0CA3)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: const Color(0xFF4361EE).withAlpha(15), blurRadius: 20, offset: const Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Balance', style: TextStyle(color: Colors.white70, fontSize: 13)),
              Icon(Icons.open_in_new_rounded, color: Colors.white70, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          const Text('\$8,945.92',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statChip('Savings: \$5,500'),
              _statChip('Last 30 days: +\$300 →'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11)),
    );
  }

  Widget _buildActionButtons() {
    final actions = [
      {'icon': Icons.swap_horiz_rounded, 'label': 'Transfer'},
      {'icon': Icons.receipt_long_rounded, 'label': 'Pay Bills'},
      {'icon': Icons.trending_up_rounded, 'label': 'Invest'},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: actions.map((a) {
        return Column(
          children: [
            Container(
              width: 58, height: 58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 10)],
              ),
              child: Icon(a['icon'] as IconData, color: const Color(0xFF4361EE), size: 26),
            ),
            const SizedBox(height: 8),
            Text(a['label'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildRecentTransactions() {
    final txns = [
      {'icon': Icons.play_circle_outline, 'title': 'Netflix Subscri...', 'sub': 'Entertainment · Today', 'amt': '-\$19.99', 'color': Colors.red, 'bg': Colors.red},
      {'icon': Icons.coffee_rounded, 'title': 'Coffee Shop', 'sub': 'Food & Drink · Today', 'amt': '-\$4.50', 'color': Colors.red, 'bg': Colors.orange},
      {'icon': Icons.account_balance_wallet_rounded, 'title': 'Salary Deposit', 'sub': 'Income · Today', 'amt': '+\$3500.00', 'color': Colors.green, 'bg': Colors.green},
      {'icon': Icons.shopping_cart_rounded, 'title': 'Grocery Store', 'sub': 'Shopping · Yesterday', 'amt': '-\$55.80', 'color': Colors.red, 'bg': Colors.blue},
      {'icon': Icons.local_shipping_rounded, 'title': 'Amazon Purchase', 'sub': 'Shopping · 3 days ago', 'amt': '-\$120.45', 'color': Colors.red, 'bg': Colors.purple},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Recent Transactions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('View All', style: TextStyle(fontSize: 13, color: const Color(0xFF4361EE), fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 14),
        ...txns.map((t) => _txnTile(t)),
      ],
    );
  }

  Widget _txnTile(Map t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: (t['bg'] as Color).withAlpha(15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(t['icon'] as IconData, color: t['bg'] as Color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t['title'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                Text(t['sub'], style: TextStyle(fontSize: 11, color: Colors.grey[500])),
              ],
            ),
          ),
          Text(t['amt'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: t['color'] as Color)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// PAGE 2 – REPORTS
// ─────────────────────────────────────────
class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'label': 'Food & Drink', 'amount': '\$450.00 (35%)', 'pct': 0.35, 'color': const Color(0xFFFF6B6B)},
      {'label': 'Shopping', 'amount': '\$320.00 (25%)', 'pct': 0.25, 'color': const Color(0xFF4361EE)},
      {'label': 'Housing', 'amount': '\$280.00 (22%)', 'pct': 0.22, 'color': const Color(0xFFFFA500)},
      {'label': 'Transport', 'amount': '\$150.00 (12%)', 'pct': 0.12, 'color': const Color(0xFF06D6A0)},
      {'label': 'Other', 'amount': '\$70.00 (6%)', 'pct': 0.06, 'color': const Color(0xFFADB5BD)},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 24),
              _buildSummaryCard(),
              const SizedBox(height: 24),
              const Text('Spending Breakdown',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
              const SizedBox(height: 14),
              ...categories.map((c) => _buildBar(c)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back,', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            const Text('Anni Rahman Tahrim Tabassum', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
          ],
        ),
        CircleAvatar(radius: 18, backgroundColor: const Color(0xFF4361EE),
          child: const Text('AT', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 14)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Monthly Spending Report', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: const Color(0xFF1A1A2E))),
          const SizedBox(height: 4),
          Text('Total Expenses (Last 30 days)', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
          const SizedBox(height: 10),
          const Text('-\$1,270.00',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xFFFF6B6B))),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.arrow_upward_rounded, color: Color(0xFFFF6B6B), size: 14),
              Text(' 13% more than last month',
                style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(Map c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(c['label'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Text(c['amount'] as String, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: c['pct'] as double,
              minHeight: 8,
              backgroundColor: Colors.grey[100],
              valueColor: AlwaysStoppedAnimation<Color>(c['color'] as Color),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
// PAGE 3 – CARDS
// ─────────────────────────────────────────
class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 24),
              const Text('My Cards', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
              const SizedBox(height: 20),
              _buildCardWidget(),
              const SizedBox(height: 24),
              _buildCardActions(),
              const SizedBox(height: 24),
              if (_showDetails) _buildCardDetails(),
              _buildLinkedAccounts(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Welcome back,', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          const Text('Anni Rahman Tahrim Tabassum', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
        ]),
        CircleAvatar(radius: 18, backgroundColor: const Color(0xFF4361EE),
          child: const Text('AT', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _buildCardWidget() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 36, height: 24,
                decoration: BoxDecoration(color: const Color(0xFFFFA500).withAlpha(15), borderRadius: BorderRadius.circular(4)),
              ),
              const Text('BANK', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, letterSpacing: 2)),
            ],
          ),
          const Text('4567  ****  ****  1234',
            style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2, fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('CARD HOLDER', style: TextStyle(color: Colors.white54, fontSize: 9, letterSpacing: 1)),
                const Text('Anni Rahman Tahrim Tabassum', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                const Text('EXPIRES', style: TextStyle(color: Colors.white54, fontSize: 9, letterSpacing: 1)),
                const Text('12/28', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _actionBtn(Icons.block_rounded, 'Block', Colors.red, () {}),
        _actionBtn(Icons.info_outline_rounded, 'Details', const Color(0xFF4361EE), () {
          setState(() => _showDetails = !_showDetails);
        }),
        _actionBtn(Icons.credit_score_rounded, 'Limit', Colors.orange, () {}),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(
          width: 56, height: 56,
          decoration: BoxDecoration(
            color: color.withAlpha(15), borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withAlpha(15)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500)),
      ]),
    );
  }

  Widget _buildCardDetails() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Card Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 12),
          _detailRow('Card Number', '4567 **** **** 1234'),
          _detailRow('Card Type', 'Visa Debit'),
          _detailRow('Available Limit', '\$5,000.00'),
          _detailRow('Used', '\$1,270.00'),
          _detailRow('Status', 'Active ✓'),
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildLinkedAccounts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Linked Accounts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8)],
          ),
          child: Row(
            children: [
              CircleAvatar(radius: 20, backgroundColor: const Color(0xFF4361EE).withAlpha(15),
                child: const Icon(Icons.savings_rounded, color: Color(0xFF4361EE), size: 20)),
              const SizedBox(width: 14),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Shared Savings', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  Text('\$9,000.00', style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ],
              )),
              const Icon(Icons.chevron_right_rounded, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
// PAGE 4 – PROFILE
// ─────────────────────────────────────────
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 24),
              const Center(
                child: Text('User Profile',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
              ),
              const SizedBox(height: 24),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: const Color(0xFF4361EE),
                      child: const Text('AT',
                        style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 4)]),
                      child: const Icon(Icons.edit_rounded, size: 16, color: Color(0xFF4361EE)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              _infoCard([
                _InfoItem(label: 'Name', value: 'Anni Rahman Tahrim Tabassum', icon: Icons.person_rounded),
                _InfoItem(label: 'Student ID', value: '2210242', icon: Icons.badge_rounded),
                _InfoItem(label: 'Email', value: '2210242@iub.edu.bd', icon: Icons.email_rounded),
              ]),
              const SizedBox(height: 20),
              _bioCard(),
              const SizedBox(height: 20),
              _settingsSection(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Welcome back,', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
          const Text('Anni Rahman Tahrim Tabassum', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E))),
        ]),
        CircleAvatar(radius: 18, backgroundColor: const Color(0xFF4361EE),
          child: const Text('AT', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
      ],
    );
  }

  Widget _infoCard(List<_InfoItem> items) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12)],
      ),
      child: Column(
        children: items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(item.icon, size: 14, color: const Color(0xFF4361EE)),
                  const SizedBox(width: 6),
                  Text(item.label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
                ]),
                const SizedBox(height: 4),
                Text(item.value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
                if (items.last.label != item.label)
                  Padding(padding: const EdgeInsets.only(top: 10),
                    child: Divider(color: Colors.grey[100], height: 1)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _bioCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: const [
            Icon(Icons.auto_stories_rounded, size: 14, color: Color(0xFF4361EE)),
            SizedBox(width: 6),
            Text('Bio / Story', style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
          ]),
          const SizedBox(height: 10),
          const Text(
            'I\'m a Computer Science student at IUB, passionate about building meaningful software. I believe financial literacy is key to living a balanced student life. Outside of coding, I enjoy working out and, exploring new technologies, and collaborating on real-world projects with friends.',
            style: TextStyle(fontSize: 14, color: Color(0xFF3A3A5C), height: 1.6),
          ),
        ],
      ),
    );
  }

  Widget _settingsSection() {
    final options = [
      {'icon': Icons.lock_outline_rounded, 'label': 'Change Password', 'color': const Color(0xFF4361EE)},
      {'icon': Icons.notifications_none_rounded, 'label': 'Notifications', 'color': Colors.orange},
      {'icon': Icons.help_outline_rounded, 'label': 'Help & Support', 'color': Colors.green},
      {'icon': Icons.logout_rounded, 'label': 'Log Out', 'color': Colors.red},
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 12)],
      ),
      child: Column(
        children: options.asMap().entries.map((e) {
          final i = e.key; final opt = e.value;
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: (opt['color'] as Color).withAlpha(15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(opt['icon'] as IconData, color: opt['color'] as Color, size: 18),
                ),
                title: Text(opt['label'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey, size: 20),
                onTap: () {},
              ),
              if (i < options.length - 1)
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 1, color: Colors.grey[100])),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InfoItem {
  final String label;
  final String value;
  final IconData icon;
  const _InfoItem({required this.label, required this.value, required this.icon});
}