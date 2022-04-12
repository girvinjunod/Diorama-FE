import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeNavigatorState {
  home,
  profile,
  // comments,
}

class HomeCubit extends Cubit<HomeNavigatorState> {
  HomeCubit() : super(HomeNavigatorState.home);

  void showProfile() => emit(HomeNavigatorState.profile);
  // void showComments() => emit(HomeNavigatorState.comments);
  void showHome() => emit(HomeNavigatorState.home);
}

class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeNavigatorState>(
            builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: (TripFeed())),
              if (state == HomeNavigatorState.profile)
                MaterialPage(child: (ProfilePage())),
              // if (state == HomeNavigatortate.comments)
              //   MaterialPage(child: (CommentPage())),
            ],
            onPopPage: (route, result) {
              context.read<HomeCubit>().showHome();
              return route.didPop(result);
            },
          );
        }));
  }
}
