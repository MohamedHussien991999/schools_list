import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schools_list/constants/constants.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_state.dart';
import 'package:schools_list/model/school_model.dart';

class SchoolsCubit extends Cubit<SchoolsStates> {
  SchoolsCubit() : super(AppInitialState());

  static SchoolsCubit get(context) => BlocProvider.of(context);

  Color color1 = Colors.green;
  Color color2 = Colors.grey;

  final dio = Dio();
  List<SchoolModel> schools = [];

  List<SchoolModel> searchSchools = [];
  String? searchType ;

  List<SchoolModel> favoriteSchools = [];

  List<SchoolModel> filterSchools = [];
  String? filterChoice;
  List<DropdownMenuItem<String>>? filterChoiceList;
  int offset = 0;
  int itemsPerPage = 5;
  String sortType = '';

  void changeColor1(String colorName) {
    if (colorName == 'color1') {
      color1 = Colors.green;
      color2 = Colors.grey;
    } else {
      color1 = Colors.grey;
      color2 = Colors.green;
    }

    emit(AppChangeColorState());
  }

  Future<void> getSchoolList() async {
    try {
      schools.clear();
      emit(LoadingGetSchoolsState());

      Response response;
      log('------------- \n');
      response = await dio.get(
        getSchoolsApi,
        queryParameters: {'offset': offset, 'itemsPerPage': itemsPerPage},
      );

      for (var item in response.data) {
        SchoolModel school = SchoolModel.fromJson(item);
        log('first response.data: ${school.id}');
        schools.add(school);
      }
      log('schools length: ${schools.length}');
      emit(SuccessGetSchoolsState());
    } catch (e) {
      emit(ErrorGetSchoolsState(error: e.toString()));
    }
  }

  void getListSearchSchools(
      {required String searchText, required String searchType}) {
    try {
      searchSchools.clear();
      emit(LoadingGetSchoolsSearchState());
      for (var item in schools) {
        switch (searchType) {
          case 'name':
            {
              if (item.name.toLowerCase().contains(searchText.toLowerCase())) {
                searchSchools.add(item);
              }
            }
            break;
          case 'type':
            {
              if (item.type.toLowerCase().contains(searchText.toLowerCase())) {
                searchSchools.add(item);
              }
              break;
            }
          case 'level':
            {
              if (item.level.toLowerCase().contains(searchText.toLowerCase())) {
                searchSchools.add(item);
              }
              break;
            }
          case 'language':
            {
              if (item.language
                  .toLowerCase()
                  .contains(searchText.toLowerCase())) {
                searchSchools.add(item);
              }
              break;
            }
          case 'street':
            {
              if (item.street
                  .toLowerCase()
                  .contains(searchText.toLowerCase())) {
                searchSchools.add(item);
              }
              break;
            }
        }
      }
      emit(SuccessGetSchoolsSearchState());
    } catch (e) {
      emit(ErrorGetSchoolsSearchState(error: e.toString()));
    }
  }

  void changeFavorite(SchoolModel schoolModel) {
    schoolModel.isFavorite = !schoolModel.isFavorite;
    if (schoolModel.isFavorite) {
      favoriteSchools.add(schoolModel);
    } else {
      favoriteSchools.remove(schoolModel);
    }
    emit(ChangeFavoriteState());
  }

  Future<void> loadMoreSchools({BuildContext? context}) async {
    emit(LoadingLoadMoreSchoolsState());
    int i = schools.length;
    offset += 5;
    log('offset: $offset');
    Response response = await dio.get(
      getSchoolsApi,
      queryParameters: {'offset': offset, 'itemsPerPage': itemsPerPage},
    );

    for (var item in response.data) {
      SchoolModel school = SchoolModel.fromJson(item);
      schools.add(school);
    }
    if (schools.length == i) {
     if (context != null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(
            child: Text(
              'You Have Fetched All Schools',
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.amber,
        ),
      );
      }
    }
    sortSchools();

    emit(SuccessLoadMoreSchoolsState());
  }

  void sortSchools() {
    sortType == 'Ascendingly'
        ? schools.sort((a, b) => a.name.compareTo(b.name))
        : schools.sort((a, b) => b.name.compareTo(a.name));
    emit(SuccessSortSchoolsState());
  }

  Future<void> changeFilterType(String filterChoice) async {
    List<String> filter = [];

    switch (filterChoice) {
      case 'type':
        {
          for (var item in schools) {
            if (!filter.contains(item.type)) {
              filter.add(item.type);
            }
          }
        }
        break;
      case 'level':
        {
          for (var item in schools) {
            if (!filter.contains(item.level)) {
              filter.add(item.level);
            }
          }
        }
        break;
      case 'language':
        {
          for (var item in schools) {
            if (!filter.contains(item.language)) {
              filter.add(item.language);
            }
          }
        }
        break;
    }
    filterChoiceList = [];
    for (var item in filter) {
      filterChoiceList!.add(DropdownMenuItem(
        value: item,
        child: Text(item),
      ));
    }

    emit(ChangeFilterTypeState());
  }

  void getListFilterSchools(
      {required String filterOption, required String filterType}) {
    filterSchools.clear();
    emit(LoadingGetSchoolsFilterState());
    for (var item in schools) {
      switch (filterType) {
        case 'type':
          {
            if (item.type.toLowerCase().contains(filterOption.toLowerCase())) {
              filterSchools.add(item);
            }
            break;
          }
        case 'level':
          {
            if (item.level.toLowerCase().contains(filterOption.toLowerCase())) {
              filterSchools.add(item);
            }
            break;
          }
        case 'language':
          {
            if (item.language
                .toLowerCase()
                .contains(filterOption.toLowerCase())) {
              filterSchools.add(item);
            }
            break;
          }
      }
    }
    emit(SuccessGetSchoolsFilterState());
  }
}
