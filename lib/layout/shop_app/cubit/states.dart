abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewsBottomNavState extends NewsStates {}

class newsGetBusinessLoadingState extends NewsStates {}

class newsGetBusinessSuccessState extends NewsStates {}

class newsGetBusinessErrorState extends NewsStates {
  final String error;
  newsGetBusinessErrorState(this.error);
}

class newsGetSportLoadingState extends NewsStates {}

class newsGetSportSuccessState extends NewsStates {}

class newsGetSportErrorState extends NewsStates {
  final String error;
  newsGetSportErrorState(this.error);
}

class newsGetScienceLoadingState extends NewsStates {}

class newsGetScienceSuccessState extends NewsStates {}

class newsGetScienceErrorState extends NewsStates {
  final String error;
  newsGetScienceErrorState(this.error);
}

class newsChangeModeState extends NewsStates {}

class newsGetSearchLoadingState extends NewsStates {}

class newsGetSearchSuccessState extends NewsStates {}

class newsGetSearchErrorState extends NewsStates {
  final String error;
  newsGetSearchErrorState(this.error);
}
