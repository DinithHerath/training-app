import 'package:fcode_common/fcode_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:training_app/views/home_page/home_event.dart';
import 'package:training_app/views/home_page/widgets/diary_card.dart';
import 'home_bloc.dart';
import 'home_state.dart';
import 'widgets/background.dart';
import 'widgets/diary_form.dart';

class HomeView extends StatelessWidget {
  static final log = Log("homeView");
  static final loadingWidget = Center(
    child: SpinKitFadingCircle(
      color: Colors.white,
      size: 50.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    HomeView.log.d("Loading home View");

    CustomSnackBar customSnackBar;
    final scaffold = Scaffold(
      body: GestureDetector(
        onTap: () {
          homeBloc.add(HideInputEvent());
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Background(),
            Column(
              children: [
                SizedBox(
                  height: 64,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 18, right: 18, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  child: DiaryForm(),
                ),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) => !identical(previous.diaries, current.diaries),
                    builder: (context, state) {
                      if (state.diaries == null) {
                        return HomeView.loadingWidget;
                      }
                      state.diaries.sort((a,b) => b.created.compareTo(a.created));
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        physics: BouncingScrollPhysics(),
                        itemCount: state.diaries.length,
                        itemBuilder: (context, index) => DiaryCard(
                          title: state.diaries[index].title,
                          subtitle: state.diaries[index].user,
                          description: state.diaries[index].description,
                          created: state.diaries[index].created.toDate(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (pre, current) => pre.error != current.error,
          listener: (context, state) {
            if (state.error?.isNotEmpty ?? false) {
              customSnackBar?.showErrorSnackBar(state.error);
            } else {
              customSnackBar?.hideAll();
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
