import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoc_tren_truong/ui/product/view_models/cart_view_model.dart';
import 'package:hoc_tren_truong/utils/currency_formatter.dart';

import 'cart_card.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  // Chạy thao tác và hiển thị lỗi nếu có
  Future<void> _runAction(
      BuildContext context,
      Future<void> Function() action,
      ) async {
    try {
      await action();
    } catch (error) {
      if (!context.mounted) return;

      final message = error is StateError
          ? error.message
          : error.toString();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartViewModelProvider);

    return cartState.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => const Center(
        child: Text('Không thể tải giỏ hàng'),
      ),
      data: (items) {
        if (items.isEmpty) {
          return const Center(
            child: Text(
              'Giỏ hàng đang trống',
              style: TextStyle(fontSize: 20),
            ),
          );
        }

        final viewModel = ref.read(cartViewModelProvider.notifier);
        final total = viewModel.selectedTotal;
        final selectedCount = items
            .where((item) => item.isSelected)
            .length;

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return CartItemCard(
                    key: ValueKey(item.product.id),
                    item: item,
                    onIncrease: () async {
                      await _runAction(
                        context,
                            () => viewModel.changeQuantity(
                          item.product.id,
                          1,
                        ),
                      );
                    },
                    onDecrease: () async {
                      await _runAction(
                        context,
                            () => viewModel.changeQuantity(
                          item.product.id,
                          -1,
                        ),
                      );
                    },
                    onRemove: () async {
                      // Đặt số lượng về 0 để Repository xóa
                      await _runAction(
                        context,
                            () => viewModel.changeQuantity(
                          item.product.id,
                          -item.quantity,
                        ),
                      );
                    },
                    onSelected: (value) async {
                      await _runAction(
                        context,
                            () => viewModel.updateSelection(
                          item.product.id,
                          value,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Đã chọn $selectedCount sản phẩm'),
                  const SizedBox(height: 8),
                  Text(
                    'Tổng tiền: ${formatVnd(total)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    // Chưa triển khai thanh toán
                    onPressed: null,
                    icon: const Icon(Icons.payment),
                    label: const Text('Thanh toán'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}