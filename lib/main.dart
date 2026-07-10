import 'package:demo_app/features/carrito/providers/carrito_provider.dart';
import 'package:demo_app/features/auth/screens/login.dart';
import 'package:demo_app/features/direcciones/providers/direccion_provider.dart';
import 'package:demo_app/features/pedidos/providers/pedido_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CarritoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => PedidoProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DireccionProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.black),
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}
