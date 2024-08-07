// part of 'favourite_cubit.dart';

// @immutable
// abstract class FavouriteState {}

// final class FavouriteInitial extends FavouriteState {}

// final class FavouriteLoaded extends FavouriteState {
//   final List<CardItemModel> favouritelist;
//   FavouriteLoaded(this.favouritelist);
// }

// final class FavouriteFailure extends FavouriteState {
//   final String errormessage;
//   FavouriteFailure(this.errormessage);
// }
part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<CardItemModel> favouritelist;

  FavouriteLoaded(this.favouritelist);
}

class FavouriteFailure extends FavouriteState {
  final String errormessage;

  FavouriteFailure(this.errormessage);
}

class FavouriteUpdated extends FavouriteState {}
