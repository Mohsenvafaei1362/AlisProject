import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/sliderInfo.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/GetSmsCode/get_sms_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persian_utils/persian_utils.dart';
import 'package:http/http.dart' as http;
// import '../models/products.dart';

class UiPhoneController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController controlname;
  late TextEditingController controlfname;
  late TextEditingController controllname;
  late TextEditingController controlcode;
  late TextEditingController controlcodemelli;
  late TextEditingController controlemail;
  late TextEditingController controlostan;
  late TextEditingController controlcity;
  late TextEditingController controlcodeposti;
  late TextEditingController controlphone;
  late TextEditingController controlmoaref;
  late TextEditingController controlnagsh;
  late TextEditingController registerController;
  var phone = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  var fname = ''.obs;
  var lname = ''.obs;
  var code = ''.obs;
  var codemelli = ''.obs;
  var email = ''.obs;
  var ostan = ''.obs;
  RxInt ostanid = 0.obs;
  var city = ''.obs;
  RxInt cityid = 0.obs;
  var codeposti = ''.obs;
  var phone1 = ''.obs;
  var moaref = ''.obs;
  var nagsh = ''.obs;
  var register = ''.obs;
  bool validationCode = false;

  @override
  void onInit() {
    super.onInit();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    controlname = TextEditingController();
    controlfname = TextEditingController();
    controllname = TextEditingController();
    controlcode = TextEditingController();
    controlcodemelli = TextEditingController();
    controlemail = TextEditingController();
    controlostan = TextEditingController();
    controlcity = TextEditingController();
    controlcodeposti = TextEditingController();
    controlphone = TextEditingController();
    controlmoaref = TextEditingController();
    controlnagsh = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    phoneController.dispose();
  }

  String? validatePhone(String value) {
    value.isValidIranianMobileNumber().toString();
    // return null;
  }

  void checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (isValid) {
      // return;
      Get.to(
        GetSmsCode(
          onChanged: (value) {},
          timeout: 0,
        ),
        // fullscreenDialog: true,
        // transition: Transition.zoom,
        // duration: Duration(milliseconds: 2000),
      );
    }
    loginFormKey.currentState!.save();
  }
}

class UiCartController extends GetxController {
  final _products = {}.obs;
  // var map1 = [].obs;
  // late Map<String, dynamic> map;
  // late final Map product;

  AddProduct(product) {
    // print(product);
    if (_products.containsKey(product)) {
      _products[product] += 1;
      // Get.snackbar(
      //   "محصول اضافه شد",
      //   "شما تعداد ${product.title} را یک واحد افزایش دادید",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 2),
      // );
    } else {
      _products[product] = 1;
      Get.snackbar(
        "محصول به سبد خریداضافه شد",
        "",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(milliseconds: 1000),
      );
    }
  }

  // addToCArt(product) {
  //   if (_products.containsKey(product)) {
  //     _products[product] += 1;
  //     // Get.snackbar(
  //     //   "محصول اضافه شد",
  //     //   "شما تعداد ${product.title} را یک واحد افزایش دادید",
  //     //   snackPosition: SnackPosition.BOTTOM,
  //     //   duration: Duration(seconds: 2),
  //     // );
  //   } else {
  //     _products[product] = 1;
  //     Get.snackbar(
  //       "محصول به سبد خریداضافه شد",
  //       "",
  //       snackPosition: SnackPosition.BOTTOM,
  //       duration: Duration(milliseconds: 1000),
  //     );
  //   }
  // }

  removeCart(product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      _products.removeWhere(
          (key, value) => key['product_id'] == product['product_id']);
      // _products.removeWhere((key, value) => key == product);
      // _products.remove(product);
      // print(_products);

    } else {
      _products[product] -= 1;

      // Get.snackbar(
      //   "محصول کم شد",
      //   "شما تعداد ${product.title} را یک واحد کاهش دادید",
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: Duration(seconds: 2),
      // );
    }
  }
  // removeCart(Map product) {
  //   if (_products.containsKey(product) && _products[product] == 1) {
  //     // ignore: unrelated_type_equality_checks
  //     map.removeWhere((key, value) => key == product);
  //     _products.removeWhere((key, value) => key == product);
  //   } else {
  //     _products[product] -= 1;
  //     // Get.snackbar(
  //     //   "محصول کم شد",
  //     //   "شما تعداد ${product.title} را یک واحد کاهش دادید",
  //     //   snackPosition: SnackPosition.BOTTOM,
  //     //   duration: Duration(seconds: 2),
  //     // );
  //   }
  // }

  get products => _products;

  get productSubtotal => _products.entries
      .map((product) => product.key['Price'] * product.value)
      .toList();

  get total => _products.entries
      .map((product) => product.key['product_price'] * product.value)
      .toList()
      .reduce((value, element) => value + element)
      .toStringAsFixed(0);
}

