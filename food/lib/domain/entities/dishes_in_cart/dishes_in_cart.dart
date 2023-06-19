import '../dishes/dishes.dart';

class DishesInCart {
  final List<Dish> dishes;
  final List<int> count;

  DishesInCart(this.dishes, this.count);
}