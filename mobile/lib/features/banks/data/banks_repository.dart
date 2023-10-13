import 'package:vtb_map/features/banks/entities/department.dart';
import 'package:vtb_map/features/map/domain/entities/app_location.dart';

//51.528032, 45.979318
class BanksRepository {

  const BanksRepository();

  Future<List<Department>> getDepartments() async {
     return await Future.delayed(
         const Duration(seconds: 1),
             () => [
               const Department(
                   id: 0,
                   point: AppLocation(lat: 51.528032, long: 45.979318)
               ),
               const Department(
                   id: 1,
                   point: AppLocation(lat: 51.508032, long: 45.479318)
               ),
               // const Department(
               //     id: 2,
               //     point: AppLocation(lat: 51.528032, long: 45.979318)
               // ),
               // const Department(
               //     id: 3,
               //     point: AppLocation(lat: 51.528032, long: 45.979318)
               //),
             ]
     );
  }
}