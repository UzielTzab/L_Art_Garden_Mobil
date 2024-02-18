import 'package:flutter/material.dart';
import '../Main_Store/Custom_Scroll_View.dart';

class FlowerMain extends StatefulWidget {
  const FlowerMain({super.key});

  @override
  State<FlowerMain> createState() => _FlowerMainState();
}

class _FlowerMainState extends State<FlowerMain> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0),
      child: Center(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Center(
                child: Text(
                  '¿Qué estas buscando?',
                  style: TextStyle(
                      color: Color.fromARGB(255, 87, 87, 87),
                      fontFamily: 'flower sun'),
                ),
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(50.0),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
            body: const TabBarView(
              children: [
                CustomScrollViewClass(),
                Placeholder(),
                Placeholder(),
                Placeholder()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