class UiSearchController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController searchController;
  var search = ''.obs;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    searchController.dispose();
  }
}

class UiPreviewData extends GetxController {
  var showinfo = [];
  var name = ''.obs;
  var code = ''.obs;
  var email = ''.obs;
  var ostan = ''.obs;
  var city = ''.obs;
  var codeposti = ''.obs;
  var phone = ''.obs;
  var moaref = ''.obs;
  var nagsh = ''.obs;
  var nagsh2 = ''.obs;
  var nagsh3 = ''.obs;
  //  var nagsh = [].obs;
  //  List <String>nagsh = [];
}

class UiShowInfo extends GetxController {
  var data = [].obs;
  var status1 = [].obs;
  var userid = ''.obs;
  var pass = ''.obs;
  var nagsh = ''.obs;
  var fullname = ''.obs;
  var fname = ''.obs;
  var lname = ''.obs;
  var codemelli = ''.obs;
  var email = ''.obs;
  var ostan = ''.obs;
  var city = ''.obs;
  var codeposti = ''.obs;
  var phone = ''.obs;
  var rank = ''.obs;
  var codemoaref = ''.obs;
  var lat = ''.obs;
  var long = ''.obs;
  var status = ''.obs;
  var flag = ''.obs;
  var flag1 = ''.obs;
  var date = ''.obs;
  var model = ''.obs;
  var count = ''.obs;
  RxInt status2 = 0.obs;
}

class UiAllInfo extends GetxController {
  var data = [].obs;
  var phone = ''.obs;
}

class UiSearching extends GetxController {
  var valuefirst = ''.obs;
  var valuesecound = ''.obs;
  var valuetree = ''.obs;
  var valuefour = ''.obs;
  var valuefive = ''.obs;
  var valuesex = ''.obs;
  var valueseven = ''.obs;
  var valueeight = ''.obs;
  var valuenine = ''.obs;
  var valueT = ''.obs;
  var isSwitched = ''.obs;
  var isSwitched_1 = ''.obs;
  var isSwitched_2 = ''.obs;
  //  var nagsh = [].obs;
  //  List <String>nagsh = [];
}

class UiRegister extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController registerController;
  var phone = ''.obs;
}

class UiGetLocation extends GetxController {
  // var lat = ''.obs;
  // var long = ''.obs;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
}

class UiCheckPhone extends GetxController {
  var phonedata = [].obs;
}

class UiFlag extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var flag = [].obs;
  var strflag = ''.obs;
}

class UiDetalilsProduct extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  var detail = ''.obs;
  var detail1 = [].obs;
  late Map<String, dynamic> map;
}

class UiAddToCart extends GetxController {
  RxInt product_id = 0.obs;
  RxInt id = 0.obs;
  var image = ''.obs;
  var name = ''.obs;
  var price = ''.obs;
  RxInt count = 0.obs;
  var data = ''.obs;
  var flag = ''.obs;
  RxDouble totaldarsad = 0.0.obs;
  var totaldarsad1 = {}.obs;
  var code = ''.obs;
  var code1 = ''.obs;
  var count1 = ''.obs;
  var name1 = ''.obs;
  var products = [].obs;
}

class UiLog extends GetxController {
  var id = ''.obs;
  var brand = ''.obs;
  var model = ''.obs;
  var fingerprint = ''.obs;
}

class UiTimerUser extends GetxController {
  // var timer1 = ''.obs;
  var timer2 = ''.obs;
  var timer4 = ''.obs;
  RxInt timer3 = 0.obs;
  RxInt timer1 = 0.obs;
  var timer5 = ''.obs;
  RxInt timer6 = 0.obs;
}

class UiStatemadrak extends GetxController {
  var state = [].obs;
  RxInt state1 = 0.obs;
}

class UiSliderimage extends GetxController {
  var image1 = ''.obs;
  var image2 = ''.obs;
  var image3 = ''.obs;
}

