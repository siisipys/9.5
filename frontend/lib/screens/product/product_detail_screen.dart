import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/product_service.dart';
import '../../core/services/auth_service.dart';
import '../../models/product_model.dart';
import 'product_form_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product _product;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
  }

  String _formatPrice(double price) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(price);
  }

  bool get _isOwner => _product.userId == AuthService.currentUser?.id;

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImageSection(),
                      const SizedBox(height: 24),
                      _buildInfoSection(),
                      const SizedBox(height: 24),
                      _buildDetailsCard(),
                      if (_isOwner) ...[
                        const SizedBox(height: 24),
                        _buildActionButtons(),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.surfaceGlass,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
          ).animate()
            .fadeIn(duration: 400.ms),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Product Details',
              style: Theme.of(context).textTheme.headlineMedium,
            ).animate()
              .fadeIn(duration: 500.ms, delay: 100.ms),
          ),
          if (_isOwner)
            IconButton(
              onPressed: _navigateToEdit,
              icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accentGold.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.accentGold,
                  size: 20,
                ),
              ),
            ).animate()
              .fadeIn(duration: 500.ms, delay: 200.ms),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.accentCoral.withOpacity(0.2),
                AppColors.accentGold.withOpacity(0.2),
              ],
            ),
          ),
          child: _product.image != null
              ? Image.network(
                  _product.image!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.textSecondary,
                      size: 64,
                    ),
                  ),
                )
              : const Center(
                  child: Icon(
                    Icons.inventory_2_outlined,
                    color: AppColors.textSecondary,
                    size: 64,
                  ),
                ),
        ),
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 200.ms)
      .slideY(begin: 0.1, end: 0, duration: 600.ms, delay: 200.ms);
  }

  Widget _buildInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _product.name,
          style: Theme.of(context).textTheme.displaySmall,
        ).animate()
          .fadeIn(duration: 500.ms, delay: 300.ms),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _product.stock > 0
                    ? AppColors.success.withOpacity(0.15)
                    : AppColors.error.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _product.stock > 0 ? 'In Stock' : 'Out of Stock',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: _product.stock > 0 ? AppColors.success : AppColors.error,
                ),
              ),
            ),
            const SizedBox(width: 12),
            if (_product.user != null)
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 16, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    _product.user!.name,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
          ],
        ).animate()
          .fadeIn(duration: 500.ms, delay: 400.ms),
        const SizedBox(height: 16),
        Text(
          _formatPrice(_product.price),
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.accentCoral,
            fontWeight: FontWeight.w700,
          ),
        ).animate()
          .fadeIn(duration: 500.ms, delay: 500.ms),
      ],
    );
  }

  Widget _buildDetailsCard() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          Text(
            _product.description ?? 'No description available',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          const Divider(color: AppColors.surfaceDivider),
          const SizedBox(height: 16),
          _buildDetailRow('Stock', '${_product.stock} units'),
          _buildDetailRow('Price', _formatPrice(_product.price)),
          if (_product.createdAt != null)
            _buildDetailRow(
              'Added',
              DateFormat('dd MMM yyyy').format(_product.createdAt!),
            ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms, delay: 600.ms)
      .slideY(begin: 0.1, end: 0, duration: 600.ms, delay: 600.ms);
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _isDeleting ? null : _deleteProduct,
            icon: _isDeleting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.delete_outline),
            label: const Text('Delete'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _navigateToEdit,
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    ).animate()
      .fadeIn(duration: 500.ms, delay: 700.ms);
  }

  void _navigateToEdit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductFormScreen(product: _product),
      ),
    );

    if (result == true) {
      // Reload the product
      try {
        final updated = await ProductService.getProduct(_product.id!);
        setState(() => _product = updated);
      } catch (e) {
        Navigator.pop(context, true);
      }
    }
  }

  Future<void> _deleteProduct() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primarySurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Product',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        content: Text(
          'Are you sure you want to delete "${_product.name}"? This action cannot be undone.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() => _isDeleting = true);

      try {
        await ProductService.deleteProduct(_product.id!);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product deleted successfully'),
              backgroundColor: AppColors.success,
            ),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString().replaceAll('Exception: ', '')),
              backgroundColor: AppColors.error,
            ),
          );
          setState(() => _isDeleting = false);
        }
      }
    }
  }
}
