import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_presensi/data/models/request/admin/admin_location_request_model.dart';
import 'package:my_presensi/data/models/response/admin/admin_location_response_model.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_bloc.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_event.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_state.dart';
import 'package:my_presensi/presentation/admin/location/widget/map_screen.dart';

class AdminLocationUpdateScreen extends StatefulWidget {
  final int id;
  final LocationData location;

  const AdminLocationUpdateScreen({
    super.key,
    required this.id,
    required this.location,
  });

  @override
  State<AdminLocationUpdateScreen> createState() => _AdminLocationUpdateScreenState();
}

class _AdminLocationUpdateScreenState extends State<AdminLocationUpdateScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameCtrl;
  late TextEditingController radiusCtrl;

  String? address;
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.location.name);
    radiusCtrl = TextEditingController(text: widget.location.radius?.toString() ?? "100");
    latitude = widget.location.latitude != null ? double.parse(widget.location.latitude!) : 0.0;
    longitude = widget.location.longitude != null ? double.parse(widget.location.longitude!) : 0.0;
    address = null;

  }

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
    if (_formKey.currentState!.validate()) {
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

      context.read<AdminLocationBloc>().add(UpdateLocationEvent(widget.id, request));
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Edit Lokasi')),
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
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Nama Lokasi'),
                validator: (v) => (v == null || v.isEmpty) ? 'Nama lokasi wajib diisi' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: radiusCtrl,
                decoration: const InputDecoration(labelText: 'Radius (meter)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Radius wajib diisi';
                  if (int.tryParse(v) == null) return 'Radius harus angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Text('Alamat: ${address ?? "Belum dipilih"}'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _selectLocation,
                child: const Text('Pilih Lokasi di Peta'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}
