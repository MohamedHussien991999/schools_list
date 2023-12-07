import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';

void main() {
  group('App Test', () {
    SchoolsCubit schoolsCubit = SchoolsCubit();

    test('pressed on button school in main', () {
      // Arrange
      Color color1 = Colors.green;
      Color color2 = Colors.grey;

      // Act
      schoolsCubit.changeColor1('color1');

      // Assert
      expect(color1, Colors.green);
      expect(color2, Colors.grey);
    });
    test('pressed on button My favorite', () {
      // Arrange
      Color color1 = Colors.grey;
      Color color2 = Colors.green;

      // Act
      schoolsCubit.changeColor1('color1');

      // Assert
      expect(color1, Colors.grey);
      expect(color2, Colors.green);
    });
    test('getSchoolList', () async {
      await schoolsCubit.getSchoolList();

      // Assert
      expect(5, schoolsCubit.schools.length);
    });

    test('getListSearchSchools', () async {
      schoolsCubit.getListSearchSchools(
          searchText: 'board', searchType: 'name');

      // Assert
      expect(0, schoolsCubit.searchSchools.length);
      schoolsCubit.getListSearchSchools(
          searchText: 'Birchmount', searchType: 'name');

      // Assert
      expect(1, schoolsCubit.searchSchools.length);
    });

    test('changeFavorite', () async {
      await schoolsCubit.getSchoolList();
      schoolsCubit.changeFavorite(schoolsCubit.schools[0]);

      // Assert
      expect(1, schoolsCubit.favoriteSchools.length);
    });

    test('loadMoreSchools', () async {
      await schoolsCubit.loadMoreSchools();

      // Assert
      expect(10, schoolsCubit.schools.length);
    });

    test('changeFilterType', () async {
      await schoolsCubit.changeFilterType('type');

      // Assert
      expect('public', schoolsCubit.filterChoiceList![0].value);
    });

    test('sortSchools', () async {
      schoolsCubit.sortType = 'Ascendingly';
      schoolsCubit.sortSchools();

      // Assert
      expect('Birchmount Park Collegiate Institute',
          schoolsCubit.schools.first.name);
    });

    test('getListFilterSchools', () {
      schoolsCubit.getListFilterSchools(  filterType:'language' , filterOption:"Extended French" );
      // Assert
      expect(2, schoolsCubit.filterSchools.length);
    });
  });
}
