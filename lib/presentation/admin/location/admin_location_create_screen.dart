import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/data/models/request/admin/admin_location_request_model.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_bloc.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_event.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_state.dart';
import 'package:my_presensi/presentation/admin/location/widget/map_screen.dart';

class AdminLocationCreateScreen extends StatefulWidget {
  const AdminLocationCreateScreen({super.key});

  @override
  State<AdminLocationCreateScreen> createState() => _AdminLocationCreateScreenState();
}

class _AdminLocationCreateScreenState extends State<AdminLocationCreateScreen> {
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final radiusCtrl = TextEditingController(text: "100");

  String? address;
  double? latitude;
  double? longitude;

  Future<void> _selectLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MapPage()),
    );
    if (result != null && result is Map) {
      setState(() {
        address = result['address'];
        latitude = result['latitude'];
        longitude = result['longitude'];
      });
    }
  }

  void _submit() {
    if (formKey.currentState!.validate()) {
      if (latitude == null || longitude == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Silakan pilih lokasi di peta')),
        );
        return;
      }

      final request = AdminLocationRequestModel(
        name: nameCtrl.text,
        latitude: latitude!.toInt(),
        longitude: longitude!.toInt(),
        radius: int.tryParse(radiusCtrl.text) ?? 100,
      );

      context.read<AdminLocationBloc>().add(CreateLocationEvent(request));
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.grey200,
    appBar: AppBar(
      title: const Text('Tambah Lokasi'),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    body: BlocListener<AdminLocationBloc, AdminLocationState>(
      listener: (context, state) {
        if (state is AdminLocationSuccess) {
          Navigator.pop(context, true);
        }
        if (state is AdminLocationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nama Lokasi',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.isEmpty) ? 'Nama lokasi wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: radiusCtrl,
                decoration: const InputDecoration(
                  labelText: 'Radius (meter)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Radius wajib diisi';
                  if (int.tryParse(v) == null) return 'Radius harus angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text(
                'Alamat: ${address ?? "Belum dipilih"}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _selectLocation,
                icon: const Icon(Icons.map),
                label: const Text('Pilih Lokasi di Peta'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Simpan', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}