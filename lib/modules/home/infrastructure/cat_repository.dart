import 'package:catbreeds/modules/home/domain/models/cat.dart';

abstract class CatRepository {
  Future<List<Cat>> fetchCats(String? breedId);
}
