import 'package:flutter/material.dart';
import 'package:my_presensi/core/utils/global_vertical_list.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';

class ActiveLocationList extends StatelessWidget {
  final List<Location>? locations;

  const ActiveLocationList({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    if (locations == null || locations!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('Tidak ada lokasi aktif.'),
      );
    }

    return GlobalVerticalPaginatedList(
      itemCount: locations!.length,
      itemsPerPage: 5,
      itemBuilder: (context, index) {
        final loc = locations![index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.location_pin, color: Colors.red),
          title: Text(loc.name ?? '-'),
        );
      },
    );
  }
}
