import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritesView extends GetView {
  const FavouritesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Favourites View is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}