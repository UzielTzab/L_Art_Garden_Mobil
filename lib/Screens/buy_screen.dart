import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/detalle_pedido.dart';
import 'package:l_art_garden_mobil/Screens/login_screen.dart';
import 'package:l_art_garden_mobil/Screens/payment_form_screen.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/flower_shops_provider.dart';
import 'package:l_art_garden_mobil/model_provider/users_provider.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:l_art_garden_mobil/model_provider/cart_provider.dart';
import '../model_provider/flower_shops_provider.dart';
import '../Services/detalle_pedido.dart';
import '../Models/pedido.dart';
import '../Services/service_pedido.dart';

class BuyScreen extends StatelessWidget {
  final double totalAmount;
  final int totalQuantity;

  BuyScreen({required this.totalAmount, required this.totalQuantity});
  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 107, 77, 12);
  static const Color disableColor = Color.fromARGB(255, 193, 193, 193);
  @override
  Widget build(BuildContext context) {
    // Obtén la instancia de CartListProvider
    var cartListProvider = Provider.of<CartListProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    // Agrupa los productos por florería
    var groupedProducts = groupBy(
      cartListProvider.products,
      (CartProvider product) => product.idInventario,
    );
    var flowerShopProvider = Provider.of<FlowerShopProvider>(context);
    var allFlowerShops = flowerShopProvider.flowerShops;
    print(
        "----------------------------------------Ver si el provider de florerias tienes datos--------------------------------");
    allFlowerShops.forEach((shop) {
      print(
          'Florería: ${shop.nombreFloreria}, ID de inventario: ${shop.idInventario}');
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle de pedido',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: baseColor,
      ),
      body: ListView.builder(
        itemCount: groupedProducts.keys.length,
        itemBuilder: (context, index) {
          final shopId = groupedProducts.keys.elementAt(index);
          final shop =
              allFlowerShops.firstWhere((shop) => shop.idFloreria == shopId);
          final shopProducts = groupedProducts[shopId]!;
          return Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: baseColor, // Usa tu variable baseColor
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                20.0), // Ajusta el valor para cambiar el radio del borde
                            topRight: Radius.circular(
                                20.0), // Ajusta el valor para cambiar el radio del borde
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                color: Colors.white,
                                size: 15,
                              ), // Cambia el color a blanco
                              Text(
                                'Pedido ${index + 1}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Colors.white, // Cambia el color a blanco
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.store_outlined,
                                color: unselectColor, size: 15),
                            Text(
                              'A floreria: ${shop.nombreFloreria}',
                              style: TextStyle(
                                fontSize: 15,
                                color: unselectColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      ExpansionTile(
                        title: Row(
                          children: [
                            Icon(Icons.shopping_bag_outlined, size: 15),
                            Text(
                              'Productos',
                              style:
                                  TextStyle(color: unselectColor, fontSize: 15),
                            ),
                          ],
                        ),
                        children: shopProducts
                            .map(
                              (product) => ListTile(
                                leading: Image.network(
                                    'https://floresfinas.oss-us-east-1.aliyuncs.com/mj-v1/arreglo-floral-m4067-1.webp'),
                                title: Text(
                                  'Producto: ${product.description}',
                                  style: TextStyle(color: unselectColor),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Precio: ${product.price.toStringAsFixed(2)}MXN',
                                      style: TextStyle(color: unselectColor),
                                    ),
                                    Text(
                                      'Cantidad: ${product.quantityToBuy}',
                                      style: TextStyle(color: unselectColor),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              Divider(
                color: baseColor,
                thickness: 2.0,
              ),
            ],
          );
        },
      ),
      bottomSheet: Container(
        color: baseColor,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize
                    .min, // Para que ocupe el espacio mínimo necesario
                children: [
                  Text(
                    'Cantidad: $totalQuantity',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Precio total: $totalAmount MXN',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            TextButton.icon(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              label: Text('Confirmar compra',
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                side: BorderSide(
                    color: Color.fromARGB(255, 255, 255, 255)), // Borde blanco
                // Relleno transparente
              ),
              onPressed: () async {
                if (userProvider.user.id == 0) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          LoginScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                  return;
                }
                // Crea un nuevo DetallePedido
                DetallePedido detallePedido = DetallePedido(
                  idDetalle: 0,
                  montoIngresado: 22.00,
                  cantidadPedidos: totalQuantity,
                  montoTotalAPagar: totalAmount,
                );
                int detallePedidoID;
                try {
                  detallePedidoID = await createDetallePedido(detallePedido);
                  print('DetallePedido creado con éxito. ID: $detallePedidoID');
                } catch (e) {
                  print(e);
                  return; // Si la creación del DetallePedido falla, no continúes
                }

                // Imprime el objeto DetallePedido
                print('DetallePedido: ${detallePedido.toJson()}');

                // Imprime el contenido de la lista cartListProvider
                cartListProvider.products.forEach((product) async {
                  print(
                      'Producto: ${product.description}, Precio: ${product.price}, Cantidad: ${product.quantityToBuy}');

                  // Crea un nuevo Pedido para cada producto
                  Pedido pedido = Pedido(
                    idPedido: 0,
                    idEstado: 1,
                    fechaHoraPedido: DateTime.now().toString(),
                    precioUnitario: product.price,
                    idDetallePedido:
                        detallePedidoID, // Usa el ID del DetallePedido que acabas de crear
                    idUsuario: userProvider
                        .user.id, // Reemplaza esto con el ID del usuario actual
                    idProducto: product.idProduct,
                    cantidadProducto: product.quantityToBuy,
                    precioTotal: product.price * product.quantityToBuy,
                    idTarjeta:
                        6, // Reemplaza esto con el ID de la tarjeta seleccionada
                    fechaEntrega: "2022-03-09",
                    horaEntrega: "14:00:00",
                    idInventario: product
                        .idInventario, // Asegúrate de que CartProvider tenga idInventario
                    pagoTotal:
                        totalAmount, // Asegúrate de que totalAmount esté definido
                  );
                  print(pedido.toString());

                  try {
                    int pedidoID = await createPedido(pedido);
                    print('Pedido creado con éxito. ID: $pedidoID');
                  } catch (e) {
                    print(e);
                  }
                });

                // Navega a la pantalla de formulario de pago
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentFormScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
