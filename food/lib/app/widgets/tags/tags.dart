import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food/app/bloc/bloc_event.dart';
import 'package:food/app/utils/constants.dart';

import '../../bloc/bloc.dart';
import '../../bloc/bloc_state.dart';

class TagsWidget extends StatelessWidget {
  const TagsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, BlocState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<AppBloc>(context);
          return Container(
            height: 43,
            color: AppColors().white,
            padding: const EdgeInsets.only(bottom: 8, left: 16),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      bloc.add(TagsChangeEvent(index: index));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: state.tags[index]['isActive'] ? AppColors().blue : AppColors().light,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        state.tags[index]['name'],
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: '.SF UI Display',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            color: state.tags[index]['isActive'] ? AppColors().white : AppColors().black
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
        }
    );
  }
}