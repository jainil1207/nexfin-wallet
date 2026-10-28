import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../models/wallet_model.dart';

class AppState extends ChangeNotifier {
  double _totalBalance = 12450.50;
  double _monthlyProfit = 1240.00;
  final double _monthlyProfitPercentage = 12.5;

  String _userName = 'Jainil Trivedi';
  String _userEmail = 'jainil@example.com';
  final String _currencySymbol = '\$';

  final List<TransactionModel> _transactions = [
    TransactionModel(
      id: 'tx-1',
      title: 'Received from Alice',
      subtitle: 'Transfer • Received',
      amount: 150.00,
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
      isIncome: true,
      category: 'Transfer',
      icon: Icons.arrow_downward_rounded,
    ),
    TransactionModel(
      id: 'tx-2',
      title: 'Sent to Bob',
      subtitle: 'Payment • Coffee & Snacks',
      amount: 45.00,
      dateTime: DateTime.now().subtract(const Duration(hours: 5)),
      isIncome: false,
      category: 'Dining',
      icon: Icons.arrow_upward_rounded,
    ),
    TransactionModel(
      id: 'tx-3',
      title: 'Apple Store Purchase',
      subtitle: 'Electronics • iPad Access',
      amount: 299.99,
      dateTime: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      isIncome: false,
      category: 'Shopping',
      icon: Icons.shopping_bag_rounded,
    ),
    TransactionModel(
      id: 'tx-4',
      title: 'Salary Deposit',
      subtitle: 'Income • Tech Corp Inc.',
      amount: 3200.00,
      dateTime: DateTime.now().subtract(const Duration(days: 2)),
      isIncome: true,
      category: 'Salary',
      icon: Icons.work_rounded,
    ),
    TransactionModel(
      id: 'tx-5',
      title: 'Crypto Swap (USD to BTC)',
      subtitle: 'Investment • Swap',
      amount: 500.00,
      dateTime: DateTime.now().subtract(const Duration(days: 3)),
      isIncome: false,
      category: 'Investment',
      icon: Icons.swap_horiz_rounded,
    ),
  ];

  final List<CardModel> _cards = [
    CardModel(
      id: 'card-1',
      cardNumber: '4532891048291048',
      cardHolder: 'Jainil Trivedi',
      expiryDate: '08/28',
      balance: 8450.20,
      cardType: 'Visa Platinum',
      gradientColors: [const Color(0xFF00FF7F), const Color(0xFF00BFFF)],
    ),
    CardModel(
      id: 'card-2',
      cardNumber: '5219482019483019',
      cardHolder: 'Jainil Trivedi',
      expiryDate: '12/26',
      balance: 4000.30,
      cardType: 'Mastercard World',
      gradientColors: [const Color(0xFFFF512F), const Color(0xFFDD2476)],
    ),
  ];

  final List<AssetModel> _assets = [
    AssetModel(
      id: 'asset-1',
      name: 'Bitcoin',
      symbol: 'BTC',
      amountHold: 0.124,
      fiatValue: 8250.00,
      change24h: 3.45,
      icon: Icons.currency_bitcoin_rounded,
      color: const Color(0xFFFF9900),
    ),
    AssetModel(
      id: 'asset-2',
      name: 'Ethereum',
      symbol: 'ETH',
      amountHold: 1.85,
      fiatValue: 3100.50,
      change24h: -1.20,
      icon: Icons.token_rounded,
      color: const Color(0xFF627EEA),
    ),
    AssetModel(
      id: 'asset-3',
      name: 'USDT Stablecoin',
      symbol: 'USDT',
      amountHold: 1100.00,
      fiatValue: 1100.00,
      change24h: 0.01,
      icon: Icons.attach_money_rounded,
      color: const Color(0xFF26A17B),
    ),
  ];

  // Getters
  double get totalBalance => _totalBalance;
  double get monthlyProfit => _monthlyProfit;
  double get monthlyProfitPercentage => _monthlyProfitPercentage;
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get currencySymbol => _currencySymbol;

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);
  List<CardModel> get cards => List.unmodifiable(_cards);
  List<AssetModel> get assets => List.unmodifiable(_assets);

  // Actions
  void sendMoney(String recipient, double amount, String category) {
    if (amount <= 0) return;
    _totalBalance -= amount;
    _monthlyProfit -= amount * 0.1;

    _transactions.insert(
      0,
      TransactionModel(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        title: 'Sent to $recipient',
        subtitle: 'Transfer • $category',
        amount: amount,
        dateTime: DateTime.now(),
        isIncome: false,
        category: category,
        icon: Icons.arrow_upward_rounded,
      ),
    );
    notifyListeners();
  }

  void receiveMoney(String sender, double amount, String category) {
    if (amount <= 0) return;
    _totalBalance += amount;
    _monthlyProfit += amount * 0.2;

    _transactions.insert(
      0,
      TransactionModel(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        title: 'Received from $sender',
        subtitle: 'Income • $category',
        amount: amount,
        dateTime: DateTime.now(),
        isIncome: true,
        category: category,
        icon: Icons.arrow_downward_rounded,
      ),
    );
    notifyListeners();
  }

  void swapCurrency(String fromAsset, String toAsset, double amount) {
    if (amount <= 0) return;

    _transactions.insert(
      0,
      TransactionModel(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        title: 'Swapped $fromAsset to $toAsset',
        subtitle: 'Swap • Crypto',
        amount: amount,
        dateTime: DateTime.now(),
        isIncome: false,
        category: 'Swap',
        icon: Icons.swap_horiz_rounded,
      ),
    );
    notifyListeners();
  }

  void buyCrypto(String asset, double amount) {
    if (amount <= 0) return;
    _totalBalance += amount;

    _transactions.insert(
      0,
      TransactionModel(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        title: 'Bought $asset',
        subtitle: 'Investment • Purchase',
        amount: amount,
        dateTime: DateTime.now(),
        isIncome: true,
        category: 'Investment',
        icon: Icons.add_rounded,
      ),
    );
    notifyListeners();
  }

  void addQuickFunds(double amount) {
    _totalBalance += amount;
    _monthlyProfit += amount;
    _transactions.insert(
      0,
      TransactionModel(
        id: 'tx-${DateTime.now().millisecondsSinceEpoch}',
        title: 'Quick Top-Up',
        subtitle: 'Deposit • Card',
        amount: amount,
        dateTime: DateTime.now(),
        isIncome: true,
        category: 'Deposit',
        icon: Icons.attach_money_rounded,
      ),
    );
    notifyListeners();
  }

  void removeTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }

  void updateUserProfile(String name, String email) {
    _userName = name;
    _userEmail = email;
    notifyListeners();
  }
}

class AppStateProvider extends InheritedNotifier<AppState> {
  const AppStateProvider({
    super.key,
    required AppState appState,
    required super.child,
  }) : super(notifier: appState);

  static AppState of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(provider != null, 'No AppStateProvider found in context');
    return provider!.notifier!;
  }
}