class UiReadCart extends GetxController {
  var product = [].obs;
  RxInt total = 0.obs;
  RxInt total1 = 0.obs;
  var total2 = ''.obs;
}

class UiImageCategory extends GetxController {
  var image = [].obs;
  var image_ab = ''.obs;
  var image_abmiveh = ''.obs;
  var image_dogh = ''.obs;
  var image_mashaeir = ''.obs;
  var image_nooshabeh = ''.obs;
  var image_milkflavoured = ''.obs;
  var image_milksade = ''.obs;
  var image_abmivehTashrifati = ''.obs;
  var image_abmivehgazdar = ''.obs;
  var image_header = ''.obs;
}

class UiGetfingerprint1 extends GetxController {
  var valuefirst = [].obs;
  var toggle = ''.obs;
  var nagsh = ''.obs;
  var fullname = ''.obs;
}

class UiShowInfo3 extends GetxController {
  var state1 = [].obs;
}

class UiPass extends GetxController {
  var valuepass = [].obs;
  var pass1 = ''.obs;
}

class UiDuration1 extends GetxController {
  var du1 = [].obs;
  RxInt du = 0.obs;
  RxInt du2 = 0.obs;
}

class UiRegisterReq extends GetxController {
  RxInt registerreqid = 0.obs;
}

class UiResiveCodeFrm extends GetxController {
  var code = ''.obs;
}

class UiTimeStep extends GetxController {
  RxInt timestep = 0.obs;
}

class UiInformationStore extends GetxController {
  late TextEditingController namestorecontroller;
  late TextEditingController addressstorecontroller;
  late TextEditingController phonestorecontroller;
  var namestore = ''.obs;
  var addressstore = ''.obs;
  var phonestore = ''.obs;

  @override
  void onInit() {
    super.onInit();
    namestorecontroller = TextEditingController();
    addressstorecontroller = TextEditingController();
    phonestorecontroller = TextEditingController();
  }
}

class UiDl extends GetxController {
  RxInt DlId = 0.obs;
  var Company = ''.obs;
  RxInt CompanyRef = 0.obs;
  var PhoneNumber = ''.obs;
  var FName = ''.obs;
  var LName = ''.obs;
  var FullName = ''.obs;
  var NastinalCode = ''.obs;
  var Email = ''.obs;
  var DlCode = ''.obs;
  var Role = ''.obs;
  var Ostan = ''.obs;
  var City = ''.obs;
  int DlState = 0;
  RxInt PostalCode = 0.obs;
  late RxBool del;
  late RxBool view;
  RxInt RegisterMemberLevelId = 0.obs;
  RxInt UserId = 0.obs;
  var UserName = ''.obs;
  var RegisterLevelCode = ''.obs;
  var RegisterLevelTitle = ''.obs;
  //  isActive = true as RxBool;
  late bool isActive;
  var Avatar = ''.obs;
}

class UiConst extends GetxController {
  RxInt ConstId = 0.obs;
  var ConstModelCode = ''.obs;
  var ConstModelTitle = ''.obs;
  var ConstTitle = ''.obs;
  var ConstDesc = ''.obs;
}

class UiCounter extends GetxController {
  RxInt counter = 0.obs;
}

class UiOstanInfo extends GetxController {
  var ostan = ''.obs;
  RxInt ostanid = 0.obs;
  var city = ''.obs;
  RxInt cityid = 0.obs;
  var models = [].obs;
}

class UiCityInfo extends GetxController {
  var city = ''.obs;
  RxInt cityid = 0.obs;
  var models = [].obs;
  List<Widget> data = [Text('')];
}

class UiGender extends GetxController {
  var LName = ''.obs;
  var FName = ''.obs;
  var Email = ''.obs;
  var Ostan = ''.obs;
  var City = ''.obs;
  RxInt codeMelli = 0.obs;
}

class UiUserInfoDto extends GetxController {
  var FName = ''.obs;
  var LName = ''.obs;
  var Email = ''.obs;
  var OstanName = ''.obs;
  var CityName = ''.obs;
  RxInt codeMelli = 0.obs;
  RxInt PostalCode = 0.obs;
  RxInt OstanRef = 0.obs;
  RxInt CityRef = 0.obs;
}

class UiControlClickedSmsCode extends GetxController {
  RxInt controlSms = 0.obs;
}

