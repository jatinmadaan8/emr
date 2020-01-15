import 'package:practiceinsights_emr_provider/modules/encounters/data/models/system_assessments/gastro_intestinal.dart';

abstract class GastroIntestinalLocalDataSource {
  Future<GastroIntestinalModel> getGastroIntestinal();

  Future<List<GastroIntestinalDropDown>> getDropDown(String value);

  Future<void> addGastroIntestinal();
  Future<void> deleteGastroIntestinal();
  Future<void> updateGastroIntestinal(GastroIntestinalModel gastroIntestinal);
}

class GastroIntestinalLocalDataSourceImpl
    implements GastroIntestinalLocalDataSource {
  @override
  Future<void> addGastroIntestinal() {
    // TODO: implement addGastroIntestinal
    return null;
  }

  @override
  Future<void> deleteGastroIntestinal() {
    // TODO: implement deleteGastroIntestinal
    return null;
  }

  @override
  Future<List<GastroIntestinalDropDown>> getDropDown(String value) {
    // TODO: implement getDropDown
    return null;
  }

  @override
  Future<GastroIntestinalModel> getGastroIntestinal() {
    // TODO: implement getGastroIntestinal
    return null;
  }

  @override
  Future<void> updateGastroIntestinal(GastroIntestinalModel gastroIntestinal) {
    // TODO: implement updateGastroIntestinal
    return null;
  }
}
