//Thema, sice y colors
export 'constants/app_sizes.dart';
export 'theme/app_colors.dart';
export 'theme/app_theme.dart';

//Features
export 'package:demo_app/features/carrito/providers/carrito_provider.dart';
export 'package:demo_app/features/auth/screens/login.dart';
export 'package:demo_app/features/cuenta/providers/perfil_provider.dart';
export 'package:demo_app/features/direcciones/providers/direccion_provider.dart';
export 'package:demo_app/features/pedidos/providers/pedido_provider.dart';
export 'package:demo_app/features/menu/screens/categorias_screen.dart';
export 'package:demo_app/features/auth/screens/recuperar_cuenta.dart';
export 'package:demo_app/features/auth/screens/registro_cliente.dart';
export 'package:demo_app/features/auth/widgets/contrasena_actualizada_dialog.dart';
export 'package:demo_app/features/carrito/widgets/carrito_vacio.dart';
export 'package:demo_app/features/carrito/widgets/monto_minimo_dialog.dart';
export 'package:demo_app/features/direcciones/screens/agregar_direccion_screen.dart';
export 'package:demo_app/features/direcciones/screens/direcciones_screen.dart';
export 'package:demo_app/features/pedidos/screens/pedidos_screen.dart';
export 'package:demo_app/features/pedidos/widgets/confirmar_pedido_dialog.dart';
export 'package:demo_app/features/pedidos/widgets/pedido_enviado_dialog.dart';
export 'package:demo_app/features/cuenta/services/perfil_service.dart';
export 'package:demo_app/features/cuenta/screens/editar_perfil_screen.dart';
export 'package:demo_app/features/cuenta/widgets/cerrar_sesion_dialog.dart';
export 'package:demo_app/features/cuenta/widgets/perfil_actualizado_dialog.dart';
export 'package:demo_app/features/direcciones/widgets/direccion_fuera_cobertura_dialog.dart';
export 'package:demo_app/features/direcciones/widgets/direcciones_vacias.dart';
export 'package:demo_app/features/direcciones/widgets/eliminar_direccion_dialog.dart';
export 'package:demo_app/features/cuenta/screens/perfil_screen.dart';
export 'package:demo_app/features/widgets/bottom_nav_bar.dart';
export 'package:demo_app/features/menu/screens/alimentos_screen.dart';
export 'package:demo_app/features/carrito/screens/carrito_screen.dart';
export 'package:demo_app/features/pedidos/widgets/estado_pedido_widget.dart';
export 'package:demo_app/features/pedidos/screens/pedido_detalle_screen.dart';
export 'package:demo_app/features/pedidos/widgets/pedidos_vacios_dialog.dart';

//Services
export 'package:demo_app/services/auth_service.dart';
export 'package:demo_app/services/direccion_service.dart';
export 'package:demo_app/services/alimento_service.dart';
export 'package:demo_app/services/categoria_service.dart';
export 'package:demo_app/features/navigation/screens/main_container.dart';
export 'package:demo_app/features/pedidos/services/pedido_service.dart';

//models
export 'package:demo_app/models/direccion.dart';
export 'package:demo_app/models/pedido.dart';
export 'package:demo_app/models/usuario.dart';
export 'package:demo_app/models/alimento.dart';
export 'package:demo_app/models/categoria.dart';

//Dependencies Dart
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';
export 'package:flutter/services.dart';
