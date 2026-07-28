import 'package:demo_app/core/core.dart';

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
        ChangeNotifierProvider(create: (_) => PerfilProvider())
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
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const Login());
  }
}
