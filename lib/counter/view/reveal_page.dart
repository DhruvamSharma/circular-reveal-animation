import 'package:flutter/material.dart';
import 'package:widget_highlighter/core/global_key_registry.dart';
import 'package:widget_highlighter/core/glowing_container.dart';
import 'package:widget_highlighter/core/highlighter.dart';
import 'package:widget_highlighter/core/reveal_animation.dart';



class RevealPage extends StatelessWidget {
  const RevealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              // ignore: use_colored_box
              background: HighlighterController(
                id: revealHeaderKey,
                child: ColoredBox(
                  color: const Color(0xFFEEEEEE),
                  child: Image.network(
                    'https://img.freepik.com/premium-vector/full-moon-night-with-mountain-view-vector-illustration_8855-1029.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Activity section
                ...List.generate(5, (index) => HighlighterController(
                  id: 'revealThirdLoaderKey$index',
                  revealAnimationType: RevealAnimationType.rectangular,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RandomGlowingContainer(
                      seedId: 'revealThirdLoaderKey$index',
                      child: Container(
                        height: 140,
                      ),
                    ),
                  ),
                )),
              ]),
            ),
          ),
          // SliverPadding(
          //   padding: const EdgeInsets.all(20),
          //   sliver: SliverGrid(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       mainAxisSpacing: 16,
          //       crossAxisSpacing: 16,
          //     ),
          //     delegate: SliverChildBuilderDelegate(
          //       (context, index) {
          //         final id = 'reveal_item_$index';
          //         // generate a random number from seed
          //         return HighlighterController(
          //           id: id,
          //           revealAnimationType: RevealAnimationType.rectangular,
          //           child: RandomGlowingContainer(
          //             seedId: id,
          //             child: const SizedBox(),
          //           ),
          //         );
          //       },
          //       childCount: 20,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}