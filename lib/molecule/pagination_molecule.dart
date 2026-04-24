import 'package:flutter/material.dart';
import '../utils/pu_colors.dart';

class PaginationMolecule extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onItemsPerPageChanged;

  const PaginationMolecule({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    this.itemsPerPage = 20,
    this.onPageChanged,
    this.onItemsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildItemsPerPage(),
        _buildPageControls(),
      ],
    );
  }

  Widget _buildItemsPerPage() {
    return Row(
      children: [
        const Text(
          'Por página:',
          style: TextStyle(
            fontSize: 12,
            color: PUColors.textColorMuted,
          ),
        ),
        const SizedBox(width: 8),
        DropdownButton<int>(
          value: itemsPerPage,
          underline: const SizedBox(),
          isDense: true,
          items: const [
            DropdownMenuItem(value: 10, child: Text('10')),
            DropdownMenuItem(value: 20, child: Text('20')),
            DropdownMenuItem(value: 50, child: Text('50')),
            DropdownMenuItem(value: 100, child: Text('100')),
          ],
          onChanged: (value) {
            if (value != null) {
              onItemsPerPageChanged?.call(value);
            }
          },
        ),
      ],
    );
  }

  Widget _buildPageControls() {
    return Row(
      children: [
        Text(
          '${(currentPage - 1) * itemsPerPage + 1}-${(currentPage * itemsPerPage).clamp(0, totalItems)} de $totalItems',
          style: const TextStyle(
            fontSize: 12,
            color: PUColors.textColorMuted,
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: const Icon(Icons.chevron_left, size: 20),
          onPressed: currentPage > 1
              ? () => onPageChanged?.call(currentPage - 1)
              : null,
          visualDensity: VisualDensity.compact,
          color: PUColors.textColorRich,
        ),
        _buildPageNumbers(),
        IconButton(
          icon: const Icon(Icons.chevron_right, size: 20),
          onPressed: currentPage < totalPages
              ? () => onPageChanged?.call(currentPage + 1)
              : null,
          visualDensity: VisualDensity.compact,
          color: PUColors.textColorRich,
        ),
      ],
    );
  }

  Widget _buildPageNumbers() {
    final pages = <Widget>[];
    final startPage = (currentPage - 2).clamp(1, totalPages);
    final endPage = (currentPage + 2).clamp(1, totalPages);

    for (var i = startPage; i <= endPage; i++) {
      pages.add(
        InkWell(
          onTap: () => onPageChanged?.call(i),
          child: Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: i == currentPage
                  ? PUColors.primaryColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '$i',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: i == currentPage
                    ? Colors.white
                    : PUColors.textColorMuted,
              ),
            ),
          ),
        ),
      );
    }

    return Row(children: pages);
  }
}