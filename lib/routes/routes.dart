import 'package:flutter/material.dart';
import 'package:cape_and_kingdom_exports/features/auth/screens/sign_in_screen.dart';
import 'package:cape_and_kingdom_exports/features/home/screens/add_client_screen.dart';
import 'package:cape_and_kingdom_exports/features/home/screens/edit_client_screen.dart';
import 'package:cape_and_kingdom_exports/features/home/screens/order_dashboard_screen.dart';
import 'package:cape_and_kingdom_exports/features/home/screens/order_detail_screen.dart';
import 'package:cape_and_kingdom_exports/features/home/screens/wine_selection_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SignInScreen(),

  '/order-dashboard': (context) => const OrderDashboardScreen(),

  '/order-detail': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return OrderDetailScreen(order: args);
  },

  '/wine-selection': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return WineSelectionScreen(
      clientInfo: args['clientInfo'],
      selectedWine: args['selectedWine'], // optional: check if you're passing this
    );
  },

  '/add-client': (context) => const AddClientScreen(),

  '/edit-client': (context) {
    return EditClientScreen(); // Args handled inside the screen
  },
};



