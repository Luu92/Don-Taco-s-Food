import 'package:demo_app/features/direcciones/providers/direccion_provider.dart';
import 'package:demo_app/models/direccion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgregarDireccionScreen extends StatefulWidget {
  const AgregarDireccionScreen({super.key});

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

  final calleController = TextEditingController();

  final numeroController = TextEditingController();

  final coloniaController = TextEditingController();

  final codigoPostalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final direccionProvider = Provider.of<DireccionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva dirección"),
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
            label: const Text(
              "Guardar dirección",
            ),
            onPressed: () {
              Direccion direccion = Direccion(
                  id: 0,
                  alias: aliasSeleccionado!,
                  calle: calleController.text,
                  numero: numeroController.text,
                  codigoPostal: codigoPostalController.text,
                  colonia: coloniaController.text,
                  idComensal: 1,
                  principal: false);

              direccionProvider.agregarDireccion(direccion);
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
