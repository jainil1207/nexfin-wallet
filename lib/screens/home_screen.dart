import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../state/app_state.dart';
import '../widgets/action_modals.dart';
import '../widgets/glassmorphic_hero_card.dart';
import 'transaction_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 280.0,
          collapsedHeight: 80.0,
          pinned: true,
          backgroundColor: const Color(0xFF0A0A0A).withValues(alpha: 0.95),
          surfaceTintColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
            background: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 20.0, right: 20.0, bottom: 50.0),
                child: GlassmorphicHeroCard(
                  balance: appState.totalBalance,
                  monthlyProfit: appState.monthlyProfit,
                  profitPercentage: appState.monthlyProfitPercentage,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  context,
                  icon: Icons.arrow_upward_rounded,
                  label: 'Send',
                  onTap: () => QuickActionModals.showSendModal(context),
                ),
                _buildActionButton(
                  context,
                  icon: Icons.arrow_downward_rounded,
                  label: 'Receive',
                  onTap: () => QuickActionModals.showReceiveModal(context),
                ),
                _buildActionButton(
                  context,
                  icon: Icons.swap_horiz_rounded,
                  label: 'Swap',
                  onTap: () => QuickActionModals.showSwapModal(context),
                ),
                _buildActionButton(
                  context,
                  icon: Icons.add_rounded,
                  label: 'Buy',
                  onTap: () => QuickActionModals.showBuyModal(context),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                Text(
                  '${appState.transactions.length} items',
                  style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 13),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final tx = appState.transactions[index];
              return _buildTransactionTile(context, tx);
            },
            childCount: appState.transactions.length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    final primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: primaryColor, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(BuildContext context, TransactionModel tx) {
    return Dismissible(
      key: ValueKey(tx.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 32),
        color: Colors.redAccent,
        child: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 30),
      ),
      onDismissed: (_) {
        AppStateProvider.of(context).removeTransaction(tx.id);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction removed'), duration: Duration(seconds: 1)),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              reverseTransitionDuration: const Duration(milliseconds: 350),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: TransactionDetailsScreen(transaction: tx),
                );
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
          child: Hero(
            tag: tx.id,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: tx.isIncome ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        tx.icon,
                        color: tx.isIncome ? Colors.green : Colors.red,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tx.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${tx.subtitle} • ${tx.formattedTime}',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      tx.formattedAmount,
                      style: TextStyle(
                        color: tx.isIncome ? Colors.green : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
