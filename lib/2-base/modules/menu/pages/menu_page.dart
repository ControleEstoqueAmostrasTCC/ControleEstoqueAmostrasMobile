import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/menu/controllers/menu_controller.dart' as controller_menu;
import 'package:controle_estoque_amostras_app/2-base/modules/register/pages/add_register_page.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/shared/widgets/background_widget.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instances.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late final controller_menu.MenuController controller;

  @override
  void initState() {
    controller = menuController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      tipoConstrucao: TipoConstrucao.coluna,
      tipoConstrucaoFundoTela: TipoConstrucaoFundoTela.scaffold,
      floatingActionButton: ValueListenableBuilder(
        valueListenable: controller.selectedPage,
        builder: (context, _, __) {
          if (controller.selectedPage.value == 0) {
            return FloatingActionButton(
              backgroundColor: lightBackground,
              onPressed: controller.goToAddRegisterPage,
              child: const Icon(Icons.add),
            );
          }
          if (controller.selectedPage.value == 1) {
            return FloatingActionButton(
              backgroundColor: lightBackground,
              onPressed: () async => addRegisterController.saveRegister(context),
              child: const Icon(Icons.save),
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: controller.selectedPage,
        builder: (context, _, __) {
          return BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: bottomAppbar,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ItemAppBarWidget(
                    selected: controller.selectedPage.value == 0,
                    icon: Icons.search,
                    onTap: () => controller.changePage(0),
                  ),
                  ItemAppBarWidget(
                    selected: controller.selectedPage.value == 1,
                    icon: Icons.add,
                    onTap: () => controller.changePage(1),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      widgetAfterLogo: Column(
        children: [
          SizedBox(height: 1.h),
          ValueListenableBuilder(
            valueListenable: controller.selectedPage,
            builder: (context, _, __) {
              return AnimatedOpacity(
                opacity: controller.selectedPage.value == 0 ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: TextFieldWidget(
                  controller: listController.searchController,
                  prefixIcon: const Icon(Icons.search),
                ),
              );
            },
          ),
        ],
      ),
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            child: PageView(
              controller: controller.pageController,
              children: const [
                ListPage(),
                AddRegisterPage(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ItemAppBarWidget extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final void Function()? onTap;

  const ItemAppBarWidget({
    super.key,
    required this.selected,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerWidget(
        color: selected ? blueAccent : transparent,
        height: 4.h,
        width: 10.w,
        margin: EdgeInsets.symmetric(vertical: 0.25.h),
        child: Icon(
          icon,
          size: 6.w,
          color: selected ? black : blueAccent,
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final Color? color;
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final AlignmentGeometry? alignment;
  final List<BoxShadow>? boxShadow;
  const ContainerWidget({
    super.key,
    this.color,
    required this.child,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.alignment,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? white,
        borderRadius: BorderRadius.circular(2.w),
        boxShadow: boxShadow,
      ),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}
