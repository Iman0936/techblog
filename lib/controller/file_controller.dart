import 'package:file_picker/file_picker.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FilePickerController extends GetxController {
  Rx<PlatformFile> file = PlatformFile(name: 'nothing', size: 0).obs;
}
