import 'package:controle_estoque_amostras_app/2-base/modules/list/pages/list_page.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/assets.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/colors.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BackgroundWidget extends StatelessWidget {
  final TipoConstrucao tipoConstrucao;
  final TipoConstrucaoFundoTela tipoConstrucaoFundoTela;
  final List<Widget> children;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final CrossAxisAlignment crossAxisAlignment;
  final GlobalKey<FormState>? formKey;
  final AutovalidateMode? autovalidateMode;
  final Widget? widgetAfterLogo;
  final String? title;
  final void Function()? onTapDelete;
  final void Function()? onTapEdit;
  final void Function()? onTapAdd;
  final bool deleted;
  final bool showBackButtonLogoLagenpe;
  const BackgroundWidget({
    super.key,
    required this.tipoConstrucao,
    required this.tipoConstrucaoFundoTela,
    required this.children,
    this.floatingActionButton,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.formKey,
    this.autovalidateMode,
    this.bottomNavigationBar,
    this.widgetAfterLogo,
    this.title,
    this.onTapDelete,
    this.onTapEdit,
    this.deleted = false,
    this.onTapAdd,
    this.showBackButtonLogoLagenpe = false,
  });

  @override
  Widget build(BuildContext context) {
    if (tipoConstrucaoFundoTela == TipoConstrucaoFundoTela.material) {
      return Material(
        child: background(context),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: transparent,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: background(context),
    );
  }

  Widget background(BuildContext context) => SafeArea(
        child: ColoredBox(
          color: backgroundBlack,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                child: Column(
                  children: [
                    if (title != null)
                      Row(
                        children: [
                          if (Navigator.of(context).canPop())
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.arrow_back_ios, color: white),
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: TextWidget(title!, color: white, fontSize: medium),
                            ),
                          ),
                          if (onTapDelete != null)
                            IconButton(
                              icon: Icon(deleted ? Icons.recycling_rounded : Icons.delete, color: white),
                              onPressed: onTapDelete,
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          if (onTapEdit != null)
                            IconButton(
                              icon: const Icon(Icons.edit, color: white),
                              onPressed: onTapEdit,
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                          if (onTapAdd != null)
                            IconButton(
                              icon: const Icon(Icons.add, color: white),
                              onPressed: onTapAdd,
                              padding: EdgeInsets.zero,
                              visualDensity: VisualDensity.compact,
                            ),
                        ],
                      ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Lagenpe\n",
                                        style: TextStyle(fontFamily: 'Futura2', color: white, fontSize: big),
                                      ),
                                      // TextSpan(
                                      //   text: "Laboratório de Genômica e",
                                      //   style: TextStyle(
                                      //     fontFamily: 'Koblenz',
                                      //     color: white,
                                      //     fontSize: mediumBig,
                                      //     fontWeight: FontWeight.bold,
                                      //   ),
                                      // ),
                                      TextSpan(
                                        text: "Laboratório de Genômica e\nConservação de Peixes",
                                        style: TextStyle(
                                          fontFamily: 'Futura2',
                                          color: white,
                                          fontSize: smallMedium,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: showBackButtonLogoLagenpe,
                                  child: Positioned(
                                    left: 0,
                                    top: 0,
                                    child: IconButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      icon: const Icon(Icons.arrow_back_ios, color: white),
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(logoImageLabNoBackground, width: 40.w, height: 10.h),
                        ],
                      ),
                    ),
                    if (widgetAfterLogo != null) widgetAfterLogo!,
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(3.w), topRight: Radius.circular(3.w)),
                    color: lightGrey,
                  ),
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      child: tipoConstrucao == TipoConstrucao.lista
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: crossAxisAlignment,
                                children: children,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: crossAxisAlignment,
                              children: children,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
