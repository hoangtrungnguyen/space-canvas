import '../dto/space_dto.dart';

class SpaceViewRepository {
  SpaceViewRepository();

  Future<SpaceDto?> findById(String id) async {
    return SpaceDto(id: 'sdfs', name: "Test");
  }
}
