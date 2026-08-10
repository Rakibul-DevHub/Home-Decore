import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/kolek_colors.dart';
import '../../../widgets/kolek_widgets.dart';
import '../cubit/cart_cubit.dart';
import '../data/cart_data.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KolekColors.neutral50,
      appBar: AppBar(
        backgroundColor: KolekColors.neutral50,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back, size: 20),
        ),
        centerTitle: true,
        title: Text(
          'kolek',
          style: KolekText.mono(size: 22, color: KolekColors.blue600),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) => ListView(
          padding: const EdgeInsets.fromLTRB(18, 6, 18, 110),
          children: [
            Text(
              'Your Cart',
              style: KolekText.sans(
                size: 47,
                weight: FontWeight.w700,
                height: 1,
              ),
            ),
            const SizedBox(height: 10),
            Text('${state.itemCount} Items', style: KolekText.mono(size: 10)),
            const Divider(height: 30),
            ...state.items.indexed.expand(
              (entry) => [
                _CartItem(item: entry.$2),
                Divider(height: entry.$1 == state.items.length - 1 ? 28 : 22),
              ],
            ),
            _PriceRow(label: 'SUBTOTAL', value: '\$${state.subtotal}'),
            const SizedBox(height: 18),
            _PriceRow(
              label: 'Shipping',
              value: CartData.shipping == 0 ? 'Free' : '\$${CartData.shipping}',
            ),
            const Divider(height: 34),
            Row(
              children: [
                Text(
                  'TOTAL',
                  style: KolekText.sans(size: 13, weight: FontWeight.w700),
                ),
                const Spacer(),
                Text(
                  '\$${state.total}',
                  style: KolekText.sans(size: 24, weight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomSheet: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                shape: const RoundedRectangleBorder(),
                backgroundColor: KolekColors.blue600,
              ),
              child: Text(
                'Checkout',
                style: KolekText.sans(size: 13, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CartItem extends StatelessWidget {
  const _CartItem({required this.item});

  final CartLine item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116,
      child: Row(
        children: [
          SizedBox(
            width: 94,
            height: 94,
            child: Image.asset(item.image, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: KolekText.sans(
                    size: 12,
                    weight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      '\$${item.price}',
                      style: KolekText.sans(
                        size: 12,
                        color: KolekColors.blue600,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () => context.read<CartCubit>().decrement(item.id),
                      child: const Icon(Icons.remove, size: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        'QTY:  ${item.quantity}',
                        style: KolekText.mono(size: 10),
                      ),
                    ),
                    InkWell(
                      onTap: () => context.read<CartCubit>().increment(item.id),
                      child: const Icon(Icons.add, size: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: KolekText.mono(size: 10)),
        const Spacer(),
        Text(value, style: KolekText.sans(size: 11)),
      ],
    );
  }
}
