import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/animated_button.dart';
import '../../core/widgets/animated_text_field.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/product_service.dart';
import '../../core/services/auth_service.dart';
import '../../models/product_model.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _imageController = TextEditingController();
  bool _isLoading = false;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _nameController.text = widget.product!.name;
      _descriptionController.text = widget.product!.description ?? '';
      _priceController.text = widget.product!.price.toStringAsFixed(0);
      _stockController.text = widget.product!.stock.toString();
      _imageController.text = widget.product!.image ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final product = Product(
        id: widget.product?.id,
        userId: AuthService.currentUser?.id ?? 0,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        price: double.parse(_priceController.text),
        stock: int.parse(_stockController.text),
        image: _imageController.text.trim().isEmpty
            ? null
            : _imageController.text.trim(),
      );

      if (_isEditing) {
        await ProductService.updateProduct(widget.product!.id!, product);
      } else {
        await ProductService.createProduct(product);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditing
                ? 'Product updated successfully'
                : 'Product created successfully'),
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
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

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
                  child: GlassCard(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Product Name
                          AnimatedTextField(
                            controller: _nameController,
                            label: 'Product Name',
                            hint: 'Enter product name',
                            prefixIcon: Icons.inventory_2_outlined,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter product name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Description
                          AnimatedTextField(
                            controller: _descriptionController,
                            label: 'Description',
                            hint: 'Enter product description (optional)',
                            prefixIcon: Icons.description_outlined,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 20),

                          // Price
                          AnimatedTextField(
                            controller: _priceController,
                            label: 'Price (Rp)',
                            hint: 'Enter price',
                            prefixIcon: Icons.attach_money,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter price';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Stock
                          AnimatedTextField(
                            controller: _stockController,
                            label: 'Stock',
                            hint: 'Enter stock quantity',
                            prefixIcon: Icons.numbers,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter stock';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Image URL
                          AnimatedTextField(
                            controller: _imageController,
                            label: 'Image URL',
                            hint: 'Enter image URL (optional)',
                            prefixIcon: Icons.image_outlined,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _submit(),
                          ),
                          const SizedBox(height: 32),

                          // Submit Button
                          AnimatedButton(
                            text: _isEditing ? 'Update Product' : 'Create Product',
                            onPressed: _submit,
                            isLoading: _isLoading,
                            icon: _isEditing ? Icons.save_outlined : Icons.add,
                          ),
                        ],
                      ),
                    ),
                  ).animate()
                    .fadeIn(duration: 600.ms, delay: 200.ms)
                    .slideY(begin: 0.1, end: 0, duration: 600.ms, delay: 200.ms),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isEditing ? 'Edit Product' : 'New Product',
                  style: Theme.of(context).textTheme.headlineMedium,
                ).animate()
                  .fadeIn(duration: 500.ms, delay: 100.ms),
                Text(
                  _isEditing
                      ? 'Update product details'
                      : 'Add a new product to your inventory',
                  style: Theme.of(context).textTheme.bodySmall,
                ).animate()
                  .fadeIn(duration: 500.ms, delay: 150.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
