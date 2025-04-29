import 'package:flutter/material.dart';
import 'package:widget_highlighter/core/circular_reveal_page_route.dart';
import 'package:widget_highlighter/core/global_key_registry.dart';
import 'package:widget_highlighter/core/glowing_container.dart';
import 'package:widget_highlighter/core/highlighter.dart';
import 'package:widget_highlighter/core/overlay_manager.dart';
import 'package:widget_highlighter/counter/view/reveal_page.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen();
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: HighlighterController(
        id: fabKey,
        child: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Floating Action Button Pressed'),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar to display the big placeholder at the top
          SliverAppBar(
            expandedHeight: 250, // Height for the placeholder widget
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: HighlighterController(
                id: headerKey,
                child: Container(
                  color: Colors.grey[300], // Placeholder color
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    'https://i0.wp.com/picjumbo.com/wp-content/uploads/digital-art-dark-natural-scenery-with-a-large-sun-and-another-planet-free-image.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          // SliverList to show a list of placeholder tiles
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final id = 'placeholder_item_$index';
                  // generate a random number from seed
                  return GestureDetector(
                    onLongPressStart: (details) {
                      showHighlighterOverlay(id);
                    },
                    onTap: () {
                      Navigator.of(context).push(
                        CircularRevealPageRoute<void>(
                          page: const RevealPage(),
                          centerAlignment: _findCenter(id),
                        ),
                      );
                    },
                    child: Highlighter(
                      id: id,
                      child: RandomGlowingContainer(
                        seedId: id,
                        child: const SizedBox(),
                      ),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Offset _findCenter(String id) {
    final key = GlobalKeyRegistry.instance.getKey(id);
    final context = key.currentContext;

    if (context == null) return Offset.zero;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return Offset.zero;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final center = Offset(
      offset.dx + size.width / 2,
      offset.dy + size.height / 2,
    );
    return center;
  }
}
