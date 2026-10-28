import 'package:flutter/material.dart';

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime dateTime;
  final bool isIncome;
  final String category;
  final String status;
  final IconData icon;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.dateTime,
    required this.isIncome,
    required this.category,
    this.status = 'Completed',
    required this.icon,
  });

  String get formattedAmount {
    final prefix = isIncome ? '+\$' : '-\$';
    return '$prefix${amount.toStringAsFixed(2)}';
  }

  String get formattedTime {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : (dateTime.hour == 0 ? 12 : dateTime.hour);
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
