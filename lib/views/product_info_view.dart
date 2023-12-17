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
  @override
  Widget build(BuildContext context) {
    Cart? cart = Provider.of<Cart>(context, listen: true);

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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Please tap',
                                        style: TextStyle(
                                            color: Colors.redAccent.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'to select',
                                        style: TextStyle(
                                            color: Colors.redAccent.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'eating mode',
                                        style: TextStyle(
                                            color: Colors.redAccent.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        cart.mode == Mode.eatIn
                                            ? "Eat In"
                                            : "Eat Out",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: GestureDetector(
                                          onTap: () => cart.toggleEatingMode(),
                                          child: cart.mode == Mode.eatOut
                                              ? const Icon(
                                                  Icons.takeout_dining_outlined,
                                                  size: 50)
                                              : const Icon(
                                                  Icons.dining_outlined,
                                                  size: 50),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 50),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                foods[index].image,
                                                width: 90.0,
                                                height: 90.0,
                                                fit: BoxFit.cover,
                                              ),
                                              Text(
                                                cart.mode == Mode.eatIn
                                                    ? '£ ${foods[index].eatInPrice}'
                                                    : '£ ${foods[index].eatOutPrice}',
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 50),
                                              const Text('Times',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              const Text('Available:',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${foods[index].availableTimes[0]}',
                                                style: TextStyle(
                                                    color:
                                                        Colors.orange.shade600,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '${foods[index].availableTimes[1]}',
                                                style: TextStyle(
                                                    color:
                                                        Colors.orange.shade600,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
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
