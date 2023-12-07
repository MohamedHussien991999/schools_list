abstract class SchoolsStates {}

class AppInitialState extends SchoolsStates {}

class AppChangeColorState extends SchoolsStates {}

class LoadingGetSchoolsState extends SchoolsStates {}

class SuccessGetSchoolsState extends SchoolsStates {}

class ErrorGetSchoolsState extends SchoolsStates {
  final String error;

  ErrorGetSchoolsState({required this.error});
}

class LoadingGetSchoolsSearchState extends SchoolsStates {}

class SuccessGetSchoolsSearchState extends SchoolsStates {}

class ErrorGetSchoolsSearchState extends SchoolsStates {
  final String error;

  ErrorGetSchoolsSearchState({required this.error});
}

class ChangeFavoriteState extends SchoolsStates {}

class LoadingLoadMoreSchoolsState extends SchoolsStates {}

class SuccessLoadMoreSchoolsState extends SchoolsStates {}


class SuccessSortSchoolsState extends SchoolsStates {}

class ChangeFilterTypeState extends SchoolsStates {}



class LoadingGetSchoolsFilterState extends SchoolsStates {}

class SuccessGetSchoolsFilterState extends SchoolsStates {}