class UserInfo extends GetxController {
  RxInt UserId = 0.obs;
  RxInt RoleId = 0.obs;
  RxInt DlRef = 0.obs;
  var RoleTitle = ''.obs;
  var RoleTitleEn = ''.obs;
  var UserName = ''.obs;
  RxInt visitor = 0.obs;
  RxInt sellsCenter = 0.obs;
  RxInt userGroups = 0.obs;
}

class TestApi extends GetxController {
  var token = ''.obs;
}

class ImageDetaile extends GetxController {
  List<SliderInfo> imagedetaile = [];
}

class UiAddressIp {
  // ignore: non_constant_identifier_names
  String Get_url(String code) {
    // String url = "http://185.135.229.96:3000/";
    String url = "http://192.168.1.173:3000/";
    // String url = "http://185.135.229.96:805/AlisApi/api/v1";
    switch (code) {
      case "":
        url += "";
        break;
      case "showinfo":
        url += "showinfo";
        break;
      case "select":
        url += "select";
        break;
      case "userinfo":
        url += "userinfo";
        break;
      case "insertDL":
        url += "insertDL";
        break;
      case "flag":
        url += "flag";
        break;
      case "insertCodeMoaref":
        url += "insertCodeMoaref";
        break;
      case "setlocation":
        url += "setlocation";
        break;
      case "insert":
        url += "insert";
        break;
      case "checkvalue":
        url += "checkvalue";
        break;
      case "madarek":
        url += "madarek";
        break;
      case "nagsh_1":
        url += "nagsh_1";
        break;
      case "nagsh":
        url += "nagsh";
        break;
      case "milk":
        url += "milk";
        break;
      case "milksade":
        url += "milksade";
        break;
      case "dogh":
        url += "dogh";
        break;
      case "products":
        url += "products";
        break;
      case "takhfif":
        url += "takhfif";
        break;
      case "status":
        url += "status";
        break;
      case "allInfoUsers":
        url += "allInfoUsers";
        break;
      case "getstatus":
        url += "getstatus";
        break;
      case "log":
        url += "log";
        break;
      case "testlocal":
        url += "testlocal";
        break;
      case "likeproduct":
        url += "likeproduct";
        break;
      case "abgaz":
        url += "abgaz";
        break;
      case "ab":
        url += "ab";
        break;
      case "abTashrifati":
        url += "abTashrifati";
        break;
      case "nooshabeh":
        url += "nooshabeh";
        break;
      case "mashaeir":
        url += "mashaeir";
        break;
      case "abmiveh":
        url += "abmiveh";
        break;
      case "step":
        url += "step";
        break;
      case "getmadarek":
        url += "getmadarek";
        break;
      case "slider":
        url += "slider";
        break;
      case "cart":
        url += "cart";
        break;
      case "checkvalue_fingerprint":
        url += "checkvalue_fingerprint";
        break;
      case "toggle_fingerprint":
        url += "toggle_fingerprint";
        break;
      case "imagecategory":
        url += "imagecategory";
        break;
      case "selectcart":
        url += "selectcart";
        break;
      case "updateProduct":
        url += "updateProduct";
        break;
      case "readcart":
        url += "readcart";
        break;
      case "updateCount":
        url += "updateCount";
        break;
      case "phoneuser":
        url += "phoneuser";
        break;
      case "poststatus":
        url += "poststatus";
        break;
      case "addressuser":
        url += "addressuser";
        break;
      case "insertrole":
        url += "insertrole";
        break;
      case "checkmadarek":
        url += "checkmadarek";
        break;
      case "getfingerprint":
        url += "getfingerprint";
        break;
      case "newpassword":
        url += "newpassword";
        break;
      case "passjadid":
        url += "passjadid";
        break;
      case "RegisterReq":
        url += "RegisterReq";
        break;
      case "RegisterSmsCode":
        url += "RegisterSmsCode";
        break;
      case "RegisterGetSmsTime":
        url += "RegisterGetSmsTime";
        break;
      case "deleteproduct":
        url += "deleteproduct";
        break;
      case "GetEparchy":
        url += "GetEparchy";
        break;
      case "GetCity":
        url += "GetCity";
        break;
      case "Eparchy":
        url += "/Const/1";
        break;
      case "City":
        url += "/Const/City/1";
        break;
      default:
        break;
    }
    return url;
  }
}

class Club extends GetxController {
  RxInt value = 0.obs;
  late Uint8List image;
  late Uint8List imageLevel;
  RxInt score = 0.obs;
}
