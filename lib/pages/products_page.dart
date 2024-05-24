import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/data/product_data.dart';
import 'package:test/models/product_model.dart';
import 'package:test/pages/cart_page.dart';
import 'package:test/pages/favourote_page.dart';
import 'package:test/provider/cart_provider.dart';
import 'package:test/provider/favourite_provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Shop ',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesPage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: 'favorite_button',
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            backgroundColor: Colors.deepOrange,
            heroTag: 'cart_button',
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            child: Consumer2<Cart, FavoritesProvider>(
              builder: (BuildContext context, Cart cart,
                  FavoritesProvider favorites, Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 50),
                      Text(
                        cart.items.containsKey(product.id)
                            ? cart.items[product.id]!.quantity.toString()
                            : '0',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text('\$${product.price}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          favorites.isFavorite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favorites.isFavorite(product.id)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          favorites.toggleFavorite(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(favorites.isFavorite(product.id)
                                  ? 'Added to favorites!'
                                  : 'Removed from favorites!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart,
                          color: cart.items.containsKey(product.id)
                              ? Colors.orangeAccent
                              : Colors.grey,
                        ),
                        onPressed: () {
                          cart.addItem(
                              product.id, product.price, product.title);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to cart!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
