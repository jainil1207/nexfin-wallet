import 'package:flutter/material.dart';
import '../state/app_state.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final primaryColor = Theme.of(context).primaryColor;

    double totalIncome = 0;
    double totalExpense = 0;

    for (var tx in appState.transactions) {
      if (tx.isIncome) {
        totalIncome += tx.amount;
      } else {
        totalExpense += tx.amount;
      }
    }

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Analytics & Stats',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: const Text('This Month', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Cashflow Summary Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildCashflowItem('Total Income', totalIncome, Colors.green, Icons.arrow_downward_rounded),
                          Container(height: 40, width: 1, color: Colors.white12),
                          _buildCashflowItem('Total Expense', totalExpense, Colors.redAccent, Icons.arrow_upward_rounded),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white12),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Net Cashflow', style: TextStyle(color: Colors.white70, fontSize: 14)),
                          Text(
                            '\$${(totalIncome - totalExpense).toStringAsFixed(2)}',
                            style: TextStyle(
                              color: (totalIncome - totalExpense) >= 0 ? primaryColor : Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                const Text('Spending Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 16),

                _buildCategoryTile('Transfer & Payments', 0.45, '\$540.00', primaryColor, Icons.swap_horiz_rounded),
                _buildCategoryTile('Shopping & Hardware', 0.25, '\$299.99', Colors.purpleAccent, Icons.shopping_bag_rounded),
                _buildCategoryTile('Dining & Coffee', 0.18, '\$145.00', Colors.orangeAccent, Icons.restaurant_rounded),
                _buildCategoryTile('Subscriptions', 0.12, '\$85.00', Colors.blueAccent, Icons.subscriptions_rounded),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCashflowItem(String label, double amount, Color color, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 13)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: TextStyle(color: color, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildCategoryTile(String title, double progress, String amount, Color color, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
              ),
              Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: Colors.white10,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
