import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_app/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/presentation/Home/widget/custom_button_wiget.dart';
import 'package:netflix_app/presentation/Widgets/app_bar_widget.dart';
import 'package:netflix_app/presentation/Widgets/video_widget.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/comming_soon_widget.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/everyones_watching_widget.dart';

import '../../core/constants.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            title: const Text(
              "New & Hot",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
            actions: [
              const Icon(
                Icons.cast,
                size: 25,
                color: Colors.white,
              ),
              kwidth,
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 6, right: 5),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          // fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://mir-s3-cdn-cf.behance.net/project_modules/disp/1bdc9a33850498.56ba69ac2ba5b.png"))),
                ),
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              labelColor: kBlackColor,
              unselectedLabelColor: kWhiteColor,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              indicator:
                  BoxDecoration(color: kWhiteColor, borderRadius: kRadius30),
              tabs: const [
                Tab(
                  text: '🍿 Comming Soon',
                ),
                Tab(
                  text: "👀 Everyone's Watching",
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(children: [
          CommingSoonList(key: Key('commingSoon')),
          EveryOneIsWatchingList(
            key: Key('EveryOne is watching'),
          ),
        ]),
      ),
    );
  }
}

class CommingSoonList extends StatelessWidget {
  const CommingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInCommingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInCommingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading commingSoon list'),
            );
          } else if (state.commmingSoonList.isEmpty) {
            return const Center(
              child: Text('CommingSoon list is Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: state.commmingSoonList.length,
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (BuildContext context, index) {
                final movie = state.commmingSoonList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }
                print(movie.releaseDate);
                String month = '';
                String date = '';
                try {
                  final _date = DateTime.tryParse(movie.releaseDate!);
                  final formattedDate =
                      DateFormat.yMMMMd('en_US').format(_date!);
                  print(formattedDate);

                  month = formattedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase();
                  date = movie.releaseDate!.split('-')[1];
                } catch (_) {
                  month = '';
                  date = '';
                }

                return CommingSoonWidget(
                  id: movie.id.toString(),
                  month: month,
                  day: date,
                  posterPath: '$imageAppendUrl${movie.posterPath}',
                  movieName: movie.originalTitle ?? 'No Title',
                  description: movie.overview ?? 'No Description',
                );
              },
            );
          }
        },
      ),
    );
  }
}

class EveryOneIsWatchingList extends StatelessWidget {
  const EveryOneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryOneIsWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text('Error while loading commingSoon list'),
            );
          } else if (state.everyOneIsWatchingList.isEmpty) {
            return const Center(
              child: Text('CommingSoon list is Empty'),
            );
          } else {
            return ListView.builder(
              itemCount: state.everyOneIsWatchingList.length,
              padding: const EdgeInsets.all(15),
              itemBuilder: (BuildContext context, index) {
                final movie = state.everyOneIsWatchingList[index];
                if (movie.id == null) {
                  return const SizedBox();
                }

                final tv = state.everyOneIsWatchingList[index];
                return EveryonsesWatchingWidget(
                    posterPath: '$imageAppendUrl${tv.posterPath}',
                    movieName: tv.originalName ?? 'No name Provided',
                    description: tv.overview ?? 'No Description');
              },
            );
          }
        },
      ),
    );
  }
}
