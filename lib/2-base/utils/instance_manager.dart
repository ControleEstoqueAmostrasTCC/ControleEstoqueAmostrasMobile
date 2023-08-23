import 'package:controle_estoque_amostras_app/1-base/services/base/base_service.dart';

final instanceManager = InstanceManager();

class InstanceManager {
  // Mapa para armazenar as instâncias de serviços associadas aos nomes das classes
  final Map<String, dynamic> _instances = {};

  // Método para registrar uma instância associada a um nome de classe
  T registerInstance<T>(T instance, {String? entityName}) {
    _instances.putIfAbsent(
      instance.toString().substring(instance.toString().indexOf("'") + 1, instance.toString().lastIndexOf("'")) +
          (entityName ?? ""),
      () => instance,
    );
    // _instances[instance.runtimeType.toString()] = instance;
    return instance;
  }

  // Método para encontrar uma instância associada a um nome de classe
  BaseService findInstanceService<T>(String entityName) {
    final String serviceClassName = '${entityName}Service';

    return _instances[serviceClassName] as BaseService;
  }
}
