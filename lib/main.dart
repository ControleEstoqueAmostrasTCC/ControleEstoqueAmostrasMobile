import 'package:controle_estoque_amostras_app/1-base/context/context.dart';
import 'package:controle_estoque_amostras_app/1-base/services/box_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/collection_location_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/gender_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/procedure_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/register_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/specie_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/tissue_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/user_service.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_web_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/login/pages/login_page.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instance_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final services = [
  BoxService(),
  CollectionLocationService(),
  GenderService(),
  ProcedureService(),
  RegisterService(),
  SpecieService(),
  TissueService(),
  UserService(),
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) await Context().initializeDatabase();
  for (final service in services) {
    instanceManager.registerInstance(service);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ResponsiveSizer(
        builder: (context, _, __) => MaterialApp(
          title: 'LaGenPe',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
          routes: {
            '/lista': (context) => const ListWebPage(),
          },
          initialRoute: kIsWeb && (100.w > 600) ? '/lista' : '/',
        ),
      ),
    );
  }
}
