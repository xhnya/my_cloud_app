import 'package:my_cloud_app/request/api_service.dart';

class FileApi{



  static Future getUserMenuApi(int parentId) async {
    final response = await ApiService.get("/file/getUserMenu",
        params: {
          "parentId": parentId
        }
    );
    return response;
  }
  static Future createFolderApi(String dirName,int parentId) async {
    final response = await ApiService.post("/file/createDirectory",
        data: {
          "parentId": parentId,
          "dirName": dirName
        }
    );
    return response;
  }

}