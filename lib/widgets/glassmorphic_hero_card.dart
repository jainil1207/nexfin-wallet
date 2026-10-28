import 'dart:ui';
import 'package:flutter/material.dart';

class GlassmorphicHeroCard extends StatelessWidget {
  final double balance;
  final double monthlyProfit;
  final double profitPercentage;

  const GlassmorphicHeroCard({
    super.key,
    required this.balance,
    required this.monthlyProfit,
    required this.profitPercentage,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1.5,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.15),
                Colors.white.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Total Portfolio Balance',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 10),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: balance * 0.9, end: balance),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutQuart,
                builder: (context, value, child) {
                  return Text(
                    '\$${value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Growth',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            monthlyProfit >= 0 ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                            color: monthlyProfit >= 0 ? primaryColor : Colors.redAccent,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '\$${monthlyProfit.abs().toStringAsFixed(2)}',
                            style: TextStyle(
                              color: monthlyProfit >= 0 ? primaryColor : Colors.redAccent,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: (monthlyProfit >= 0 ? primaryColor : Colors.redAccent).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${profitPercentage >= 0 ? '+' : ''}${profitPercentage.toStringAsFixed(1)}%',
                      style: TextStyle(
                        color: monthlyProfit >= 0 ? primaryColor : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
