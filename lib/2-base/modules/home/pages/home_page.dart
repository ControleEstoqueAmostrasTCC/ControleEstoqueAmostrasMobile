import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller;

  @override
  void initState() {
    controller = HomeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ValueListenableBuilder<List<Register>>(
          valueListenable: controller.registers,
          builder: (context, _, __) => ListView.builder(
            itemCount: controller.registers.value.length,
            itemBuilder: (context, index) {
              final register = controller.registers.value[index];
              return ListTile(
                title: Text(register.number.toString()),
                subtitle: Text(register.box?.description ?? "Sem caixa"),
              );
            },
          ),
        ),
      ),
    );
  }
}
