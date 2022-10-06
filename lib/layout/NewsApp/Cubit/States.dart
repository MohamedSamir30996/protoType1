abstract class NewsStates {}



class NewsInitialState extends NewsStates{}

class NewsBottomNavBar extends NewsStates{}

class NewsChangeBottomNavState extends NewsStates{}

class NewsGetBusinessLoading extends NewsStates{}

class NewsGetBusinessSuccess extends NewsStates{}

class NewsGetBusinessError extends NewsStates{
  final String error;

  NewsGetBusinessError(this.error);
}

class NewsGetSportsLoading extends NewsStates{}

class NewsGetSportsSuccess extends NewsStates{}

class NewsGetSportsError extends NewsStates{
  final String error;
  NewsGetSportsError(this.error);
}

class NewsGetScienceLoading extends NewsStates{}

class NewsGetScienceSuccess extends NewsStates{}

class NewsGetScienceError extends NewsStates{
  final String error;
  NewsGetScienceError(this.error);
}

class NewsSearchLoading extends NewsStates{}

class NewsSearchSuccess extends NewsStates{}

class NewsSearchError extends NewsStates{
  final String error;
  NewsSearchError(this.error);
}