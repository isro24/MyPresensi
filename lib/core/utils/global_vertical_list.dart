import 'package:flutter/material.dart';

class GlobalVerticalPaginatedList extends StatefulWidget {
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemsPerPage;
  final double spacing;

  const GlobalVerticalPaginatedList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.itemsPerPage = 5,
    this.spacing = 12,
  });

  @override
  State<GlobalVerticalPaginatedList> createState() => _GlobalVerticalPaginatedListState();
}

class _GlobalVerticalPaginatedListState extends State<GlobalVerticalPaginatedList> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final totalPages = (widget.itemCount / widget.itemsPerPage).ceil();
    final startIndex = currentPage * widget.itemsPerPage;
    final endIndex = (startIndex + widget.itemsPerPage).clamp(0, widget.itemCount);

    return Column(
      children: [
        ...List.generate(endIndex - startIndex, (i) {
          final index = startIndex + i;
          return Padding(
            padding: EdgeInsets.only(bottom: i == endIndex - startIndex - 1 ? 0 : widget.spacing),
            child: widget.itemBuilder(context, index),
          );
        }),
        if (totalPages > 1)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: currentPage > 0
                      ? () => setState(() => currentPage--)
                      : null,
                  icon: const Icon(Icons.arrow_back),
                ),
                Text('Halaman ${currentPage + 1} / $totalPages'),
                IconButton(
                  onPressed: currentPage < totalPages - 1
                      ? () => setState(() => currentPage++)
                      : null,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
