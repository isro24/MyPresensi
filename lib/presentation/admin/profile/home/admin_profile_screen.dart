import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_presensi/core/constants/colors.dart';
import 'package:my_presensi/presentation/admin/profile/bloc/admin_profile_bloc.dart';
import 'package:my_presensi/core/components/error_view.dart'; 
import 'package:my_presensi/presentation/admin/profile/home/widget/profil_content.dart';
import 'package:my_presensi/core/layouts/profile_app_bar.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminProfileBloc>().add(GetAdminProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomeProfileAppBar(
        title: 'Profile Admin',
        onNotificationTap: () => context.push('/notifications'),
      ),
      body: BlocBuilder<AdminProfileBloc, AdminProfileState>(
        builder: (context, state) {
          if (state is AdminProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AdminProfileLoaded || state is AdminProfileUpdated) {
            final data = (state is AdminProfileLoaded
                ? state.profile.data
                : (state as AdminProfileUpdated).profile.data);

            return AdminProfileContent(data: data);
          } else if (state is AdminProfileError) {
            return ErrorView(
              message: 'Gagal memuat profil',
              onRetry: () {
                context.read<AdminProfileBloc>().add(GetAdminProfileEvent());
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
