import 'package:flutter/material.dart';
import 'package:my_presensi/core/utils/global_vertical_list.dart';
import 'package:my_presensi/data/models/response/admin/admin_dashboard_response_model.dart';

class AbsentEmployeeList extends StatelessWidget {
  final List<Employee>? employees;

  const AbsentEmployeeList({super.key, required this.employees});

  @override
  Widget build(BuildContext context) {
    if (employees == null || employees!.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('Tidak ada pegawai yang absen.'),
      );
    }

    return GlobalVerticalPaginatedList(
      itemCount: employees!.length,
      itemsPerPage: 5,
      itemBuilder: (context, index) {
        final e = employees![index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            backgroundImage: e.photo != null ? NetworkImage(e.photo!) : null,
            child: e.photo == null ? const Icon(Icons.person) : null,
          ),
          title: Text(e.name ?? '-'),
          subtitle: Text(e.position ?? '-'),
        );
      },
    );
  }
}
