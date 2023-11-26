import 'dart:convert';
import 'dart:io';
import 'package:controle_estoque_amostras_app/1-base/services/register_service.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/home/pages/reset_password_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/home/widgets/card_menu_widget.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/listDescription/pages/list_description_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/login/pages/login_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/menu/pages/menu_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/shared/widgets/background_widget.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/assets.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/popups.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_html/html.dart' as html;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tipoConstrucao: TipoConstrucao.coluna,
      tipoConstrucaoFundoTela: TipoConstrucaoFundoTela.material,
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              CardMenuWidget(
                path: iconSpecies,
                title: "Lista",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MenuPage()),
                ),
              ),
              if (user.canViewSpecieMenu)
                CardMenuWidget(
                  path: iconSpecie,
                  title: "Espécies",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListDescriptionPage(entityName: "Specie", title: "Espécies"),
                    ),
                  ),
                ),
              if (user.canViewTissueMenu)
                CardMenuWidget(
                  path: iconTissue,
                  title: "Tecidos",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListDescriptionPage(entityName: "Tissue", title: "Tecidos"),
                    ),
                  ),
                ),
              if (user.canViewProcedureMenu)
                CardMenuWidget(
                  path: iconProcedure,
                  title: "Procedimentos",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListDescriptionPage(entityName: "Procedure", title: "Procedimentos"),
                    ),
                  ),
                ),
              if (user.canViewCollectionLocationMenu)
                CardMenuWidget(
                  path: iconCollectionLocation,
                  title: "Locais de Coletas",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ListDescriptionPage(entityName: "CollectionLocation", title: "Locais de Coletas"),
                    ),
                  ),
                ),
              if (user.canViewBoxMenu)
                CardMenuWidget(
                  path: iconBox,
                  title: "Caixas",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListDescriptionPage(entityName: "Box", title: "Caixas")),
                  ),
                ),
              if (user.canViewGenderMenu)
                CardMenuWidget(
                  path: iconGender,
                  title: "Sexos",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListDescriptionPage(entityName: "Gender", title: "Sexos")),
                  ),
                ),
              if (user.canViewUserMenu)
                CardMenuWidget(
                  path: iconUser,
                  title: "Usuários",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListDescriptionPage(entityName: "User", title: "Usuários"),
                    ),
                  ),
                ),
              if (user.canDownloadExcel)
                CardMenuWidget(
                  path: Icons.download,
                  title: "Baixar Excel",
                  onTap: () async {
                    showDefaultPopUp(
                      "Baixando...",
                      Center(
                        child: SizedBox(
                          height: 5.w,
                          width: 5.w,
                          child: const CircularProgressIndicator(
                            color: lightBlack,
                          ),
                        ),
                      ),
                      "Ok",
                      () => null,
                      context,
                      barrierDismissible: false,
                    );
                    final registerService = RegisterService();
                    final bytes = await registerService.generateRegisterExcel();
                    if (bytes == null) {
                      return errorPopUp("Erro ao gerar o arquivo excel", context);
                    }
                    Navigator.pop(context);
                    if (!kIsWeb) {
                      final directory = await getApplicationDocumentsDirectory();
                      final file = File('${directory.path}/amostras_${DateTime.now().millisecondsSinceEpoch}.xlsx');
                      await file.writeAsBytes(bytes);
                      await Share.shareXFiles([XFile(file.path)]);
                    } else {
                      final content = base64Encode(bytes);
                      final anchor =
                          html.AnchorElement(href: "data:application/octet-stream;charset=utf-16le;base64,$content")
                            ..setAttribute("download", "registros_lagenpe.xlsx");
                      html.document.body?.append(anchor);
                      anchor.click();
                      anchor.remove();
                    }
                  },
                ),
              CardMenuWidget(
                path: Icons.lock,
                title: "Redefinir Senha",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
                ),
              ),
              CardMenuWidget(
                path: Icons.logout,
                title: "Sair",
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
