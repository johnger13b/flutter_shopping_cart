import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/product.dart';
import '../widgets/banner.dart';
import '../controllers/shopping_controller.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ShoppingController shoppingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [const CustomBanner(50), customAppBar()],
            ),
            // DONE
            // aquí debemos rodear el widget Expanded en un Obx para
            // observar los cambios en la lista de entries del shoppingController
            Obx(
              () => Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: shoppingController.entries.length,
                    itemBuilder: (context, index) {
                      return _row(shoppingController.entries[index], index);
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.arrow_back,
              color: Color(0xff9c0730),
              size: 40,
            ),
          ),
        )
      ],
    );
  }

  Widget _row(Product product, int index) {
    return _card(product);
  }

  Widget _card(Product product) {
    return Card(
      margin: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            product.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text('US\$ ${product.price.toString()}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900])),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    // DONE
                    // aquí debemos llamar al método del controlador que
                    // incrementa el número de unidades del producto
                    // pasandole el product.id
                    shoppingController.agregarProducto(product.id);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.arrow_upward,
                    size: 25,
                    color: Color(0xff9c0730),
                  )),
              IconButton(
                  onPressed: () {
                    // DONE
                    // aquí debemos llamar al método del controlador que
                    // disminuye el número de unidades del producto
                    // pasandole el product.id
                    shoppingController.quitarProducto(product.id);
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.arrow_downward,
                    size: 25,
                    color: Color(0xff9c0730),
                  ))
            ],
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Quantity:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(product.quantity.toString(),
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900])),
              ),
            ],
          )
        ],
      ),
    );
  }
}
