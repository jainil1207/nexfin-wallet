import 'package:flutter/material.dart';
import '../state/app_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _biometricsEnabled = true;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    final primaryColor = Theme.of(context).primaryColor;

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const Text('Profile & Account', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 24),

                // User Info Header Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: primaryColor.withValues(alpha: 0.2),
                        child: Text(
                          appState.userName.isNotEmpty ? appState.userName[0] : 'U',
                          style: TextStyle(color: primaryColor, fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(appState.userName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(appState.userEmail, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.white70),
                        onPressed: () => _showEditProfileDialog(context, appState),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                const Text('Security & Preferences', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70)),
                const SizedBox(height: 12),

                _buildSwitchTile('Biometric Authentication', Icons.fingerprint_rounded, _biometricsEnabled, (val) {
                  setState(() => _biometricsEnabled = val);
                }),
                _buildSwitchTile('Push Notifications', Icons.notifications_none_rounded, _notificationsEnabled, (val) {
                  setState(() => _notificationsEnabled = val);
                }),
                _buildOptionTile('Primary Currency', appState.currencySymbol, Icons.attach_money_rounded, () {}),
                _buildOptionTile('Security PIN & Password', 'Change', Icons.lock_outline_rounded, () {}),

                const SizedBox(height: 24),
                const Text('Support & Legal', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white70)),
                const SizedBox(height: 12),

                _buildOptionTile('Help & Customer Support', '', Icons.headset_mic_outlined, () {}),
                _buildOptionTile('Privacy Policy & Terms', '', Icons.shield_outlined, () {}),

                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.redAccent),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out of session')),
                      );
                    },
                    icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                    label: const Text('Log Out', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 22),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))),
          Switch(
            value: value,
            activeThumbColor: Theme.of(context).primaryColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(String title, String trailing, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(icon, color: Colors.white70, size: 22),
                const SizedBox(width: 14),
                Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))),
                if (trailing.isNotEmpty)
                  Text(trailing, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white30, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, AppState appState) {
    final nameController = TextEditingController(text: appState.userName);
    final emailController = TextEditingController(text: appState.userEmail);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Full Name', labelStyle: TextStyle(color: Colors.white60)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Email', labelStyle: TextStyle(color: Colors.white60)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {
                appState.updateUserProfile(nameController.text.trim(), emailController.text.trim());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile updated successfully!')),
                );
              },
              child: const Text('Save', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}
