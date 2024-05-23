import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/data/product_data.dart';
import 'package:test/provider/favourite_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorites'),
      ),
      body: Consumer<FavoritesProvider>(
        builder:
            (BuildContext context, FavoritesProvider favorites, Widget? child) {
          final favoriteItems = favorites.favorites.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList();

          if (favoriteItems.isEmpty) {
            return const Center(
              child: Text('No favorites added yet!'),
            );
          }

          return ListView.builder(
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              final productId = favoriteItems[index];
              final product = ProductData()
                  .products
                  .firstWhere((product) => product.id == productId);

              return Card(
                child: ListTile(
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      favorites.toggleFavorite(product.id);

                      // Show snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Removed from favorites!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
