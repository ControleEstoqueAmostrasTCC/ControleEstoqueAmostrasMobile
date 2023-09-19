import 'package:controle_estoque_amostras_app/2-base/modules/home/widgets/card_menu_widget.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/listDescription/pages/list_description_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/login/pages/login_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/menu/pages/menu_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/shared/widgets/background_widget.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/assets.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/static_infos.dart';
import 'package:flutter/material.dart';

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
              if (user?.canViewTissueMenu ?? false)
                CardMenuWidget(
                  path: iconTissue,
                  title: "Tecidos",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListDescriptionPage(entityName: "Tissue", title: "Tecidos")),
                  ),
                ),
              if (user?.canViewProcedureMenu ?? false)
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
              if (user?.canViewCollectionLocationMenu ?? false)
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
              if (user?.canViewRegisterMenu ?? false)
                CardMenuWidget(
                  path: iconBox,
                  title: "Caixas",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListDescriptionPage(entityName: "Box", title: "Caixas")),
                  ),
                ),
              if (user?.canViewSpecieMenu ?? false)
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
              if (user?.canViewGenderMenu ?? false)
                CardMenuWidget(
                  path: iconGender,
                  title: "Sexos",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListDescriptionPage(entityName: "Gender", title: "Sexos")),
                  ),
                ),
              if (user?.canViewUserMenu ?? false)
                CardMenuWidget(
                  path: iconUser,
                  title: "Usuários",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListDescriptionPage(entityName: "User", title: "Usuários")),
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
        )
      ],
    );
  }
}
