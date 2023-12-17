import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sausage_roll_app/models/cart.dart';
import 'package:sausage_roll_app/models/food.dart';
import 'package:sausage_roll_app/models/mode.dart';
import 'package:sausage_roll_app/services/food_api_service.dart';

class ProductInfoView extends StatefulWidget {
  const ProductInfoView({super.key});

  @override
  State<ProductInfoView> createState() => _ProductInfoViewState();
}

class _ProductInfoViewState extends State<ProductInfoView> {
  bool isIcon1Visible = true;
  // int mode = 0;

  void _toggleIcon() {
    setState(() {
      isIcon1Visible = !isIcon1Visible;
      // mode = isIcon1Visible ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    Cart? cart = Provider.of<Cart>(context, listen: true);
    Mode? mode = Provider.of<Mode>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Menu',
            style: GoogleFonts.inter(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder<List<Food>?>(
          future: FoodService.getFoods(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Food> foods = snapshot.data!;
              return ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10.0),
                                            child: Text(
                                              foods[index].name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(10.0),
                                          subtitle: Text(
                                            foods[index].description,
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 80),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color.fromARGB(
                                                  255, 217, 225, 218),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                    onTap: () =>
                                                        cart.removeFood(
                                                            foods[index]),
                                                    child: const Icon(
                                                        size: 30,
                                                        Icons.remove)),
                                                Text(
                                                  '${cart.foods.where((el) => el.name == foods[index].name).length}',
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      mode.eatingMode =
                                                          isIcon1Visible
                                                              ? 0
                                                              : 1;
                                                      cart.setEatingMode(
                                                          mode.eatingMode);
                                                      cart.addFood(
                                                          foods[index]);
                                                    },
                                                    child: const Icon(
                                                        size: 30, Icons.add)),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Text('choose'),
                                      GestureDetector(
                                        onTap: _toggleIcon,
                                        child: isIcon1Visible
                                            ? const Icon(
                                                Icons.takeout_dining_outlined)
                                            : const Icon(Icons.dining_outlined),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Image.network(
                                          foods[index].image,
                                          width: 80.0,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        isIcon1Visible
                                            ? '£ ${foods[index].eatInPrice}'
                                            : '£ ${foods[index].eatOutPrice}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text('Times'),
                                      const Text('Available:'),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${foods[index].availableTimes[0]}',
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${foods[index].availableTimes[1]}',
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                      // Card(
                                      //   foods[index].availableTimes,
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
