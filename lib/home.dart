import 'package:flutter/material.dart';
import 'package:planthydrator/screens/search.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarTheme.backgroundColor,
        elevation: appBarTheme.elevation,
        toolbarHeight: appBarTheme.toolbarHeight,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          ),
        ),
        title: Text(
          'Plant Hydrator',
          style: textTheme.displayMedium,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                showSearch(context: context, delegate: SearchPlantsDelegate());
              },
            ),
          ),
        ],
      ),
      body: const BodySection(),
    );
  }
}

class BodySection extends StatefulWidget {
  const BodySection({super.key});

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 100,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  "Water today",
                  style: (Theme.of(context).textTheme.displayMedium)!.copyWith(
                    fontSize: 24,
                  ),
                ),
              )
            ],
          ),
        ),
        // GridView.builder(
        //   itemBuilder: ,
        //   scrollDirection: Axis.horizontal,
        // ),
      ],
    );
  }
}
