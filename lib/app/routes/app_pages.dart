import 'package:cancer_care_app/app/modules/navigation/views/tnm_calculator.dart';
import 'package:get/get.dart';

import '../modules/appointments/bindings/appointments_binding.dart';
import '../modules/appointments/views/appointments_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/sign_in_view.dart';
import '../modules/auth/views/sign_up_view.dart';
import '../modules/doctors/bindings/doctors_binding.dart';
import '../modules/doctors/views/doctors_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/navigation/bindings/navigation_binding.dart';
import '../modules/navigation/views/navigation_view.dart';
import '../modules/prescription/bindings/prescription_binding.dart';
import '../modules/prescription/views/prescription_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => SignInView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_VIEW,
      page: () => const NavigationView(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DOCTORS,
      page: () => const DoctorsView(),
      binding: DoctorsBinding(),
    ),
    GetPage(
      name: _Paths.APPOINTMENTS,
      page: () => const TNMCalculatorPage(),
      binding: AppointmentsBinding(),
    ),
    GetPage(
      name: _Paths.PRESCRIPTION,
      page: () => const AppointmentListPage(), // Placeholder for appointments
      binding: PrescriptionBinding(),
    ),
  ];
}
