import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_cubit.dart';
import 'package:schools_list/cubit/app_cubit/app_cubit_state.dart';
import 'package:schools_list/widgets/home/body_home_page.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late ScrollController _scrollController ;

  @override
  void initState() {
    super.initState();
    _scrollController= ScrollController()..addListener(_scrollListener);
  }

  void _scrollListener() async {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent  && !_scrollController.position.outOfRange) {
      await SchoolsCubit.get(context).loadMoreSchools(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (SchoolsCubit.get(context).schools.isEmpty) {
      SchoolsCubit.get(context).getSchoolList();
    }

    return BlocConsumer<SchoolsCubit, SchoolsStates>(
      listener: (context, state) {
        if (state is SuccessGetSchoolsState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Success Get Schools',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.greenAccent,
            ),
          );
        } else if (state is ErrorGetSchoolsState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error  \n ${state.error}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingGetSchoolsState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorGetSchoolsState) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return BodyHomePage(scrollController: _scrollController);
        }
      },
    );
  }
}
