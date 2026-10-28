import 'package:flutter/material.dart';

class CardModel {
  final String id;
  final String cardNumber;
  final String cardHolder;
  final String expiryDate;
  final double balance;
  final String cardType;
  final List<Color> gradientColors;

  CardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.balance,
    required this.cardType,
    required this.gradientColors,
  });

  String get maskedNumber {
    if (cardNumber.length < 4) return cardNumber;
    return '•••• •••• •••• ${cardNumber.substring(cardNumber.length - 4)}';
  }
}

class AssetModel {
  final String id;
  final String name;
  final String symbol;
  final double amountHold;
  final double fiatValue;
  final double change24h;
  final IconData icon;
  final Color color;

  AssetModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.amountHold,
    required this.fiatValue,
    required this.change24h,
    required this.icon,
    required this.color,
  });

  bool get isPositive => change24h >= 0;
}
