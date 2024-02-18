import 'package:flutter/material.dart';
import 'ClaseIntermediaria.dart';

class YourNewScreen extends StatefulWidget {
  final List<String> imageUrls;
  final int index;
  const YourNewScreen(this.imageUrls, this.index, {super.key});

  @override
  State<YourNewScreen> createState() => _YourNewScreenState();
}

class _YourNewScreenState extends State<YourNewScreen> {
  final CartIndexList _cartIndexList =
      CartIndexList(); // Instancia de CartIndexList

  int productCount = 0;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton.filled(
        tooltip: 'Añadir a la bolsa',
        color: Colors.amber,
        onPressed: () {
          setState(() {
            _cartIndexList
                .addIndex(widget.index); // Agregar el índice al carrito
            productCount++; // Incrementar el contador de productos
          });
        },
        icon: const Icon(
          Icons.switch_access_shortcut_add_rounded,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Hello"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_bag,
                  size: 40,
                ),
              ),
              if (productCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 139, 54),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$productCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(widget.imageUrls[widget.index]),
                IconButton.outlined(
                  icon: isPressed
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_outline_rounded),
                  onPressed: () {
                    setState(() {
                      isPressed = !isPressed;
                    });
                  },
                ),
                Text('Detalles de la imagen ${widget.index}',
                    style: const TextStyle(fontSize: 38)),
                const Center(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas euismod consequat quam, ut fermentum est tempor in. Vivamus euismod arcu nec finibus laoreet. Sed vulputate libero vel eleifend pellentesque. Integer quis nisi quis dolor malesuada consequat eu sit amet nisi.',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 230, 230, 230),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_florist_rounded,
                          ),
                          Text('Tipo')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                          ),
                          Text('450')
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
