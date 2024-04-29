import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Models/pedido.dart';
import 'package:l_art_garden_mobil/Services/service_pedido.dart';
import 'package:l_art_garden_mobil/model_provider/users_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
// Importa tu modelo Pedido aquí

class BoughtProductsScreen extends StatefulWidget {
  @override
  _BoughtProductsScreenState createState() => _BoughtProductsScreenState();
}

class _BoughtProductsScreenState extends State<BoughtProductsScreen> {
  late Future<List<Pedido>> futurePedidos;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Asegúrate de que tu UserProvider está registrado en algún lugar más arriba en el árbol de widgets
    final userProvider = Provider.of<UserProvider>(context);
    futurePedidos = getPedidosByUserId(userProvider.user.id);
  }

  static const Color baseColor = Color.fromARGB(255, 242, 173, 83);
  static const Color baseColorDark = Color.fromARGB(255, 163, 114, 49);
  static const Color unselectColor = Color.fromARGB(255, 107, 77, 12);
  static const Color disableColor = Color.fromARGB(255, 193, 193, 193);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tus compras',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: baseColor,
      ),
      body: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              backgroundColor: Colors.white,
              bottom: TabBar(
                unselectedLabelColor: unselectColor,
                indicatorColor: baseColor,
                labelColor: baseColor,
                tabs: [
                  Tab(text: 'Pendientes'),
                  Tab(text: 'En camino'),
                  Tab(text: 'Entregados'),
                  Tab(text: 'Rechazado'),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: [
              buildTabContentAwait(),
              buildTabContentOnTheWay(),
              buildTabContentReceived(),
              buildTabContentRefused(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabContentReceived() {
    return FutureBuilder<List<Pedido>>(
      future: futurePedidos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Filtra los pedidos con IdEstado igual a 3
          List<Pedido> filteredPedidos =
              snapshot.data!.where((pedido) => pedido.idEstado == 3).toList();

          return ListView.builder(
            itemCount: filteredPedidos.length,
            itemBuilder: (context, index) {
              // Parsea y formatea la fecha
              DateTime parsedDate =
                  DateTime.parse(filteredPedidos[index].fechaHoraPedido);
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(parsedDate);

              return Card(
                child: ExpansionTile(
                  leading: Icon(Icons.check_box, color: Colors.green),
                  title: Text('Pedido|Realizado el: $formattedDate'),
                  children: [
                    ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                            '${filteredPedidos[index].imagenReferencia}'),
                      ),
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                filteredPedidos[index].nombreProducto,
                                style: TextStyle(
                                    fontSize: 15, color: baseColorDark),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Cantidad: ${filteredPedidos[index].cantidadSeleccionado}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        // Aquí puedes manejar el evento de tap en el ListTile
                        // Por ejemplo, podrías navegar a una nueva pantalla que muestre detalles del producto
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // Por defecto, muestra un spinner de carga.
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildTabContentOnTheWay() {
    return FutureBuilder<List<Pedido>>(
      future: futurePedidos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Filtra los pedidos con IdEstado igual a 2
          List<Pedido> filteredPedidos =
              snapshot.data!.where((pedido) => pedido.idEstado == 2).toList();

          return ListView.builder(
            itemCount: filteredPedidos.length,
            itemBuilder: (context, index) {
              // Parsea y formatea la fecha
              DateTime parsedDate =
                  DateTime.parse(filteredPedidos[index].fechaHoraPedido);
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(parsedDate);

              return Card(
                child: ExpansionTile(
                  leading: Icon(Icons.delivery_dining,
                      color: Color.fromARGB(255, 243, 112, 47)),
                  title: Text('Pedido|Realizado el: $formattedDate'),
                  children: [
                    ListTile(
                      leading: Image.network(
                          '${filteredPedidos[index].imagenReferencia}'),
                      title: Row(
                        children: [
                          Text(
                            filteredPedidos[index].nombreProducto,
                            style:
                                TextStyle(fontSize: 15, color: baseColorDark),
                          ),
                          Text(
                              'Cantidad: ${filteredPedidos[index].cantidadSeleccionado}'),
                        ],
                      ),
                      onTap: () {
                        // Aquí puedes manejar el evento de tap en el ListTile
                        // Por ejemplo, podrías navegar a una nueva pantalla que muestre detalles del producto
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // Por defecto, muestra un spinner de carga.
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildTabContentRefused() {
    return FutureBuilder<List<Pedido>>(
      future: futurePedidos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Filtra los pedidos con IdEstado igual a 6
          List<Pedido> filteredPedidos =
              snapshot.data!.where((pedido) => pedido.idEstado == 6).toList();

          return ListView.builder(
            itemCount: filteredPedidos.length,
            itemBuilder: (context, index) {
              // Parsea y formatea la fecha
              DateTime parsedDate =
                  DateTime.parse(filteredPedidos[index].fechaHoraPedido);
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(parsedDate);

              return Card(
                child: ExpansionTile(
                  leading: Icon(Icons.cancel_outlined,
                      color: Color.fromARGB(255, 229, 64, 64)),
                  title: Text('Pedido|Realizado el: $formattedDate'),
                  children: [
                    ListTile(
                      leading: Image.network(
                          '${filteredPedidos[index].imagenReferencia}'),
                      title: Row(
                        children: [
                          Text(
                            filteredPedidos[index].nombreProducto,
                            style:
                                TextStyle(fontSize: 15, color: baseColorDark),
                          ),
                          Text(
                              'Cantidad: ${filteredPedidos[index].cantidadSeleccionado}'),
                        ],
                      ),
                      onTap: () {
                        // Aquí puedes manejar el evento de tap en el ListTile
                        // Por ejemplo, podrías navegar a una nueva pantalla que muestre detalles del producto
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // Por defecto, muestra un spinner de carga.
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildTabContentAwait() {
    return FutureBuilder<List<Pedido>>(
      future: futurePedidos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Filtra los pedidos con IdEstado igual a 6
          List<Pedido> filteredPedidos =
              snapshot.data!.where((pedido) => pedido.idEstado == 1).toList();

          return ListView.builder(
            itemCount: filteredPedidos.length,
            itemBuilder: (context, index) {
              // Parsea y formatea la fecha
              DateTime parsedDate =
                  DateTime.parse(filteredPedidos[index].fechaHoraPedido);
              String formattedDate =
                  DateFormat('yyyy-MM-dd – kk:mm').format(parsedDate);

              return Card(
                child: ExpansionTile(
                  leading: Icon(Icons.cancel_outlined,
                      color: Color.fromARGB(255, 229, 64, 64)),
                  title: Text('Pedido|Realizado el: $formattedDate'),
                  children: [
                    ListTile(
                      leading: Image.network(
                          '${filteredPedidos[index].imagenReferencia}'),
                      title: Row(
                        children: [
                          Text(
                            filteredPedidos[index].nombreProducto,
                            style:
                                TextStyle(fontSize: 15, color: baseColorDark),
                          ),
                          Text(
                              'Cantidad: ${filteredPedidos[index].cantidadSeleccionado}'),
                        ],
                      ),
                      onTap: () {
                        // Aquí puedes manejar el evento de tap en el ListTile
                        // Por ejemplo, podrías navegar a una nueva pantalla que muestre detalles del producto
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // Por defecto, muestra un spinner de carga.
        return Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
