import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/2-base/modules/listDescription/controllers/list_web_controller.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/formatters.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ListWebPage extends StatefulWidget {
  const ListWebPage({super.key});

  @override
  State<ListWebPage> createState() => _ListWebPageState();
}

class _ListWebPageState extends State<ListWebPage> {
  late final ListWebController controller;
  int currentPage = 1;

  @override
  void initState() {
    controller = ListWebController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: ValueListenableBuilder<List<Register>>(
            valueListenable: controller.registers,
            builder: (context, registers, __) {
              const itemsPerPage = 20;
              final dataSource = _DataSource(registers);

              // final startIndex = (currentPage - 1) * (itemsPerPage > registers.length ? registers.length : itemsPerPage);
              // final endIndex = startIndex + (itemsPerPage > registers.length ? registers.length : itemsPerPage);

              // final paginatedItems = registers.isEmpty ? <Register>[] : registers.sublist(startIndex, endIndex);

              return Column(
                children: [
                  AppBarWidget(
                    source: dataSource,
                    controller: controller,
                    currentPage: currentPage,
                    totalPages: (registers.length + itemsPerPage - 1) ~/ itemsPerPage,
                    previousPage: () {
                      if (currentPage > 1) {
                        setState(() {
                          currentPage--;
                        });
                      }
                    },
                    nextPage: () {
                      final totalPages = (registers.length + itemsPerPage - 1) ~/ itemsPerPage;
                      if (currentPage < totalPages) {
                        setState(() {
                          currentPage++;
                        });
                      }
                    },
                  ),
                  // Substitua o DataTableWidget pelo SfDataGrid
                  SizedBox(
                    height: 80.h,
                    child: SfDataGrid(
                      allowFiltering: true,
                      source: dataSource,
                      columns: <GridColumn>[
                        GridColumn(
                          columnName: 'Número',
                          label: const Text('Número'),
                        ),
                        GridColumn(
                          columnName: 'Freezer',
                          label: const Text('Freezer'),
                        ),
                        GridColumn(
                          columnName: 'Caixa',
                          label: const Text('Caixa'),
                        ),
                        GridColumn(
                          columnName: 'Posição Vertical',
                          label: const Text('Posição Vertical'),
                        ),
                        GridColumn(
                          columnName: 'Posição Horizontal',
                          label: const Text('Posição Horizontal'),
                        ),
                        GridColumn(
                          columnName: 'Citogenética',
                          label: const Text('Citogenética'),
                        ),
                        GridColumn(
                          columnName: 'Tem Citogenética',
                          label: const Text('Tem Citogenética'),
                        ),
                        GridColumn(
                          columnName: 'Tecido',
                          label: const Text('Tecido'),
                        ),
                        GridColumn(
                          columnName: 'Tem Tecido',
                          label: const Text('Tem Tecido'),
                        ),
                        GridColumn(
                          columnName: 'Sexo',
                          label: const Text('Sexo'),
                        ),
                        GridColumn(
                          columnName: 'Espécie',
                          label: const Text('Espécie'),
                        ),
                        GridColumn(
                          columnName: 'Local de Coleta',
                          label: const Text('Local de Coleta'),
                        ),
                        GridColumn(
                          columnName: 'Data de Coleta',
                          label: const Text('Data de Coleta'),
                        ),
                        GridColumn(
                          columnName: 'Observação',
                          label: const Text('Observação'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _DataSource extends DataGridSource {
  _DataSource(this.items);

  final List<Register> items;

  @override
  List<DataGridRow> get rows => items
      .map<DataGridRow>(
        (item) => DataGridRow(
          cells: [
            DataGridCell<int>(columnName: 'Número', value: item.number),
            DataGridCell<String>(columnName: 'Freezer', value: item.freezer?.toString() ?? 'Não informado'),
            DataGridCell<String>(columnName: 'Caixa', value: item.boxDisplay?.toString() ?? 'Não informado'),
            DataGridCell<String>(
              columnName: 'Posição Vertical',
              value: item.verticalPosition?.toString() ?? 'Não informado',
            ),
            DataGridCell<String>(
              columnName: 'Posição Horizontal',
              value: convertNumberToLetter(item.horizontalPosition ?? 0),
            ),
            DataGridCell<String>(columnName: 'Citogenética', value: item.cytogenetic ?? 'Não informado'),
            DataGridCell<bool>(columnName: 'Tem Citogenética', value: item.hasCytogenetic),
            DataGridCell<String>(columnName: 'Tecido', value: item.tissueDisplay ?? 'Não informado'),
            DataGridCell<bool>(columnName: 'Tem Tecido', value: item.hasTissue),
            DataGridCell<String>(columnName: 'Sexo', value: item.genderDisplay ?? 'Não informado'),
            DataGridCell<String>(columnName: 'Espécie', value: item.specieDisplay ?? 'Não informado'),
            DataGridCell<String>(
              columnName: 'Local de Coleta',
              value: item.collectionLocationDisplay ?? 'Não informado',
            ),
            DataGridCell<String>(columnName: 'Data de Coleta', value: item.collectionDateDisplay),
            DataGridCell<String>(columnName: 'Observação', value: item.observation ?? 'Não informado'),
          ],
        ),
      )
      .toList();

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: e.value is bool ? Checkbox(value: e.value as bool, onChanged: (_) {}) : SelectableText(e.value.toString()),
        );
      }).toList(),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback previousPage;
  final VoidCallback nextPage;
  final ListWebController controller;
  final _DataSource source;

  const AppBarWidget({
    required this.currentPage,
    required this.totalPages,
    required this.previousPage,
    required this.nextPage,
    required this.controller,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: SfDataPager(
        delegate: source,
        pageCount: (totalPages < 1 ? 1 : totalPages).toDouble(),
        visibleItemsCount: 1,
      ),
    );
  }
}
