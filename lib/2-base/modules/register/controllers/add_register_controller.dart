import 'package:collection/collection.dart';
import 'package:controle_estoque_amostras_app/1-base/models/base/base_description_entity.dart';
import 'package:controle_estoque_amostras_app/1-base/models/box/box.dart';
import 'package:controle_estoque_amostras_app/1-base/models/collectionLocation/collection_location.dart';
import 'package:controle_estoque_amostras_app/1-base/models/gender/gender.dart';
import 'package:controle_estoque_amostras_app/1-base/models/procedure/procedure.dart';
import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:controle_estoque_amostras_app/1-base/models/specie/specie.dart';
import 'package:controle_estoque_amostras_app/1-base/models/tissue/tissue.dart';
import 'package:controle_estoque_amostras_app/1-base/models/user/user.dart';
import 'package:controle_estoque_amostras_app/1-base/services/box_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/collection_location_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/gender_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/procedure_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/register_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/specie_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/tissue_service.dart';
import 'package:controle_estoque_amostras_app/1-base/services/user_service.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/exceptions.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/formatters.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/instances.dart';
import 'package:controle_estoque_amostras_app/2-base/utils/masks.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:uuid/uuid.dart';

class AddRegisterController extends ChangeNotifier {
  late final ValueNotifier<List<Box>> _boxes;
  late ValueNotifier<Box?> _selectedBox;
  late final TextEditingController _boxController;
  late final ValueNotifier<List<CollectionLocation>> _collectionLocations;
  late ValueNotifier<CollectionLocation?> _selectedCollectionLocation;
  late final TextEditingController _collectionLocationController;
  late final ValueNotifier<List<Gender>> _genders;
  late ValueNotifier<Gender?> _selectedGender;
  late final TextEditingController _genderController;
  late final ValueNotifier<List<Procedure>> _procedures;
  late ValueNotifier<Procedure?> _selectedProcedure;
  late final TextEditingController _procedureController;
  late final ValueNotifier<List<Specie>> _species;
  late ValueNotifier<Specie?> _selectedSpecie;
  late final TextEditingController _specieController;
  late final ValueNotifier<List<Tissue>> _tissues;
  late ValueNotifier<Tissue?> _selectedTissue;
  late final TextEditingController _tissueController;
  late ValueNotifier<bool> _hasTissue;
  late final ValueNotifier<List<User>> _users;
  late ValueNotifier<User?> _selectedUser;
  late final TextEditingController _userController;
  late final TextEditingController _collectionDateController;
  late final TextEditingController _observationController;
  late final TextEditingController _cytogeneticController;
  late ValueNotifier<bool> _hasCytogenetic;
  late final TextEditingController _freezerController;
  late final TextEditingController _registerNumberController;
  late TextEditingController _verticalPositionController;
  late TextEditingController _horizontalPositionController;
  late final GlobalKey<FormState> _formKey;
  late final MaskTextInputFormatter _dateMask;
  String? _registerId;
  int? _registerCode;

  AddRegisterController() {
    _boxes = ValueNotifier([]);
    _selectedBox = ValueNotifier(null);
    _boxController = TextEditingController();
    _collectionLocations = ValueNotifier([]);
    _selectedCollectionLocation = ValueNotifier(null);
    _collectionLocationController = TextEditingController();
    _genders = ValueNotifier([]);
    _selectedGender = ValueNotifier(null);
    _genderController = TextEditingController();
    _procedures = ValueNotifier([]);
    _selectedProcedure = ValueNotifier(null);
    _procedureController = TextEditingController();
    _species = ValueNotifier([]);
    _selectedSpecie = ValueNotifier(null);
    _specieController = TextEditingController();
    _tissues = ValueNotifier([]);
    _selectedTissue = ValueNotifier(null);
    _tissueController = TextEditingController();
    _users = ValueNotifier([]);
    _selectedUser = ValueNotifier(null);
    _userController = TextEditingController();
    _collectionDateController = TextEditingController();
    _observationController = TextEditingController();
    _cytogeneticController = TextEditingController();
    _freezerController = TextEditingController();
    _registerNumberController = TextEditingController();
    _verticalPositionController = TextEditingController();
    _horizontalPositionController = TextEditingController();
    _hasTissue = ValueNotifier(true);
    _hasCytogenetic = ValueNotifier(true);
    _formKey = GlobalKey<FormState>();
    _dateMask = date;
    initMethods();
    _configureListenersSearchFields();
  }

