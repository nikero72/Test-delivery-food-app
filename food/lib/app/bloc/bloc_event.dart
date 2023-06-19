abstract class BlocEvent {}

class TagsChangeEvent extends BlocEvent {
  final int index;

  TagsChangeEvent({required this.index});
}

class InitializeCategories extends BlocEvent {}

class InitializeDishes extends BlocEvent {}

class PageChangeEvent extends BlocEvent {
  final int index;

  PageChangeEvent({required this.index});
}

class AddToCartEvent extends BlocEvent {
  final int index;

  AddToCartEvent(this.index);
}

class MinusByCartEvent extends BlocEvent {
  final int index;

  MinusByCartEvent(this.index);
}

class PlusByCartEvent extends BlocEvent {
  final int index;

  PlusByCartEvent(this.index);
}
