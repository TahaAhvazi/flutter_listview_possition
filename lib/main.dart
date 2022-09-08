import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagin_flutter/blocs/listviewpossitionBloc/listview_possition_bloc.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ListviewPossitionBloc(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        bool isAtTheTop = _scrollController.position.pixels == 0;
        if (isAtTheTop) {
          print("At the TOP");
          setState(() {
            isAtTheTop == true;
          });
          context
              .read<ListviewPossitionBloc>()
              .add(OnListViewPossitionDetectedEvent(isAtTheTop));
        } else {
          print("At the bottom");
          setState(() {
            isAtTheTop == false;
          });
          context
              .read<ListviewPossitionBloc>()
              .add(OnListViewPossitionDetectedEvent(isAtTheTop));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              onPressed: () => scrollDown(),
              child: const Icon(Icons.file_download),
            ),
            FloatingActionButton(
              onPressed: () => scrollUp(),
              child: const Icon(Icons.upgrade_rounded),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ListviewPossitionBloc, ListviewPossitionState>(
        builder: (context, state) {
          if (state is ListViewAtLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ListViewAtTopState) {
            return const Center(
              child: Text(
                "WE ARE AT THE TOP",
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (state is ListViewAtBottomState) {
            return const Center(
              child: Text(
                "WE ARE AT THE BOTTOM",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 72, 6),
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (state is ListviewPossitionInitial) {
            return Column(
              children: [
                SizedBox(
                  height: 800,
                  width: double.infinity,
                  child: Scrollbar(
                    thickness: 10.0,
                    trackVisibility: true,
                    child: ListView.builder(
                      itemCount: 50,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 100,
                              width: double.infinity,
                              child:
                                  Center(child: Text("${index + 1} Container")),
                            ),
                            const Divider(
                              thickness: 5,
                              color: Colors.brown,
                            )
                          ],
                        );
                      },
                      controller: _scrollController,
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text('Data'),
          );
        },
      ),
    );
  }

  void scrollDown() {
    final double end = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(end,
        duration: const Duration(seconds: 2), curve: Curves.bounceOut);
    // _scrollController.jumpTo(end);
  }

  void scrollUp() {
    final double start = _scrollController.position.minScrollExtent;
    _scrollController.animateTo(start,
        duration: const Duration(seconds: 1), curve: Curves.easeInCirc);
    // _scrollController.jumpTo(end);
  }
}
