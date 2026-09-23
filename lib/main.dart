import 'package:flutter/material.dart';

void main() {
  runApp(const ProductsApp());
}

class ProductsApp extends StatelessWidget {
  const ProductsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const ProductsScreen(),
    );
  }
}

class Product {
  final String name;
  final String description;
  final double price;
  final IconData icon;
  final Color color;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.color,
  });
}

const List<Product> kProducts = [
  Product(
    name: 'Wireless Headphones',
    description: 'Noise-cancelling, 30h battery life',
    price: 129.99,
    icon: Icons.headphones,
    color: Colors.indigo,
  ),
  Product(
    name: 'Smart Watch',
    description: 'Fitness tracking and notifications',
    price: 199.50,
    icon: Icons.watch,
    color: Colors.teal,
  ),
  Product(
    name: 'Mechanical Keyboard',
    description: 'Hot-swappable switches, RGB backlight',
    price: 89.00,
    icon: Icons.keyboard,
    color: Colors.deepOrange,
  ),
  Product(
    name: 'Portable Speaker',
    description: 'Waterproof, 12h playtime',
    price: 59.99,
    icon: Icons.speaker,
    color: Colors.purple,
  ),
  Product(
    name: '4K Monitor',
    description: '27-inch, HDR, USB-C',
    price: 349.00,
    icon: Icons.monitor,
    color: Colors.blueGrey,
  ),
  Product(
    name: 'Ergonomic Mouse',
    description: 'Vertical grip, wireless',
    price: 39.99,
    icon: Icons.mouse,
    color: Colors.green,
  ),
  Product(
    name: 'USB-C Hub',
    description: '7-in-1, HDMI + card reader',
    price: 45.50,
    icon: Icons.cable,
    color: Colors.brown,
  ),
  Product(
    name: 'Webcam 1080p',
    description: 'Autofocus, built-in mic',
    price: 74.99,
    icon: Icons.videocam,
    color: Colors.pink,
  ),
];

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;
    final crossAxisCount = screenWidth >= 900
        ? 4
        : screenWidth >= 600
            ? 3
            : 1;

    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: isTablet
          ? GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.4,
              ),
              itemCount: kProducts.length,
              itemBuilder: (context, index) {
                final product = kProducts[index];
                return ProductCard(product: product);
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: kProducts.length,
              itemBuilder: (context, index) {
                final product = kProducts[index];
                return ProductCard(product: product);
              },
            ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: product.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(product.icon, color: product.color, size: 32),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
