import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      home: ShopPage(),
    );
  }
}

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Product> products = [
    Product(
      title: 'โน๊ตบุ๊ค Asus ROG Zephyrus Duo 15 GX550LXS-HC060T Gray',
      price: 50.00,
      imageFileName: 'product1.jpg',
      description:
          'Asus Zephyrus Duo 15 GX550LXS-HF060T โน๊ตบุ๊คเกมมิ่งที่ขยายขอบเขตการใช้งานยิ่งขึ้น ด้วยจอทัชสกรีน ROG ScreenPad Plus สำหรับใช้งานแอปพลิเคชั่นเสริม สนับสนุนการทำงานหรือสตรีมเกมได้ มีขนาดจอ IPS 4K 15.6 นิ้ว 300Hz รองรับเฟรมเรทสูง ช่วงสี Adobe RGB 100% ใช้ทำงานกราฟิกเต็มรูปแบบได้ มี CPU Intel Core i9-10980HK, RAM 32GB ใช้งานลื่น ทำได้ทุกงานอย่างรวดเร็ว GPU NVIDIA GeForce RTX 2080 Super Max-Q Design เล่นได้ทุกเกม พร้อมปรับกราฟิกให้สวยที่สุดได้ รองรีบ Ray Tracing พร้อมออกแบบระบายความร้อนและใช้สารนำความร้อนแบบโลหะให้ประสิทธิภาพสูงยิ่งขึ้น โน๊ตบุ๊ค Asus Zephyrus Duo 15GX550LXS ใช้ SSD M.2 NVMe 2TB เก็บข้อมูล มี Windows 10 Home พร้อมใช้ คีย์บอร์ดพร้อมไฟ RGB ประกัน 2 ปีเต็ม',
    ),
    Product(
      title: 'Aston Martin Rapide E',
      price: 2000.00,
      imageFileName: 'product2.jpg',
      description:
          'Aston Martin Rapide E is an electric sports car known for its luxurious design and high performance. It comes with a powerful electric motor and advanced battery technology.',
    ),
    // Add more products here
  ];

  List<Product> cart = [];

  // Variables for sorting and searching
  String? selectedSort;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the shopping cart page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartPage(cart: cart),
                ),
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildSortAndSearch(),
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return _buildProductCard(products[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSortAndSearch() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              isExpanded: true,
              hint: Text('Sort by'),
              value: selectedSort,
              onChanged: (newValue) {
                setState(() {
                  selectedSort = newValue;
                  // Implement sorting logic based on selectedSort
                });
              },
              items: [
                'Price Low to High',
                'Price High to Low',
                'Name A to Z',
                'Name Z to A'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    // Implement search logic here
                  },
                ),
              ),
              onChanged: (text) {
                // Implement search logic here
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        onTap: () {
          // Navigate to the product details page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200.0,
              child: Image.asset(
                'lib/assets/product_images/${product.imageFileName}',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Price: \$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  if (!product.available)
                    Text(
                      'Out of Stock',
                      style: TextStyle(
                        color: Colors.red,
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

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300.0, // Increase the height for a larger image
            child: Image.asset(
              'lib/assets/product_images/${product.imageFileName}',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Price: \$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Description:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add the product to the shopping cart
                // You can implement shopping cart logic here
              },
              child: Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingCartPage extends StatelessWidget {
  final List<Product> cart;

  ShoppingCartPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return _buildCartItem(cart[index]);
        },
      ),
    );
  }

  Widget _buildCartItem(Product product) {
    return ListTile(
      leading: SizedBox(
        width: 80.0,
        height: 80.0,
        child: Image.asset(
          'lib/assets/product_images/${product.imageFileName}',
          fit: BoxFit.cover,
        ),
      ),
      title: Text(product.title),
      subtitle: Text('Price: \$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(Icons.remove_shopping_cart),
        onPressed: () {
          // Remove the product from the cart
          // You can implement cart removal logic here
        },
      ),
    );
  }
}

class Product {
  final String title;
  final double price;
  final String imageFileName;
  final bool available;
  final String description;

  Product({
    required this.title,
    required this.price,
    required this.imageFileName,
    this.available = true,
    required this.description,
  });
}
