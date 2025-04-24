# CommZy

![Download APK](apk/)

CommZy is a basic e-commerce application built using Flutter. It provides a seamless shopping experience with features like product browsing, category filtering, product details, and cart management. The app is designed to work across multiple platforms, including Android, iOS.

## Tech Stack

- **Frontend**: Flutter (Dart)
- **State Management**: GetX
- **Networking**: HTTP package
- **Image Caching**: CachedNetworkImage
- **Animations**: Flutter's built-in animation widgets
- **Backend API**: DummyJSON API (for product and category data)

## Features

1. **Home Screen**:
   - Displays a list of products with their images, prices, and ratings.
   - Category filtering to view products by category.
   - Search functionality to find products by name.

2. **Product Details**:
   - Detailed view of a product with images, description, price, stock availability, and reviews.
   - Carousel slider for product images.
   - Animated star rating display.

3. **Cart Management**:
   - Add products to the cart.
   - Update product quantities in the cart.
   - View the total number of items in the cart.

4. **Responsive Design**:
   - Works across multiple platforms (Android, iOS, macOS, Linux, Windows, and Web).

5. **Error Handling**:
   - Custom error handling for network issues and API failures.

6. **Smooth Animations**:
   - Animated transitions between screens.
   - Animated loading indicators.

## Folder Structure

The project follows a modular structure for better scalability and maintainability:

- **lib/src/data**: Contains network services, error handling, and status management.
- **lib/src/models**: Data models for products, categories, and cart details.
- **lib/src/respository**: Repositories for fetching data from APIs.
- **lib/src/services**: Business logic for cart management.
- **lib/src/utils**: Utility functions like navigation helpers.
- **lib/src/viewmodels**: ViewModels for managing state and business logic.
- **lib/src/views**: UI components for different screens and widgets.
