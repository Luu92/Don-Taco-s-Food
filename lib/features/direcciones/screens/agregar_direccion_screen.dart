import 'package:demo_app/features/direcciones/providers/direccion_provider.dart';
import 'package:demo_app/models/direccion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgregarDireccionScreen extends StatefulWidget {
  final Direccion? direccion;
  const AgregarDireccionScreen({super.key, this.direccion});

  @override
  State<AgregarDireccionScreen> createState() => _AgregarDireccionScreenState();
}

class _AgregarDireccionScreenState extends State<AgregarDireccionScreen> {
  String? aliasSeleccionado = "Casa";
  final List<String> aliases = [
    "Casa",
    "Oficina",
    "Escuela",
    "Otro",
  ];

  late final TextEditingController calleController;

  late final TextEditingController numeroController;

  late final TextEditingController coloniaController;

  late final TextEditingController codigoPostalController;

  @override
  void initState() {
    super.initState();

    final direccion = widget.direccion;

    aliasSeleccionado = direccion?.alias ?? 'Casa';

    calleController = TextEditingController(
      text: direccion?.calle ?? '',
    );

    numeroController = TextEditingController(
      text: direccion?.numero ?? '',
    );

    coloniaController = TextEditingController(
      text: direccion?.colonia ?? '',
    );

    codigoPostalController = TextEditingController(
      text: direccion?.codigoPostal ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final estaEditando = widget.direccion != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          estaEditando ? 'Editar dirección' : 'Nueva dirección',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownButtonFormField<String>(
            value: aliasSeleccionado,
            decoration: const InputDecoration(
              labelText: "Alias",
              border: OutlineInputBorder(),
            ),
            items: aliases.map((alias) {
              return DropdownMenuItem(
                value: alias,
                child: Text(alias),
              );
            }).toList(),
            onChanged: (valor) {
              setState(() {
                aliasSeleccionado = valor;
              });
            },
          ),
          const SizedBox(height: 15),
          TextField(
            controller: calleController,
            decoration: const InputDecoration(
              labelText: "Calle",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: numeroController,
            decoration: const InputDecoration(
              labelText: "Número",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: coloniaController,
            decoration: const InputDecoration(
              labelText: "Colonia",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: codigoPostalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Código Postal",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton.icon(
            icon: const Icon(Icons.save),
            label: Text(
              estaEditando ? 'Guardar cambios' : 'Guardar dirección',
            ),
            onPressed: () {
              final estaEditando = widget.direccion != null;

              final direccion = Direccion(
                id: estaEditando ? widget.direccion!.id : 0,
                alias: aliasSeleccionado!,
                calle: calleController.text.trim(),
                numero: numeroController.text.trim(),
                codigoPostal: codigoPostalController.text.trim(),
                colonia: coloniaController.text.trim(),
                idComensal: estaEditando ? widget.direccion!.idComensal : 1,
                principal: estaEditando ? widget.direccion!.principal : false,
              );

              if (estaEditando) {
                context.read<DireccionProvider>().editarDireccion(direccion);
              } else {
                context.read<DireccionProvider>().agregarDireccion(direccion);
              }

              Navigator.pop(context, true);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    calleController.dispose();

    numeroController.dispose();

    coloniaController.dispose();

    codigoPostalController.dispose();

    super.dispose();
  }
}