  //Getters
  ValueNotifier<List<Box>> get boxes => _boxes;
  ValueNotifier<Box?> get selectedBox => _selectedBox;
  TextEditingController get boxController => _boxController;
  ValueNotifier<List<CollectionLocation>> get collectionLocations => _collectionLocations;
  ValueNotifier<CollectionLocation?> get selectedCollectionLocation => _selectedCollectionLocation;
  TextEditingController get collectionLocationController => _collectionLocationController;
  ValueNotifier<List<Gender>> get genders => _genders;
  ValueNotifier<Gender?> get selectedGender => _selectedGender;
  TextEditingController get genderController => _genderController;
  ValueNotifier<List<Procedure>> get procedures => _procedures;
  ValueNotifier<Procedure?> get selectedProcedure => _selectedProcedure;
  TextEditingController get procedureController => _procedureController;
  ValueNotifier<List<Specie>> get species => _species;
  ValueNotifier<Specie?> get selectedSpecie => _selectedSpecie;
  TextEditingController get specieController => _specieController;
  ValueNotifier<List<Tissue>> get tissues => _tissues;
  ValueNotifier<Tissue?> get selectedTissue => _selectedTissue;
  TextEditingController get tissueController => _tissueController;
  ValueNotifier<List<User>> get users => _users;
  ValueNotifier<User?> get selectedUser => _selectedUser;
  TextEditingController get userController => _userController;
  TextEditingController get collectionDateController => _collectionDateController;
  TextEditingController get observationController => _observationController;
  TextEditingController get cytogeneticController => _cytogeneticController;
  TextEditingController get freezerController => _freezerController;
  TextEditingController get registerNumberController => _registerNumberController;
  TextEditingController get verticalPositionController => _verticalPositionController;
  TextEditingController get horizontalPositionController => _horizontalPositionController;
  ValueNotifier<bool> get hasTissue => _hasTissue;
  ValueNotifier<bool> get hasCytogenetic => _hasCytogenetic;
  GlobalKey<FormState> get formKey => _formKey;
  MaskTextInputFormatter get dateMask => _dateMask;

  //Methods

  Future<void> initMethods() async {
    await Future.wait([
      getBoxes(),
      getCollectionLocations(),
      getGenders(),
      getProcedures(),
      getSpecies(),
      getTissues(),
      getUsers(),
    ]);
  }

  void resetVariables() {
    _selectedBox.value = null;
    _selectedCollectionLocation.value = null;
    _selectedGender.value = null;
    _selectedProcedure.value = null;
    _selectedSpecie.value = null;
    _selectedTissue.value = null;
    _selectedUser.value = null;
    _boxController.text = '';
    _collectionLocationController.text = '';
    _genderController.text = '';
    _procedureController.text = '';
    _specieController.text = '';
    _tissueController.text = '';
    _userController.text = '';
    _collectionDateController.text = '';
    _observationController.text = '';
    _cytogeneticController.text = '';
    _freezerController.text = '';
    _registerNumberController.text = '';
    _verticalPositionController.text = '';
    _horizontalPositionController.text = '';
    _hasTissue.value = false;
    _hasCytogenetic.value = false;
  }

  void configureListenerByBaseDescriptionEntity(
    TextEditingController controller,
    ValueNotifier<List<BaseDescriptionEntity>> entities,
    ValueNotifier<BaseDescriptionEntity?> selectedEntity,
  ) {
    final entity = entities.value.firstWhereOrNull(
      (element) => (element.description ?? element.name)!.toUpperCase() == controller.text.toUpperCase(),
    );
    selectedEntity.value = entity;
  }

  void configureUserListener() {
    final user =
        _users.value.firstWhereOrNull((element) => element.name!.toUpperCase() == _userController.text.toUpperCase());
    _selectedUser.value = user;
  }

  void _configureListenersSearchFields() {
    _boxController.addListener(() => configureListenerByBaseDescriptionEntity(_boxController, _boxes, _selectedBox));
    _genderController
        .addListener(() => configureListenerByBaseDescriptionEntity(_genderController, _genders, _selectedGender));
    _procedureController
        .addListener(() => configureListenerByBaseDescriptionEntity(_procedureController, _procedures, _selectedProcedure));
    _specieController
        .addListener(() => configureListenerByBaseDescriptionEntity(_specieController, _species, _selectedSpecie));
    _tissueController
        .addListener(() => configureListenerByBaseDescriptionEntity(_tissueController, _tissues, _selectedTissue));
    _collectionLocationController.addListener(
      () => configureListenerByBaseDescriptionEntity(
        _collectionLocationController,
        _collectionLocations,
        _selectedCollectionLocation,
      ),
    );
    _userController.addListener(configureUserListener);
  }

