import 'package:flutter/material.dart';
import '../models/wallet_model.dart';
import '../state/app_state.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);

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
                    const Text('My Wallet', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 28),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Card / Account Linking feature opened!')),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Cards Horizontal Scroll
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: appState.cards.length,
                    itemBuilder: (context, index) {
                      final card = appState.cards[index];
                      return _buildCreditCard(card);
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // Crypto / Fiat Assets Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Crypto & Holdings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text('${appState.assets.length} assets', style: const TextStyle(color: Colors.white54, fontSize: 13)),
                  ],
                ),
                const SizedBox(height: 16),

                ...appState.assets.map((asset) => _buildAssetTile(asset)),

                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCard(CardModel card) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: card.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: card.gradientColors.first.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(card.cardType, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16)),
              const Icon(Icons.contactless_rounded, color: Colors.black87, size: 24),
            ],
          ),
          Text(
            card.maskedNumber,
            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CARD HOLDER', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.bold)),
                  Text(card.cardHolder, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('EXPIRES', style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.bold)),
                  Text(card.expiryDate, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssetTile(AssetModel asset) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
            decoration: BoxDecoration(color: asset.color.withValues(alpha: 0.15), shape: BoxShape.circle),
            child: Icon(asset.icon, color: asset.color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(asset.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text('${asset.amountHold} ${asset.symbol}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$${asset.fiatValue.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(
                '${asset.isPositive ? '+' : ''}${asset.change24h}%',
                style: TextStyle(color: asset.isPositive ? Colors.green : Colors.redAccent, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
