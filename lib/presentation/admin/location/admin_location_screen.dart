import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:geocoding/geocoding.dart';
import 'package:my_presensi/core/components/components.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/core/components/error_view.dart';
import 'package:my_presensi/core/components/empty_data.dart';
import 'package:my_presensi/core/utils/custome_snackbar.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_bloc.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_event.dart';
import 'package:my_presensi/presentation/admin/location/location_bloc/location_state.dart';

class AdminLocationScreen extends StatefulWidget {
  const AdminLocationScreen({super.key});

  @override
  State<AdminLocationScreen> createState() => _AdminLocationScreenState();
}

class _AdminLocationScreenState extends State<AdminLocationScreen> {
  final Map<int, String> _locationAddresses = {};

  @override
  void initState() {
    super.initState();
    context.read<AdminLocationBloc>().add(GetAllLocationsEvent());
  }

  Future<void> _getAddress(double lat, double lng, int id) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = '${place.street}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}';
        setState(() {
          _locationAddresses[id] = address;
        });
      }
    } catch (_) {
      setState(() {
        _locationAddresses[id] = 'Alamat tidak ditemukan';
      });
    }
  }

  void _confirmDelete(int id) {
    showDialog(
      context: context,
      builder: (ctx) => DeleteConfirmationDialog(
        title: 'Konfirmasi',
        message: 'Apakah Anda yakin ingin menghapus lokasi ini?',
        onConfirm: () {
          context.read<AdminLocationBloc>().add(DeleteLocationEvent(id));
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: AppBar(
        title: const Text("Manajemen Lokasi"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<AdminLocationBloc, AdminLocationState>(
        listener: (context, state) {
          if (state is AdminLocationError) {
            showAppSnackBar(context, state.message, type: SnackBarType.error);
          }
          if (state is AdminLocationSuccess) {
            showAppSnackBar(context, state.message, type: SnackBarType.success);
          }
        },
        builder: (context, state) {
          if (state is AdminLocationLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdminLocationError) {
            return ErrorView(
              message: state.message,
              onRetry: () => context.read<AdminLocationBloc>().add(GetAllLocationsEvent()),
            );
          }

          if (state is AdminLocationLoaded) {
            final locations = state.locations;
            if (locations.isEmpty) {
              return const EmptyDataView(message: 'Tidak ada data lokasi.');
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final loc = locations[index];
                final lat = double.tryParse(loc.latitude ?? '0') ?? 0.0;
                final lng = double.tryParse(loc.longitude ?? '0') ?? 0.0;

                if (!_locationAddresses.containsKey(loc.id)) {
                  _getAddress(lat, lng, loc.id!);
                }

                return Card(
                  color: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.black26,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: SizedBox(
                          height: 180,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(lat, lng),
                              zoom: 15,
                            ),
                            markers: {
                              Marker(
                                markerId: MarkerId(loc.id.toString()),
                                position: LatLng(lat, lng),
                              ),
                            },
                            zoomControlsEnabled: false,
                            scrollGesturesEnabled: false,
                            tiltGesturesEnabled: false,
                            rotateGesturesEnabled: false,
                            myLocationButtonEnabled: false,
                            liteModeEnabled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              loc.name ?? 'Tanpa Nama',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text('Latitude: ${loc.latitude}, Longitude: ${loc.longitude}'),
                            Text('Radius: ${loc.radius} meter'),
                            Text(
                              'Alamat: ${_locationAddresses[loc.id] ?? "Mengambil alamat..."}',
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    context.push('/admin/location/edit/${loc.id}', extra: loc);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _confirmDelete(loc.id!),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );

              },
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/admin/location/create'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.white,),
      ),
    );
  }
}