  void fillVariablesByRegister(Register register) {
    _registerId = register.id;
    _registerCode = register.code;
    _selectedBox.value = _boxes.value.firstWhereOrNull((element) => element.id == register.boxId);
    _selectedCollectionLocation.value =
        _collectionLocations.value.firstWhereOrNull((element) => element.id == register.collectionLocationId);
    _selectedGender.value = _genders.value.firstWhereOrNull((element) => element.id == register.genderId);
    _selectedProcedure.value = _procedures.value.firstWhereOrNull((element) => element.id == register.procedureId);
    _selectedSpecie.value = _species.value.firstWhereOrNull((element) => element.id == register.specieId);
    _selectedTissue.value = _tissues.value.firstWhereOrNull((element) => element.id == register.tissueId);
    _selectedUser.value = _users.value.firstWhereOrNull((element) => element.id == register.userId);
    if (_selectedBox.value != null) {
      _boxController.text = _selectedBox.value!.description!;
    }
    if (_selectedCollectionLocation.value != null) {
      _collectionLocationController.text = _selectedCollectionLocation.value?.description ?? "";
    }
    if (_selectedGender.value != null) {
      _genderController.text = _selectedGender.value?.description ?? "";
    }
    if (_selectedProcedure.value != null) {
      _procedureController.text = _selectedProcedure.value?.description ?? "";
    }
    if (_selectedSpecie.value != null) {
      _specieController.text = _selectedSpecie.value?.description ?? "";
    }
    if (_selectedTissue.value != null) {
      _tissueController.text = _selectedTissue.value?.description ?? "";
    }
    if (_selectedUser.value != null) {
      _userController.text = _selectedUser.value?.name ?? "";
    }
    _collectionDateController.text = register.collectionDate != null ? formatDateTimeToBrazil(register.collectionDate!) : "";
    _observationController.text = register.observation ?? "";
    _cytogeneticController.text = register.cytogenetic ?? "";
    _freezerController.text = register.freezer ?? "";
    _registerNumberController.text = register.number.toString();
    _verticalPositionController.text = register.verticalPosition.toString();
    _horizontalPositionController.text = register.horizontalPosition.toString();
    _hasTissue.value = register.hasTissue;
    _hasCytogenetic.value = register.hasCytogenetic;
  }

  Future<void> getBoxes() async {
    _boxes.value = await BoxService().getAll();
    _boxes.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
    _boxes.notifyListeners();
  }

  Future<void> getCollectionLocations() async {
    _collectionLocations.value = await CollectionLocationService().getAll();
    _collectionLocations.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
    _collectionLocations.notifyListeners();
  }

  Future<void> getGenders() async {
    _genders.value = await GenderService().getAll();
    _genders.value.sort((a, b) => a.id.compareTo(b.id));
    _genders.notifyListeners();
  }

  Future<void> getProcedures() async {
    _procedures.value = await ProcedureService().getAll();
    _procedures.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
    _procedures.notifyListeners();
  }

  Future<void> getSpecies() async {
    _species.value = await SpecieService().getAll();
    _species.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
    _species.notifyListeners();
  }

  Future<void> getTissues() async {
    _tissues.value = await TissueService().getAll();
    _tissues.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
    _tissues.notifyListeners();
  }

  Future<void> getUsers() async {
    _users.value = await UserService().getAll();
    _users.value.sort((a, b) => a.name!.compareTo(b.name!));
    _users.notifyListeners();
  }

  Future<void> _generateBoxItem() async {
    if (_boxController.text.isNotEmpty && _selectedBox.value == null) {
      final box = Box(
        description: _boxController.text,
        active: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: const Uuid().v4(),
        code: 0,
      );
      _boxes.value.add(box);
      _selectedBox.value = box;
      await BoxService().post(box.toJson());
      _boxes.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
      _boxes.notifyListeners();
    }
  }

  Future<void> _generateGenderItem() async {
    if (_genderController.text.isNotEmpty && _selectedGender.value == null) {
      final gender = Gender(
        description: _boxController.text,
        active: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: const Uuid().v4(),
        code: 0,
      );
      _genders.value.add(gender);
      _selectedGender.value = gender;
      await GenderService().post(gender.toJson());
      _genders.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
      _genders.notifyListeners();
    }
  }

  Future<void> _generateProcedureItem() async {
    if (_procedureController.text.isNotEmpty && _selectedProcedure.value == null) {
      final procedure = Procedure(
        description: _procedureController.text,
        active: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: const Uuid().v4(),
        code: 0,
      );
      _procedures.value.add(procedure);
      _selectedProcedure.value = procedure;
      await ProcedureService().post(procedure.toJson());
      _procedures.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
      _procedures.notifyListeners();
    }
  }

