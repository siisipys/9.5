import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/services/auth_service.dart';
import '../auth/login_screen.dart';
import '../product/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = AuthService.currentUser;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: AppColors.gradientPrimary,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with user info
                _buildHeader(user?.name ?? 'User'),
                const SizedBox(height: 32),
                
                // Welcome Card
                _buildWelcomeCard(),
                const SizedBox(height: 24),
                
                // Quick Stats
                _buildStatsSection(),
                const SizedBox(height: 24),
                
                // Menu Grid
                _buildMenuGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String userName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: Theme.of(context).textTheme.bodyMedium,
            ).animate()
              .fadeIn(duration: 500.ms),
            const SizedBox(height: 4),
            Text(
              userName,
              style: Theme.of(context).textTheme.displaySmall,
            ).animate()
              .fadeIn(duration: 500.ms, delay: 100.ms)
              .slideX(begin: -0.1, end: 0, duration: 500.ms, delay: 100.ms),
          ],
        ),
        Row(
          children: [
            // Profile Avatar
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.gradientCoral,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentCoral.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                  style: GoogleFonts.crimsonPro(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ).animate()
              .fadeIn(duration: 500.ms, delay: 200.ms)
              .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), duration: 500.ms, delay: 200.ms),
            const SizedBox(width: 12),
            
            // Logout Button
            IconButton(
              onPressed: _logout,
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceGlass,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.textSecondary,
                  size: 22,
                ),
              ),
            ).animate()
              .fadeIn(duration: 500.ms, delay: 300.ms),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeCard() {
    return GlassCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to ProductHub',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Manage your products efficiently with our premium dashboard.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _navigateToProducts,
                  icon: const Icon(Icons.arrow_forward, size: 18),
                  label: const Text('View Products'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColors.gradientGold,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              size: 40,
              color: AppColors.primaryDeep,
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 300.ms)
      .slideY(begin: 0.1, end: 0, duration: 600.ms, delay: 300.ms);
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Overview',
          style: Theme.of(context).textTheme.titleLarge,
        ).animate()
          .fadeIn(duration: 500.ms, delay: 400.ms),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.shopping_bag_outlined,
                label: 'Products',
                value: '—',
                color: AppColors.accentCoral,
                delay: 500,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                icon: Icons.person_outline,
                label: 'Account',
                value: 'Active',
                color: AppColors.success,
                delay: 600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required int delay,
  }) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 500.ms, delay: Duration(milliseconds: delay))
      .slideY(begin: 0.1, end: 0, duration: 500.ms, delay: Duration(milliseconds: delay));
  }

  Widget _buildMenuGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ).animate()
          .fadeIn(duration: 500.ms, delay: 700.ms),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: [
            _buildMenuCard(
              icon: Icons.list_alt_rounded,
              title: 'All Products',
              subtitle: 'View & manage',
              gradient: AppColors.gradientCoral,
              onTap: _navigateToProducts,
              delay: 800,
            ),
            _buildMenuCard(
              icon: Icons.add_box_outlined,
              title: 'Add Product',
              subtitle: 'Create new',
              gradient: AppColors.gradientGold,
              onTap: _navigateToAddProduct,
              delay: 900,
            ),
            _buildMenuCard(
              icon: Icons.person_outline,
              title: 'Profile',
              subtitle: 'View account',
              gradient: [AppColors.success, AppColors.successLight],
              onTap: () {},
              delay: 1000,
            ),
            _buildMenuCard(
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle: 'App config',
              gradient: [AppColors.primaryLight, AppColors.primarySurface],
              onTap: () {},
              delay: 1100,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required List<Color> gradient,
    required VoidCallback onTap,
    required int delay,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: gradient),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: gradient.first.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: AppColors.textPrimary, size: 28),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(duration: 500.ms, delay: Duration(milliseconds: delay))
      .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1), duration: 500.ms, delay: Duration(milliseconds: delay));
  }

  void _navigateToProducts() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProductListScreen()),
    );
  }

  void _navigateToAddProduct() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ProductListScreen()),
    );
  }

  Future<void> _logout() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primarySurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Logout',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await AuthService.logout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
    }
  }
}