  Future<void> _generateSpecieItem() async {
    if (_specieController.text.isNotEmpty && _selectedSpecie.value == null) {
      final specie = Specie(
        description: _specieController.text,
        active: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: const Uuid().v4(),
        code: 0,
      );
      _species.value.add(specie);
      _selectedSpecie.value = specie;
      await SpecieService().post(specie.toJson());
      _species.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
      _species.notifyListeners();
    }
  }

  Future<void> _generateTissueItem() async {
    if (_tissueController.text.isNotEmpty && _selectedTissue.value == null) {
      final tissue = Tissue(
        description: _tissueController.text,
        active: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: const Uuid().v4(),
        code: 0,
      );
      _tissues.value.add(tissue);
      _selectedTissue.value = tissue;
      await TissueService().post(tissue.toJson());
      _tissues.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
      _tissues.notifyListeners();
    }
  }

  Future<void> _generateUserItem() async {
    if (_userController.text.isNotEmpty && _selectedUser.value == null) {
      final user = User(
        name: _userController.text,
        active: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: const Uuid().v4(),
        code: 0,
      );
      _users.value.add(user);
      _selectedUser.value = user;
      await UserService().post(user.toJson());
      _users.value.sort((a, b) => a.name!.compareTo(b.name!));
      _users.notifyListeners();
    }
  }

  Future<void> _generateCollectionLocationItem() async {
    if (_collectionLocationController.text.isNotEmpty && _selectedCollectionLocation.value == null) {
      final collectionLocation = CollectionLocation(
        description: _collectionLocationController.text,
        active: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        id: const Uuid().v4(),
        code: 0,
      );
      _collectionLocations.value.add(collectionLocation);
      _selectedCollectionLocation.value = collectionLocation;
      await CollectionLocationService().post(collectionLocation.toJson());
      _collectionLocations.value.sort((a, b) => (a.description ?? a.name)!.compareTo((b.description ?? b.name)!));
      _collectionLocations.notifyListeners();
    }
  }

  Future<void> _generatedItens() async {
    await Future.wait([
      _generateBoxItem(),
      _generateGenderItem(),
      _generateProcedureItem(),
      _generateSpecieItem(),
      _generateTissueItem(),
      _generateUserItem(),
      _generateCollectionLocationItem(),
    ]);
  }

  Future<void> saveRegister(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) throw InvalidFormException();
      await _generatedItens();
      final register = Register(
        boxId: _selectedBox.value?.id,
        collectionDate: formatBrazilDateToDateTime(_collectionDateController.text),
        collectionLocationId: _selectedCollectionLocation.value?.id,
        cytogenetic: _cytogeneticController.text,
        freezer: _freezerController.text,
        genderId: _selectedGender.value?.id,
        observation: _observationController.text,
        procedureId: _selectedProcedure.value?.id,
        responsibleUserId: _selectedUser.value?.id,
        specieId: _selectedSpecie.value?.id,
        tissueId: _selectedTissue.value?.id,
        verticalPosition: int.parse(_verticalPositionController.text),
        horizontalPosition: convertLetterToNumber(_horizontalPositionController.text),
        updatedAt: DateTime.now(),
        id: _registerId ?? const Uuid().v4(),
        active: true,
        createdAt: DateTime.now(),
        number: int.parse(_registerNumberController.text),
        code: _registerCode ?? 0,
        hasCytogenetic: _hasCytogenetic.value,
        hasTissue: _hasTissue.value,
      );
      final createdRegister = await RegisterService().post(register.toJson());
      if (createdRegister != null) {
        menuController.changePage(0);
        createdRegister.boxDescription = _selectedBox.value?.description;
        createdRegister.box = _selectedBox.value;
        createdRegister.collectionLocationDescription = _selectedCollectionLocation.value?.description;
        createdRegister.collectionLocation = _selectedCollectionLocation.value;
        createdRegister.genderDescription = _selectedGender.value?.description;
        createdRegister.gender = _selectedGender.value;
        createdRegister.procedureDescription = _selectedProcedure.value?.description;
        createdRegister.procedure = _selectedProcedure.value;
        createdRegister.specieDescription = _selectedSpecie.value?.description;
        createdRegister.specie = _selectedSpecie.value;
        createdRegister.tissueDescription = _selectedTissue.value?.description;
        createdRegister.tissue = _selectedTissue.value;
        createdRegister.responsibleUserName = _selectedUser.value?.name;
        createdRegister.responsibleUser = _selectedUser.value;
        resetVariables();
        listController.registers.value.insert(0, createdRegister);
      }
    } on DefaultException catch (e) {
      if (e is! InvalidFormException) {}
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
