// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
// import 'package:boxicons/boxicons.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:carousel_pro/carousel_pro.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:ez/models/FoodCategoryModel.dart';
// import 'package:ez/models/MehndiCategoryModel.dart';
// import 'package:ez/models/OfferBannerModel.dart';
// // import 'package:ez/models/ride_calculation_model.dart';
// // import 'package:ez/screens/RideBooking/finding_ride_screen.dart';
// import 'package:ez/screens/view/models/DestinationModel.dart';
// import 'package:ez/screens/view/models/GetMainCatModel.dart';
// import 'package:ez/screens/view/models/allKey_modal.dart';
// import 'package:ez/screens/view/models/allProduct_modal.dart';
// import 'package:ez/screens/view/models/bannerModal.dart';
// import 'package:ez/screens/view/models/categories_model.dart';
// import 'package:ez/screens/view/models/getCart_modal.dart';
// import 'package:ez/screens/view/models/getServiceWishList_modal.dart';
// import 'package:ez/screens/view/models/getWishList_modal.dart';
// import 'package:ez/screens/view/newUI/MyRequestPage.dart';
// import 'package:ez/screens/view/newUI/MyWallet.dart';
// import 'package:ez/screens/view/newUI/notificationScreen.dart';
// import 'package:ez/screens/view/newUI/privacy_policy.dart';
// import 'package:ez/screens/view/newUI/searchProduct.dart';
// import 'package:ez/screens/view/newUI/sub_category.dart';
// import 'package:ez/screens/view/newUI/terms_condition.dart';
// import 'package:ez/screens/view/newUI/welcome2.dart';
// import 'package:ez/screens/view/newUI/wishList.dart';
// // import 'package:fancy_drawer/fancy_drawer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ez/constant/global.dart';
// import 'package:ez/constant/sizeconfig.dart';
// import 'package:ez/screens/view/newUI/detail.dart';
// import 'package:ez/screens/view/models/catModel.dart';
// import 'package:ez/screens/view/newUI/viewCategory.dart';
// import 'package:flutter/services.dart';
// // import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:place_picker/entities/location_result.dart';
// // import 'package:place_picker/entities/location_result.dart';
// // import 'package:place_picker/widgets/place_picker.dart';
// // import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
//
// import 'package:ez/share_preference/preferencesKey.dart';
// import 'package:sliding_switch/sliding_switch.dart';
// import 'package:toggle_switch/toggle_switch.dart';
//
// import '../../../models/HandyManModel.dart';
// import '../Ride/finding_ride_screen.dart';
// import '../Ride/ride_calculation_model.dart';
// import '../models/BackBannerModel.dart';
// import '../models/getUserModel.dart';
// import 'Chat_Screen.dart';
// import 'GroceryDetails.dart';
// import 'SendPackage.dart';
// import 'faq_screen.dart';
// import 'google_sign_in.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _DiscoverState createState() => _DiscoverState();
// }
//
// var homelat;
// var homeLong;
//
// class _DiscoverState extends State<HomeScreen> with SingleTickerProviderStateMixin {
//   bool _value = false;
//   List<bool> isSelected = List.generate(2, (index) => false);
//   var orientation;
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//   bool isLoading = false;
//   CatModal? sortingModel;
//   BannerModal? bannerModal;
//   OfferBannerModel? offerBannerModel;
//   HandyManModel? handyManModel;
//   MehndiCategoryModel? mehndiCategoryModel;
//   FoodCategoryModel? foodCategoryModel;
//   AllCateModel? collectionModal;
//   // FancyDrawerController? _controller;
//   AllProductModal? allProduct;
//   GetCartModal? getCartModal;
//   GetWishListModal? getWishListModal;
//   Position? currentLocation;
//   GetUserModel? model;
//   final Geolocator geolocator = Geolocator();
//   String? _currentAddress;
//
//   int currentindex=0;
//   double pickLat = 0;
//   double pickLong = 0;
//   double dropLat = 0;
//   double dropLong = 0;
//   var status;
//
//
//
//   @override
//   void initState() {
//
//
//    getUserCurrentLocation();
//    _getAddressFromLatLng();
//    getUserDataFromPrefs();
//    getDestination();
//    calculateRidePrice();
//     // _controller = FancyDrawerController(
//     //     vsync: this, duration: Duration(milliseconds: 250))
//     //   ..addListener(() {
//     //     setState(() {});
//     //   });
//    markers.add(Marker( //add marker on google map
//      markerId: MarkerId(showLocation.toString()),
//      position: showLocation, //position of marker
//      infoWindow: InfoWindow( //popup info
//        title: 'My Custom Title ',
//        snippet: 'My Custom Subtitle',
//      ),
//      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
//    ));
//     super.initState();
//   }
//
//   GoogleMapController? mapController; //contrller for Google map
//   Set<Marker> markers = Set(); //markers for google map
//   LatLng showLocation = LatLng(27.7089427, 85.3086209);
//   //location to show in map
//
//   TextEditingController addressC = TextEditingController();
//   TextEditingController cityC = TextEditingController();
//   TextEditingController stateC = TextEditingController();
//   TextEditingController countryC = TextEditingController();
//   TextEditingController pincodeC = TextEditingController();
//   TextEditingController pickUpController = TextEditingController();
//   TextEditingController dropController = TextEditingController();
//   double lat = 0.0;
//   double long = 0.0;
//
//   Future getUserCurrentLocation() async {
//     print("Home latttt and longg ${homelat} ${homeLong}");
//
//     var status = await Permission.location.request();
//     if(status.isDenied) {
//       Fluttertoast.showToast(msg: "Permision is requiresd");
//     }else if(status.isGranted){
//       await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
//         if (mounted)
//           setState(() {
//             currentLocation = position;
//             homelat = currentLocation?.latitude;
//             homeLong = currentLocation?.longitude;
//           });
//       });
//       print("LOCATION===" +currentLocation.toString());
//     } else if(status.isPermanentlyDenied) {
//       openAppSettings();
//     }
//   }
//   _getAddressFromLatLng() async {
//    await getUserCurrentLocation().then((_) async {
//       try {
//         print("Addressss function");
//         List<Placemark> p = await placemarkFromCoordinates(currentLocation!.latitude, currentLocation!.longitude);
//         Placemark place = p[0];
//         setState(() {
//           _currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
//
//           //"${place.name}, ${place.locality},${place.administrativeArea},${place.country}";
//           print("current addresssss nowwwww${_currentAddress}");
//         });
//       } catch (e) {
//         print('errorrrrrrr ${e}');
//       }
//     });
//   }
//
//   getUserDataFromPrefs() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userDataStr = preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
//     // Map<String, dynamic> userData = json.decode(userDataStr!);
//     // print(userData);
//     // setState(() {
//     //   userID = userData['user_id'];
//     // });
//     _getAllKey();
//     _getBanners();
//     _backBanner();
//     _getMainCat();
//     _getCategories();
//     _getMehndiCat();
//     _getHandyManCat();
//     _getOfferBanners();
//     _getCollection();
//      sortingApiCall();
//
//      Future.delayed(Duration(seconds: 5),(){
//        // _getAllProduct();
//      });
//
//     _getCart();
//     _getWishList();
//     getUserDataApicall();
//     _getServiceWishList();
//   }
//
//   _getAllKey() async {
//     AllKeyModal allKeyModal;
//     var uri = Uri.parse('${baseUrl()}/general_setting');
//     var request = new http.MultipartRequest("GET", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     request.headers.addAll(headers);
//     // request.fields['vendor_id'] = userID;
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//
//     if (mounted) {
//       setState(() {
//         allKeyModal = AllKeyModal.fromJson(userData);
//         if (allKeyModal != null) {
//           stripSecret = allKeyModal.setting!.sSecretKey!;
//           stripPublic = allKeyModal.setting!.sPublicKey!;
//           rozSecret = allKeyModal.setting!.rSecretKey!;
//           rozPublic = allKeyModal.setting!.rPublicKey!;
//         }
//       });
//     }
//     print(responseData);
//   }
//
//   int _value1 = 1;
//
//   sortingApiCall() async {
//     // if (mounted)
//     //   setState(() {
//     //     isLoading = true;
//     //   });
//     print("ssdsds ${baseUrl()}/get_all_cat_nvip_sorting");
//     try {
//       Map<String, String> headers = {
//         'content-type': 'application/x-www-form-urlencoded',
//       };
//       final response = await client.post(
//         Uri.parse("${baseUrl()}/get_all_cat_nvip_sorting"),
//         headers: headers,
//       );
//       var dic = json.decode(response.body);
//       Map<String, dynamic> userMap = jsonDecode(response.body);
//       sortingModel = CatModal.fromJson(userMap);
//       print("Sorting>>>>>>");
//       print(dic);
//       if (mounted)
//         setState(() {
//           isLoading = false;
//         });
//     } on Exception {
//       if (mounted)
//         setState(() {
//           isLoading = false;
//         });
//       Fluttertoast.showToast(msg: "No Internet connection");
//       // Toast.show("No Internet connection", context,
//       //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
//       throw Exception('No Internet connection');
//     }
//   }
//
//   // _getBanners() async {
//   //   var uri = Uri.parse('${baseUrl()}get_all_banners');
//   //   var request = new http.MultipartRequest("GET", uri);
//   //   Map<String, String> headers = {
//   //     "Accept": "application/json",
//   //   };
//   //   request.headers.addAll(headers);
//   //   // request.fields['vendor_id'] = userID;
//   //   var response = await request.send();
//   //   print(response.statusCode);
//   //   String responseData = await response.stream.transform(utf8.decoder).join();
//   //   var userData = json.decode(responseData);
//   //   if (mounted) {
//   //     setState(() {
//   //       bannerModal = BannerModal.fromJson(userData);
//   //     });
//   //   }
//   //   print(responseData);
//   // }
//
//   BackBannerModel? backBannerModel;
//   _backBanner() async {
//     var headers = {
//       'Cookie': 'ci_session=76c877581e6065a833bd95288c5d58dc7afba115'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_banner_back_img'));
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = BackBannerModel.fromJson(json.decode(finalResponse));
//       print("Bannersssssssss$jsonResponse");
//       setState(() {
//         backBannerModel = BackBannerModel.fromJson(json.decode(finalResponse));
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   GetMainCatModel? getMainCatModel;
//
//   _getMainCat() async{
//     var headers = {
//       'Cookie': 'ci_session=18c4e244ae8774010ceca2feffdb543713ce5b35'
//     };
//     var request = http.MultipartRequest('GET', Uri.parse('https://sodindia.com/api/get_main_cat_img'));
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = GetMainCatModel.fromJson(json.decode(finalResponse));
//       print("Mehndi serivesss$jsonResponse");
//       setState(() {
//         getMainCatModel = GetMainCatModel.fromJson(json.decode(finalResponse));
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   _getBanners() async{
//     print("Banners Api working");
//     var headers = {
//       'Cookie': 'ci_session=22a2e1e4bee7fd081455779611c9b60a863af0a8'
//     };
//     var request = http.MultipartRequest('GET', Uri.parse('https://sodindia.com/api/get_all_banners'));
//     request.fields.addAll({
//       'type_id': '0'
//     });
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = BannerModal.fromJson(json.decode(finalResponse));
//       print("Bannersssssssss$jsonResponse");
//       setState(() {
//         bannerModal = BannerModal.fromJson(json.decode(finalResponse));
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//   }
//
//
//    _getOfferBanners() async{
//     print("offer Bannersss");
//      var headers = {
//        'Cookie': 'ci_session=64cc5c33c3d0410c422d2132427afd788cee0e77'
//      };
//      var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_offer_banners'));
//
//      request.headers.addAll(headers);
//      http.StreamedResponse response = await request.send();
//      if (response.statusCode == 200) {
//        var finalResponse = await response.stream.bytesToString();
//        final jsonResponse = OfferBannerModel.fromJson(json.decode(finalResponse));
//        print("Offer Bannersss$jsonResponse");
//        setState(() {
//          offerBannerModel = OfferBannerModel.fromJson(json.decode(finalResponse));
//        });
//      }
//      else {
//        print(response.reasonPhrase);
//      }
//    }
//
//    _getMehndiCat() async{
//     print("Mehndi details Api");
//      var headers = {
//        'Cookie': 'ci_session=bc683ce5943cc87d6c193ab40ea1077028ba3ca9'
//      };
//      var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_mehndi_services'));
//      request.headers.addAll(headers);
//      http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResponse = await response.stream.bytesToString();
//       final jsonResponse = MehndiCategoryModel.fromJson(json.decode(finalResponse));
//       print("Mehndi serivesss$jsonResponse");
//       setState(() {
//         mehndiCategoryModel = MehndiCategoryModel.fromJson(json.decode(finalResponse));
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//    }
//
//
//    _getHandyManCat() async{
//     print("Handy Man Api");
//      var headers = {
//        'Cookie': 'ci_session=9fc22c802baa4796f3d0a1be128441e4a043fca5'
//      };
//      var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_handy_services'));
//
//      request.headers.addAll(headers);
//      http.StreamedResponse response = await request.send();
//
//      if (response.statusCode == 200) {
//        var finalResponse = await response.stream.bytesToString();
//        final jsonResponse = HandyManModel.fromJson(json.decode(finalResponse));
//        print("Mehndi serivesss$jsonResponse");
//        setState(() {
//          handyManModel = HandyManModel.fromJson(json.decode(finalResponse));
//        });
//      }
//      else {
//        print(response.reasonPhrase);
//      }
//    }
//
//    _getCategories() async{
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//    await  getUserCurrentLocation();
//     print("Food,Grocery Api");
//      var headers = {
//        'Cookie': 'ci_session=19ae37817b8d23863ef9b269b178b64435cd91ea'
//      };
//      var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/grocery_services'));
//     print("Current KLat Lokn ${currentLocation?.latitude}");
//     print("GFhhghfgffg ${homeLong}",);
//     print("kjkhkjhjkhjhk ${homelat}");
//     request.fields.addAll({
//       'lat': '${currentLocation!.latitude}',
//       'long': '${currentLocation!.longitude}'
//     });
//     print("LatLonggggg ${request.fields}");
//     // request.fields.add({
//     //   'lat': '${currentLocation!.latitude}',
//     //   'long': '${currentLocation!.longitude}'
//     // });
//      print("Lat Long Parameter ${request.fields}");
//      request.headers.addAll(headers);
//      http.StreamedResponse response = await request.send();
//      if (response.statusCode == 200) {
//        var finalResponse = await response.stream.bytesToString();
//        final jsonResponse = FoodCategoryModel.fromJson(json.decode(finalResponse));
//        if(jsonResponse.status == 1){
//          print("Food Servicesss$jsonResponse");
//          String id = jsonResponse.product![0].id.toString();
//          preferences.setString("id", id);
//          print("Varient id is ${id.toString()}");
//          setState(() {
//            foodCategoryModel = FoodCategoryModel.fromJson(json.decode(finalResponse));
//          });
//        } else{
//          setState(() {
//          });
//        }
//      }
//      else {
//        print(response.reasonPhrase);
//      }
//    }
//
//
//   _getCollection() async {
//     var uri = Uri.parse('${baseUrl()}/get_all_cat');
//     var request = new http.MultipartRequest("GET", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     print(baseUrl.toString());
//
//     request.headers.addAll(headers);
//     // request.fields['vendor_id'] = userID;
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//
//     if (mounted) {
//       setState(() {
//         collectionModal = AllCateModel.fromJson(userData);
//       });
//     }
//     print(responseData);
//   }
//
//   _getAllProduct() async {
//     var uri = Uri.parse('${baseUrl()}/service_providers');
//     var request = new http.MultipartRequest("POST", uri);
//     request.fields.addAll({
//       'lat': '${currentLocation!.latitude}',
//       'long': '${currentLocation!.longitude}'
//     });
//     print("locationnnnnn ${request.fields}");
//     var response = await request.send();
//     print(request);
//     print(request.fields);
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//     if (mounted) {
//       setState(() {
//         allProduct = AllProductModal.fromJson(userData);
//       });
//     }
//
//     print(responseData);
//   }
//
//   _getCart() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     var uri = Uri.parse('${baseUrl()}/get_cart_items');
//     var request = new http.MultipartRequest("Post", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     request.headers.addAll(headers);
//     request.fields.addAll({'user_id': userID});
//
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//     if (mounted) {
//       setState(() {
//         getCartModal = GetCartModal.fromJson(userData);
//         isLoading = false;
//       });
//     }
//   }
//
//   _getWishList() async {
//     var uri = Uri.parse('${baseUrl()}/wishlist');
//     var request = new http.MultipartRequest("Post", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     request.headers.addAll(headers);
//     request.fields.addAll({'user_id': userID});
//
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//     if (mounted) {
//       setState(() {
//         likedProduct.clear();
//         getWishListModal = GetWishListModal.fromJson(userData);
//         for (var i = 0; i < getWishListModal!.wishlist!.length; i++) {
//           likedProduct.add(getWishListModal!.wishlist![i].proId.toString());
//         }
//       });
//     }
//   }
//
//   _getServiceWishList() async {
//     GetServiceWishListModal getServiceWishListModal;
//     var uri = Uri.parse('${baseUrl()}/service_wishlist');
//     var request = new http.MultipartRequest("Post", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     request.headers.addAll(headers);
//     request.fields.addAll({'user_id': userID});
//
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//     if (mounted) {
//       setState(() {
//         likedService.clear();
//         getServiceWishListModal = GetServiceWishListModal.fromJson(userData);
//         for (var i = 0; i < getServiceWishListModal.wishlist!.length; i++) {
//           likedService
//               .add(getServiceWishListModal.wishlist![i].resId.toString());
//         }
//       });
//     }
//   }
//
//   String? user_id;
//   getUserDataApicall() async {
//     setState(() {
//       isLoading = true;
//     });
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     user_id= preferences.getString("user_id");
//     try {
//       Map<String, String> headers = {
//         'content-type': 'application/x-www-form-urlencoded',
//       };
//       var map = new Map<String, dynamic>();
//       map['user_id'] = user_id ?? "";
//
//       final response = await client.post(Uri.parse("${baseUrl()}/user_data"),
//           headers: headers, body: map);
//         print("sddddddd ${map} sdsd ${baseUrl()}/user_data");
//       var dic = json.decode(response.body);
//       Map<String, dynamic> userMap = jsonDecode(response.body);
//       model = GetUserModel.fromJson(userMap);
//
//       userEmail = model!.user!.email!;
//       userMobile = model!.user!.mobile!;
//       userName = model!.user!.username!;
//       userPic = model!.user!.profilePic!;
//       print("User Data Model Nowwwwwww ${model}");
//       // _username.text = model!.user!.username!;
//       // _mobile.text = model!.user!.mobile!;
//       // _address.text = model!.user!.address!;
//       print("GetUserData>>>>>>");
//       print(dic);
//       setState(() {
//         isLoading = false;
//       });
//     } on Exception {
//       setState(() {
//         isLoading = false;
//       });
//       Fluttertoast.showToast(msg: "No Internet connection");
//       throw Exception('No Internet connection');
//     }
//   }
//
//   DestinationModel? destinationModel;
//   getDestination()async{
//     var uri = Uri.parse('${baseUrl()}/destinations');
//     var request = new http.MultipartRequest("Post", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     request.headers.addAll(headers);
//     request.fields.addAll({'user_id': userID});
//
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//     if (mounted) {
//       setState(() {
//         destinationList.clear();
//         destinationModel = DestinationModel.fromJson(userData);
//       });
//     }
//   }
//
//
//   Future<Null> refreshFunction()async{
//    await _getAddressFromLatLng();
//    await getUserCurrentLocation();
//    await getUserDataFromPrefs();
//    await getDestination();
//   }
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     /*return FancyDrawerWrapper(
//       backgroundColor: Colors.white,
//       controller: _controller,
//       drawerItems: <Widget>[
//         applogo(),
//         Container(height: 30),
//         InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => TabbarScreen()),
//             );
//           },
//           child: Row(
//             children: [
//               Icon(
//                 Icons.home,
//                 color: Colors.black45,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("Home",
//                   style: TextStyle(
//                       fontSize: SizeConfig.blockSizeHorizontal! * 5,
//                       fontFamily: 'OpenSans',
//                       fontStyle: FontStyle.italic)),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => StoreScreenNew(back: true)),
//             );
//           },
//           child: Row(
//             children: [
//               Icon(
//                 Icons.shopping_bag,
//                 color: Colors.black45,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("Services",
//                   style: TextStyle(
//                       fontSize: SizeConfig.blockSizeHorizontal! * 5,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'OpenSans',
//                       fontStyle: FontStyle.italic)),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => WishListScreen(back: true)),
//             );
//           },
//           child: Row(
//             children: [
//               Icon(
//                 Icons.favorite,
//                 color: Colors.black45,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("Wish List",
//                   style: TextStyle(
//                       fontSize: SizeConfig.blockSizeHorizontal! * 5,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'OpenSans',
//                       fontStyle: FontStyle.italic)),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => Profile(back: true)),
//             );
//           },
//           child: Row(
//             children: [
//               Icon(
//                 Icons.person,
//                 color: Colors.black45,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("Profile",
//                   style: TextStyle(
//                       fontSize: SizeConfig.blockSizeHorizontal! * 5,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'OpenSans',
//                       fontStyle: FontStyle.italic)),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => NotificationList()),
//             );
//           },
//           child: Row(
//             children: [
//               Icon(
//                 Icons.notifications,
//                 color: Colors.black45,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("Notification",
//                   style: TextStyle(
//                       fontSize: SizeConfig.blockSizeHorizontal! * 5,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'OpenSans',
//                       fontStyle: FontStyle.italic)),
//             ],
//           ),
//         ),
//         InkWell(
//           onTap: () {
//             Alert(
//               context: context,
//               title: "Log out",
//               desc: "Are you sure you want to log out?",
//               style: AlertStyle(
//                   isCloseButton: false,
//                   descStyle: TextStyle(fontFamily: "MuliRegular", fontSize: 15),
//                   titleStyle: TextStyle(fontFamily: "MuliRegular")),
//               buttons: [
//                 DialogButton(
//                   child: Text(
//                     "OK",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontFamily: "MuliRegular"),
//                   ),
//                   onPressed: () async {
//                     setState(() {
//                       userID = '';
//
//                       userEmail = '';
//                       userMobile = '';
//                       likedProduct = [];
//                       likedService = [];
//                     });
//                    // signOutGoogle();
//                     //signOutFacebook();
//                     preferences!
//                         .remove(SharedPreferencesKey.LOGGED_IN_USERRDATA)
//                         .then((_) {
//                       Navigator.of(context).pushAndRemoveUntil(
//                         MaterialPageRoute(
//                           builder: (context) => Welcome2(),
//                         ),
//                         (Route<dynamic> route) => false,
//                       );
//                     });
//
//                     Navigator.of(context, rootNavigator: true).pop();
//                   },
//                   color: Color.fromRGBO(0, 179, 134, 1.0),
//                 ),
//                 DialogButton(
//                   child: Text(
//                     "Cancel",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontFamily: "MuliRegular"),
//                   ),
//                   onPressed: () {
//                     Navigator.of(context, rootNavigator: true).pop();
//                   },
//                   gradient: LinearGradient(colors: [
//                     Color.fromRGBO(116, 116, 191, 1.0),
//                     Color.fromRGBO(52, 138, 199, 1.0)
//                   ]),
//                 ),
//               ],
//             ).show();
//           },
//           child: Row(
//             children: [
//               Icon(
//                 Icons.settings_power,
//                 color: Colors.red,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text("Logout",
//                   style: TextStyle(
//                       fontSize: SizeConfig.blockSizeHorizontal! * 5,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'OpenSans',
//                       fontStyle: FontStyle.italic)),
//             ],
//           ),
//         ),
//         Container(height: 100),
//       ],
//       child: */
//       return SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             systemOverlayStyle: SystemUiOverlayStyle(
//               statusBarIconBrightness: Brightness.light,
//             ),
//             backgroundColor: Colors.transparent,
//             // shape: RoundedRectangleBorder(
//             //     borderRadius: BorderRadius.only(
//             //         bottomLeft: Radius.circular(20),
//             //         bottomRight: Radius.circular(20)
//             //     )
//             // ),
//             elevation: 0,
//             // title:  _searchBar(),
//             // Text(appName,
//             //     style: TextStyle(
//             //         color: backgroundgrey,
//             //         fontSize: 22,
//             //         fontWeight: FontWeight.bold,
//             //         fontFamily: 'OpenSans',
//             //         fontStyle: FontStyle.italic)
//             // ),
//             centerTitle: false,
//             // actions: [
//             //   // CircleAvatar(
//             //   //   radius: 18,
//             //   //   backgroundColor: Colors.grey[100],
//             //   //   child: IconButton(
//             //   //     icon: Icon(
//             //   //       Icons.search,
//             //   //       color: appColorBlack,
//             //   //       size: 20,
//             //   //     ),
//             //   //     onPressed: () {
//             //   //       Navigator.push(
//             //   //         context,
//             //   //         MaterialPageRoute(builder: (context) => SearchProduct()),
//             //   //       );
//             //   //     },
//             //   //   ),
//             //   // ),
//             //   // Container(width: 10),
//             //   Container(
//             //     // height: 10,
//             //     width: 40,
//             //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: appColorOrange),
//             //     child: IconButton(
//             //       icon: Icon(
//             //         Icons.notifications,
//             //         color: appColorBlack,
//             //         size: 20,
//             //       ),
//             //       onPressed: () {
//             //         Navigator.push(
//             //           context,
//             //           MaterialPageRoute(builder: (context) => NotificationList()),
//             //         );
//             //       },
//             //     ),
//             //   ),
//             //   Container(width: 10),
//             // ],
//           ),
//           // drawer: getDrawer(),
//           body: RefreshIndicator(
//             onRefresh: refreshFunction,
//             child: SingleChildScrollView(
//               physics: AlwaysScrollableScrollPhysics(),
//               child: Column(
//                 children: <Widget>[
//                   Container(height: 5),
//                   serviceWidget1(),
//                   Container(height: 5),
//                   // Text("HAPPY YOU|HAPPY US", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.w800),),
//                   servicesWidget(),
//                   Container(height: 5),
//                   _searchBar(),
//                   Container(height: 5),
//                   allServices(context),
//                   // collectionWidget(),
//                   Container(height: 20),
//                   _banner(context),
//                   Container(height: 10),
//                   _offerBanners(context),
//                   Container(height: 10),
//                   _radioButton(context),
//                   Container(height: 7),
//                   _mapLocation(context),
//                   Container(height: 10),
//                   _locationField(context),
//                   InkWell(
//                     onTap: () async{
//                       distnce();
//                       if(pickLat != 0 && pickLong != 0 && dropLat != 0 && dropLong != 0) {
//                         await confirmRideDialog(context);
//                       }else{
//                         Fluttertoast.showToast(msg: "Please select pick and drop locations first!");
//                       }
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 15),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Container(
//                           height: 45,
//                           width: MediaQuery.of(context).size.width/2.5,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                             // borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
//                             color: Colors.black12,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 25),
//                                 child: Text("BOOK NOW", style: TextStyle(fontSize: 16, color: appColorGreen, fontWeight: FontWeight.w600)
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 7),
//                                 child: Container(
//                                   height: 45,
//                                   width: 45,
//                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(90), color: Colors.black),
//                                   child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // _CarouselSlider(),
//                   // Container(height: 10,),
//                   // Align(
//                   //   alignment: Alignment.centerLeft,
//                   //     child: Padding(
//                   //       padding: const EdgeInsets.only(left: 19),
//                   //       child: Text("All Popular Services", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700)),
//                   //     )
//                   // ),
//                   SizedBox(height: 9),
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 19),
//                         child: Row(
//                           children: [
//                           Image.asset("assets/images/food.png", color: backgroundblack,height: 35, width: 35),
//                           SizedBox(width: 5,),
//                           Text("FOOD SERVICES", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700)),
//                         ],
//                         ),
//                       ),
//                   ),
//                   _getCategory(context),
//                   SizedBox(height: 9),
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 19),
//                         child: Row(
//                           children: [
//                             Image.asset("assets/images/mehndi.png", color: backgroundblack,height: 35, width: 35),
//                             SizedBox(width: 5,),
//                             Text("MEHNDI", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700)),
//                           ],)
//                       )
//                   ),
//                   _getMehndiCategory(context),
//                   SizedBox(height: 9,),
//                   Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 19),
//                         child: Row(
//                           children: [
//                             Image.asset("assets/images/handyman.png", color: backgroundblack,height: 35, width: 35,),
//                             SizedBox(width: 5,),
//                             Text("HANDYMAN SERVICES", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700)),
//                           ],)
//                       )
//                   ),
//                   _getHandyManCategory(context),
//                   // Container(
//                   //   margin: EdgeInsets.symmetric(horizontal: 12),
//                   //   child: Column(
//                   //     crossAxisAlignment: CrossAxisAlignment.start,
//                   //     children: [
//                   //       Text("Destination",style: TextStyle(color: appColorBlack,fontSize: 18,fontWeight: FontWeight.w600),),
//                   //         SizedBox(height: 12,),
//                   //     destinationModel == null || destinationModel!.data!.isEmpty ?  Container(child: Center(child: Text("No destination to show"),),) : Container(
//                   //         height: 210,
//                   //         padding: EdgeInsets.symmetric(vertical: 8),
//                   //         color: backgroundgrey,
//                   //         width: MediaQuery.of(context).size.width,
//                   //         child: ListView.builder(
//                   //             itemCount: destinationModel!.data!.length,
//                   //             shrinkWrap: true,
//                   //             scrollDirection: Axis.horizontal,
//                   //             itemBuilder: (c,i){
//                   //           return InkWell(
//                   //             onTap: (){
//                   //               Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCategory(fromSeller: false,cid: destinationModel!.data![i].id,)));
//                   //               // Navigator.push(context, MaterialPageRoute(builder: (context) =>  ViewCategory(fromSeller: false, cid: destinationModel!.data![i].id,vid: ,)));
//                   //             },
//                   //             child: Container(
//                   //               width: 150,
//                   //               margin: EdgeInsets.only(right: 10),
//                   //               child: Card(
//                   //                 color: appColorWhite,
//                   //                 elevation: 1,
//                   //                 borderOnForeground: false,
//                   //                 child: Column(
//                   //                   crossAxisAlignment: CrossAxisAlignment.start,
//                   //                   children: [
//                   //                     Container(
//                   //                       height:100,
//                   //                       width: 150,
//                   //                       child: Image.network("${destinationModel!.data![i].image}",fit:BoxFit.fill,),
//                   //                     ),
//                   //                     Padding(
//                   //                       padding: EdgeInsets.symmetric(horizontal: 3),
//                   //                       child: Text("${destinationModel!.data![i].name}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 16),),
//                   //                     ),
//                   //                     SizedBox(height: 4,),
//                   //                     Padding(
//                   //                       padding: EdgeInsets.symmetric(horizontal: 3),
//                   //                       child: Text("${destinationModel!.data![i].description}",style: TextStyle(height:1,color: appColorBlack.withOpacity(0.5),fontSize: 13),maxLines: 2,overflow: TextOverflow.ellipsis,),
//                   //                     ),
//                   //                     SizedBox(height: 3,),
//                   //                     Divider(height: 1,),
//                   //                     SizedBox(height: 2,),
//                   //                     Padding(
//                   //                       padding:EdgeInsets.only(left: 3),
//                   //                       child: Row(
//                   //                         crossAxisAlignment: CrossAxisAlignment.start,
//                   //                         children: [
//                   //                           Text("View More",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.w600,fontSize: 13),),
//                   //                           SizedBox(width: 5,),
//                   //                           Icon(Icons.arrow_forward_rounded,color: backgroundblack,size: 20,),
//                   //                         ],
//                   //                       ),
//                   //                     ),
//                   //                   ],
//                   //                 ),
//                   //               ),
//                   //             ),
//                   //           );
//                   //         }),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   // Container(height: 20),
//                   // bestSellerWidget(),
//                   // Container(
//                   //   height: 10,
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//   }
//
//   getDrawer(){
//     print("checking user pic ${userPic}");
//     return Drawer(
//       // backgroundColor: appColorBlack,
//       child: ListView(
//         padding: EdgeInsets.all(0),
//         children: <Widget>[
//           DrawerHeader(
//             decoration: BoxDecoration(
//               color: appColorOrange,
//             ), //BoxDecoration
//             child: Row(
//               children: [
//                 SizedBox(height: 20),
//               userPic == null || userPic == "" ? CircleAvatar(
//                 backgroundColor: appColorWhite,
//                 radius: 40,
//                 child: Icon(Icons.person,),
//               ) : CircleAvatar(
//                   radius: 40,
//                   backgroundImage: NetworkImage(userPic),
//                 ),
//                 SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "$userName",
//                         style: TextStyle(fontSize: 18, color: backgroundblack),
//                       ),
//                       Text("$userEmail",
//                         style: TextStyle(color: backgroundblack),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ), //DrawerHeader
//           ListTile(
//             leading: Image.asset("assets/images/home.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text(' Home '),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => HomeScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/whats new.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text(' Booking'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
//                 MaterialPageRoute(builder: (context)=> ChatScreen()),
//               );
//             },
//           ),
//           // ListTile(
//           //   leading: const Icon(Icons.settings, color: backgroundblack,),
//           //   title: const Text('Whats New'),
//           //   onTap: () {
//           //     Navigator.push(
//           //       context,
//           //       // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
//           //       MaterialPageRoute(builder: (context)=> RequestService()),
//           //     );
//           //   },
//           // ),
//           ListTile(
//             leading: Image.asset("assets/images/wallet.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text('Wallet'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
//                 MaterialPageRoute(builder: (context)=> MyWallet()),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/whats new.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text('Whats New'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
//                 MaterialPageRoute(builder: (context)=> MyRequestPage()),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/event.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text('Events'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
//                 MaterialPageRoute(builder: (context)=> WishListScreen(back: true,)),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/about us.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text('About Us'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
//                 MaterialPageRoute(builder: (context)=> WishListScreen(back: true,)),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/refferal.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text('Refferal'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
//                 MaterialPageRoute(builder: (context)=> WishListScreen(back: true,)),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/emergency contact.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text('Emergancy Contact'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
//                 MaterialPageRoute(builder: (context)=> WishListScreen(back: true,)),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/faq.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text(' FAQ '),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FaqScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/privacy policy.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text(' Privacy Policy '),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/support.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text(' Support'),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => TermsConditionScreen()),
//               );
//             },
//           ),
//           ListTile(
//             leading: Image.asset("assets/images/claim.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text(' Claim '),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => FaqScreen()),
//               );
//             },
//           ),
//           /// Only for Testing
//           // ListTile(
//           //   leading: const Icon(Icons.list_alt, color: backgroundblack,),
//           //   title: const Text(' Testing '),
//           //   onTap: () {
//           //     Navigator.push(
//           //       context,
//           //       MaterialPageRoute(builder: (context) => HomePage()),
//           //     );
//           //   },
//           // ),
//           ListTile(
//             leading: Image.asset("assets/images/logout.png", color: backgroundblack, height: 30, width: 30,),
//             title: const Text('LogOut'),
//             onTap: () {
//                 // Alert(
//                 //   context: context,
//                 //   title: "Log out",
//                 //   desc: "Are you sure you want to log out?",
//                 //   style: AlertStyle(
//                 //       isCloseButton: false,
//                 //       descStyle: TextStyle(fontFamily: "MuliRegular", fontSize: 15),
//                 //       titleStyle: TextStyle(fontFamily: "MuliRegular")),
//                 //   buttons: [
//                 //     DialogButton(
//                 //       child: Text(
//                 //         "OK",
//                 //         style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontSize: 16,
//                 //             fontFamily: "MuliRegular"),
//                 //       ),
//                 //       onPressed: () async {
//                 //         setState(() {
//                 //           userID = '';
//                 //           userEmail = '';
//                 //           userMobile = '';
//                 //           likedProduct = [];
//                 //           likedService = [];
//                 //         });
//                 //         // signOutGoogle();
//                 //         //signOutFacebook();
//                 //         preferences!
//                 //             .remove(SharedPreferencesKey.LOGGED_IN_USERRDATA)
//                 //             .then((_) {
//                 //           Navigator.of(context).pushAndRemoveUntil(
//                 //             MaterialPageRoute(
//                 //               builder: (context) => Welcome2(),
//                 //             ),
//                 //                 (Route<dynamic> route) => false,
//                 //           );
//                 //         });
//                 //         Navigator.of(context, rootNavigator: true).pop();
//                 //       },
//                 //       color: backgroundblack,
//                 //       // color: Color.fromRGBO(0, 179, 134, 1.0),
//                 //     ),
//                 //     DialogButton(
//                 //       child: Text(
//                 //         "Cancel",
//                 //         style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontSize: 16,
//                 //             fontFamily: "MuliRegular"),
//                 //       ),
//                 //       onPressed: () {
//                 //         Navigator.of(context, rootNavigator: true).pop();
//                 //       },
//                 //       color: backgroundblack,
//                 //       // gradient: LinearGradient(colors: [
//                 //       //   Color.fromRGBO(116, 116, 191, 1.0),
//                 //       //   Color.fromRGBO(52, 138, 199, 1.0)
//                 //       // ]),
//                 //     ),
//                 //   ],
//                 // ).show();
//             },
//           ),
//           Divider(),
//           Text("Follow Us")
//         ],
//       ),
//     );
//   }
//   double totalDistance = 0;
//    distnce (){
//     totalDistance =  calculateDistance(pickLat, pickLong, dropLat, dropLong);
//   }
//
//   double calculateDistance(lat1, lon1, lat2, lon2) {
//     try {
//       var p = 0.017453292519943295;
//       var c = cos;
//       var a = 0.5 -
//           c((lat2 - lat1) * p) / 2 +
//           c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
//       return 12742 * asin(sqrt(a));
//     } on Exception catch (exception) {
//       return 0; // only executed if error is of type Exception
//     } catch (error) {
//       return 0; // executed for errors of all types other than Exception
//     }
//   }
//
//   RideCalculationModel? rideCalcData;
//    String? userId;
//
//   calculateRidePrice() async {
//     print("Api Working");
//     var headers = {
//       'Cookie': 'ci_session=d9be05064d0216a7432b621660dc26feb4d030ed'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/price_culculation_ride'));
//     request.fields.addAll({
//       'distance': '${calculateDistance(pickLat, pickLong, dropLat, dropLong).toString()}'
//     });
//     print("this is ride calculation param ${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       print("Working Nowwwww");
//       var finalResponse = await response.stream.bytesToString();
//        rideCalcData = RideCalculationModel.fromJson(jsonDecode(finalResponse));
//        print("this is ride calculation data ${rideCalcData!.subTotal.toString()}");
//     }
//     else {
//       setState(() {});
//       print(response.reasonPhrase);
//     }
//   }
//
//   confirmRideBook() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     userId = preferences.getString("user_id");
//     print("Api Working");
//     var headers = {
//       'Cookie': 'ci_session=d9be05064d0216a7432b621660dc26feb4d030ed'
//     };
//     var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/ride_booking'));
//     request.fields.addAll({
//       'user_id':'${userId.toString()}',
//       'transaction_type':'cash',
//       'paid_amount':'${rideCalcData!.finalTotal.toString()}',
//       'amount': '${rideCalcData!.subTotal.toString()}',
//       'pickup_location': pickUpController.text.toString(),
//       'drop_location':dropController.text.toString(),
//     'distance': '${calculateDistance(pickLat, pickLong, dropLat, dropLong).toString()}',
//       'latitude': '${pickLat.toString()}',
//       'longitude':'${pickLong.toString()}',
//       'drop_latitude':'${dropLat.toString()}',
//       'drop_longitude': '${dropLong.toString()}',
//       'gst_charge':'${rideCalcData!.gstCharge.toString()}',
//       'culculate_gst_amount':'${rideCalcData!.gst.toString()}',
//       'gst_type':'${rideCalcData!.gstType.toString()}',
//
//
//     });
//     print("this is ride booking param ---===>> ${request.fields}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       print("Working Nowwwww");
//       var finalResponse = await response.stream.bytesToString();
//      final jsonResponse = json.decode(finalResponse);
//      if(jsonResponse['status']){
//        Fluttertoast.showToast(msg: "${jsonResponse['message'].toString()}");
//        Navigator.push(context, MaterialPageRoute(builder: (context) => FindingRidePage(
//            LatLng(pickLat, pickLong),
//            LatLng(dropLat, dropLong),
//            pickUpController.text,
//            dropController.text,
//            "Cash",
//            "",
//            '${rideCalcData!.finalTotal.toString()}',
//            '${totalDistance.toStringAsFixed(2)}'
//        )));
//      }
//       // print("this is ride calculation data ${rideCalcData!.subTotal.toString()}");
//     }
//     else {
//       setState(() {});
//       print(response.reasonPhrase);
//     }
//   }
//
//   Future<void> confirmRideDialog(BuildContext context) async {
//     return await showDialog(
//         context: context,
//         builder: (context) {
//           bool isChecked = false;
//           return StatefulBuilder(builder: (context, setState) {
//             return AlertDialog(
//               insetPadding: EdgeInsets.zero,
//               content: Container(
//                 height: MediaQuery.of(context).size.height/2,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   child: Column(
//                     // mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 6.0),
//                             child: Container(
//                               height: 15,
//                               width: 15,
//                               decoration: BoxDecoration(
//                                 color: Colors.green,
//                                 shape: BoxShape.circle
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 6,),
//                           Container(
//                               width: MediaQuery.of(context).size.width - 70,
//                             child: Text("${pickUpController.text.toString()}",
//                             maxLines: 2,
//                             style: TextStyle(
//                             ),
//                             overflow: TextOverflow.ellipsis,),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 15,),
//                       Row(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                         // mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 6.0),
//                             child: Container(
//                               height: 15,
//                               width: 15,
//                               decoration: BoxDecoration(
//                                   color: Colors.red,
//                                   shape: BoxShape.circle
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 6,),
//                           Container(
//                             width: MediaQuery.of(context).size.width - 70,
//                             child: Text("${dropController.text.toString()}",
//                               maxLines: 2,
//                               style: TextStyle(
//                               ),
//                               overflow: TextOverflow.ellipsis),
//                           )
//                         ],
//                       ),
//                       Divider(),
//                       Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Distance : ", style: TextStyle(
//                             fontWeight: FontWeight.w600
//                           ),),
//                           Text('${totalDistance.toStringAsFixed(2)} km')
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 10.0, bottom: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("Price : ", style: TextStyle(
//                                 fontWeight: FontWeight.w600
//                             ),),
//                             Text('₹ ${rideCalcData!.subTotal.toString()}')
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only( bottom: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("GST Charge (${rideCalcData!.gstCharge.toString()}%) : ", style: TextStyle(
//                                 fontWeight: FontWeight.w600
//                             ),),
//                             Text('₹ ${rideCalcData!.gst.toString()}')
//                           ],
//                         ),
//                       ),
//                        Divider(),
//                       Padding(
//                         padding: const EdgeInsets.only( bottom: 10),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("Total : ", style: TextStyle(
//                                 fontWeight: FontWeight.w600
//                             ),),
//                             Text('₹ ${rideCalcData!.finalTotal.toString()}')
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 15.0, bottom: 15),
//                         child: InkWell(
//                           onTap: (){
//                             confirmRideBook();
//                           },
//                           child: Container(
//                             height: 43,
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),  color: appColorOrange),
//                             child:
//                             Center(
//                                 child: Text("Confirm", style: TextStyle(fontSize: 18, color: backgroundblack))
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Confirm Ride Request", style: TextStyle(
//                     color: backgroundblack, fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),),
//                   InkWell(
//                     onTap: (){
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: appColorOrange
//                       ),
//                       child: Icon(Icons.clear, color: backgroundblack, size: 14,),
//                     ),
//                   )
//                 ],
//               ),
//               // actions: <Widget>[
//               //   InkWell(
//               //     child: Text('OK   '),
//               //     onTap: () {
//               //       // if (_formKey.currentState.validate()) {
//               //         // Do something like updating SharedPreferences or User Settings etc.
//               //         Navigator.of(context).pop();
//               //       // }
//               //     },
//               //   ),
//               // ],
//             );
//           });
//         });
//   }
//
//   Widget applogo() {
//     return Column(
//       children: [
//         Image.asset(
//           'assets/images/logo.png',
//           height: 50,
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Text(appName,
//             style: TextStyle(
//                 color: appColorBlack,
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 fontFamily: 'OpenSans',
//                 fontStyle: FontStyle.italic)),
//         SizedBox(
//           height: 5,
//         ),
//         Text('Your Hygiene App',
//             style: TextStyle(
//               color: appColorBlack,
//               fontSize: 12,
//             )),
//       ],
//     );
//   }
//
//   _searchBar() {
//     return GestureDetector(
//       child: InkWell(
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => SearchProduct()));
//         },
//         child: Container(
//           height: 25,
//           width: MediaQuery.of(context).size.width/1.1,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(13),
//               border: Border.all(color: Colors.black),
//               color: Colors.white),
//           // padding: EdgeInsets.symmetric(vertical: 8),
//           // color: Theme.of(context).colorScheme.white,
//           child: Align(
//             alignment: Alignment.centerLeft,
//               child: Icon(Icons.search, color: appColorOrange,))
//           // ListTile(
//           //   dense: true,
//           //   // minLeadingWidth: 10,
//           //   leading: Icon(
//           //     Icons.search, color: appColorOrange,
//           //   ),
//             // trailing: Icon(Icons.cancel_outlined, color: Colors.black),
//             // title: Text("Search", style: TextStyle(fontSize: 16, color:backgroundblack)),
//           // ),
//         ),
//       ),
//     );
//   }
//
//   Widget serviceWidget1() {
//    return
//      Padding(
//        padding: const EdgeInsets.only(left: 15, right: 8),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: [
//        InkWell(
//          onTap: () {
//            scaffoldKey.currentState!.openDrawer();
//          },
//          child: Container(
//            decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(90)),
//            child: CircleAvatar(
//              radius: 20,
//              child: Icon(Icons.person, color: appColorOrange, size: 30),
//            ),
//          ),
//        ),
//          SizedBox(width: 15),
//          Image.asset("assets/images/sod.png", scale: 2.4),
//          SizedBox(width: 3),
//          // Center(
//          //   child: Text("SERVICE ON DEMAND",
//          //     style: TextStyle(fontSize: 17, color: backgroundblack, fontWeight: FontWeight.w700),
//          //   ),
//          // ),
//          IconButton(
//            icon: Icon(
//              Icons.notifications,
//              color: backgroundblack,
//              size: 20,
//            ),
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => NotificationList()),
//              );
//            },
//          ),
//          IconButton(onPressed: () {}, icon: Icon(Icons.wallet, color: backgroundblack,))
//        ],
//        ),
//      );
//   }
//
//   Widget allServices(BuildContext context) {
//     return
//       getMainCatModel == null ? Center(
//       child: Image.asset("assets/images/loader1.gif", scale: 1,),
//     ) :
//     Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Container(
//           height:70,
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10, left: 5),
//             child: ListView(
//               scrollDirection: Axis.horizontal,
//               children: <Widget>[
//                 Column(
//                   children: [
//                     // CircleAvatar(
//                     //     radius: 20,
//                     //     // backgroundColor: backgroundblack,
//                     //     backgroundImage: NetworkImage("${getMainCatModel!.data!.orderFood}")
//                     // ),
//                     Image.network("${getMainCatModel!.data!.orderFood}", scale: 30, color: Colors.grey),
//                     Text("Order Food", style: TextStyle(color: Colors.black)),
//                   ],
//                 ),
//                 // ClipRRect(
//                 // borderRadius: BorderRadius.circular(10),
//                 //  // radius: 40,
//                 // child: Image.network("${getMainCatModel!.data!.orderFood}", height: 20, width: 20, fit: BoxFit.fill,)
//                 // ),
//                 SizedBox(width: 20),
//                 Column(
//                   children: [
//                     // CircleAvatar(
//                     //     radius: 20,
//                     //     backgroundColor: backgroundblack,
//                     //     backgroundImage: NetworkImage("${getMainCatModel!.data!.bookRide}")
//                     // ),
//                     Image.network("${getMainCatModel!.data!.bookRide}", scale: 30, color: Colors.grey,),
//                     Text("Book Ride", style: TextStyle(color: Colors.black)),
//                   ],
//                 ),
//                 SizedBox(width: 20,),
//                 Column(children: [
//                   // CircleAvatar(
//                   //     radius: 20,
//                   //     backgroundColor: Colors.grey,
//                   //     backgroundImage: NetworkImage("${getMainCatModel!.data!.sendPackge}")
//                   // ),
//                   Image.network("${getMainCatModel!.data!.sendPackge}", scale: 30, color: Colors.grey,),
//                   Text("Send Package", style: TextStyle(color: Colors.black)),
//                 ],),
//                 SizedBox(width: 20,),
//                Column(
//                  children: [
//                    // CircleAvatar(
//                    //     radius: 20,
//                    //     backgroundColor: backgroundblack,
//                    //     backgroundImage: NetworkImage("${getMainCatModel!.data!.handyman}")
//                    // ),
//                    Image.network("${getMainCatModel!.data!.handyman}", scale: 30, color: Colors.grey,),
//                    Text("Handy Man", style: TextStyle(color: Colors.black)),
//                  ],
//                ),
//                 SizedBox(width: 20,),
//               Column(
//                 children: [
//                   // CircleAvatar(
//                   //     radius: 20,
//                   //     backgroundColor: backgroundblack,
//                   //     backgroundImage: NetworkImage("${getMainCatModel!.data!.mehndi}")
//                   // ),
//                   Image.network("${getMainCatModel!.data!.mehndi}", scale: 30, color: Colors.grey,),
//                   Text("Mehndi", style: TextStyle(color:Colors.black)),
//                 ],
//               ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//
//   Widget servicesWidget() {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.only(left: 95),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.white,
//                 // offset: Offset(0.0, 1.0), //(x,y)
//                 blurRadius: 0,
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.location_on,
//                 color: appColorOrange,
//                 size: 18,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Container(
//                   // width: MediaQuery.of(context).size.width/1.1,
//                   child: Text(
//                     _currentAddress != null
//                         ? _currentAddress!
//                         : "please wait..",overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.red,
//                         fontSize: 12
//                     ),
//                   ),
//                 ),
//               ),
//               // Container(
//               //   width: 5,
//               // ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget serviceWidget() {
//     return sortingModel == null
//         ? Center(
//             child: Image.asset("assets/images/loader1.gif", scale: 1,),
//           )
//         : sortingModel!.restaurants!.length > 0
//             ? ListView.builder(
//                 padding: EdgeInsets.only(
//                   bottom: 10,
//                   top: 10,
//                 ),
//                 itemCount: sortingModel!.restaurants!.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, int index,) {
//                   return InkWell(
//                     onTap: () {
//                       print("first here ${sortingModel!.restaurants![index].resId}");
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => DetailScreen(
//                                   resId: sortingModel!.restaurants![index].resId,
//                                 )),
//                       );
//                     },
//                     child: Padding(
//                       padding:  EdgeInsets.only(right: 10),
//                       child:  Padding(
//                         padding:  EdgeInsets.only(top: 30),
//                         child: Card(
//                           elevation: 5,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Container(
//                             width: 200,
//                             child: Column(
//                               crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                               // mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Container(
//                                     height: 110,
//                                      width: 200,
//                                   // child: Carousel(
//                                   //   images: sortingModel!.restaurants
//                                   //       ![index].logo!.map((it) {
//                                   //     return Container(
//                                   //         height: 110,
//                                   //          width: 170,
//                                   //       child: ClipRRect(
//                                   //         borderRadius: BorderRadius.only(
//                                   //             topLeft: Radius.circular(8),
//                                   //             topRight: Radius.circular(8)),
//                                   //         child: CachedNetworkImage(
//                                   //           imageUrl: it,
//                                   //           imageBuilder: (context, imageProvider) => Container(
//                                   //             decoration: BoxDecoration(
//                                   //               image: DecorationImage(
//                                   //                 image: imageProvider,
//                                   //                 fit: BoxFit.fill,
//                                   //               ),
//                                   //             ),
//                                   //           ),
//                                   //           placeholder: (context, url) => Center(
//                                   //             child: Container(
//                                   //               height: 110,
//                                   //               width: 100,
//                                   //               // margin: EdgeInsets.all(70.0),
//                                   //               child: CircularProgressIndicator(
//                                   //                 strokeWidth: 2.0,
//                                   //                 valueColor: new AlwaysStoppedAnimation<Color>(
//                                   //                     appColorGreen),
//                                   //               ),
//                                   //             ),
//                                   //           ),
//                                   //           errorWidget: (context, url, error) => Icon(Icons.error),
//                                   //           fit: BoxFit.cover,
//                                   //         ),
//                                   //       ),
//                                   //     );
//                                   //   }).toList(),
//                                   //   showIndicator: true,
//                                   //   dotBgColor: Colors.transparent,
//                                   //   borderRadius: false,
//                                   //   autoplay: false,
//                                   //   dotSize: 4.0,
//                                   //   dotSpacing: 15.0,
//                                   // ),
//                                 ),
//                                 // Container(
//                                 //   height: 100,
//                                 //    width: 170,
//                                 //   decoration: BoxDecoration(
//                                 //     color: Colors.black45,
//                                 //     borderRadius: BorderRadius.circular(10),
//                                 //   ),
//                                 //   child: ClipRRect(
//                                 //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                                 //     child: Image.network("${sortingModel!
//                                 //         .restaurants![index].logo![0] }",fit: BoxFit.fill,),
//                                 //   ),
//                                 // ),
//                                 Padding(
//                                   padding:  EdgeInsets.only(left: 5,top: 5,right: 5),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         width: MediaQuery.of(context).size.width/2.7,
//                                         child: Text(
//                                           sortingModel!.restaurants![index].resName![0].toUpperCase() + sortingModel!.restaurants![index].resName!.substring(1),
//                                           maxLines: 2,
//                                           style: TextStyle(
//                                               color: appColorBlack,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       Text(
//                                         "${sortingModel!.restaurants![index].cityName}",
//                                         maxLines: 1,
//                                         style: TextStyle(
//                                             color: appColorBlack,
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Container(height: 5),
//                                 Padding(
//                                   padding:  EdgeInsets.only(left: 5,right: 5,bottom: 5),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       // Container(
//                                       //   width: 130,
//                                       //   child: Text(
//                                       //     sortingModel!.restaurants![index].resDesc!,
//                                       //     maxLines: 1,
//                                       //     style: TextStyle(
//                                       //         color: appColorBlack,
//                                       //         fontSize: 12,
//                                       //         height: 1.2,
//                                       //         fontWeight: FontWeight.normal),
//                                       //   ),
//                                       // ),
//                                       // SizedBox(height: 3,),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "₹" +
//                                                 sortingModel!
//                                                     .restaurants![index]
//                                                     .price!,
//                                             style: TextStyle(
//                                                 color: appColorBlack,
//                                                 fontSize: 16,
//                                                 fontWeight:
//                                                 FontWeight.bold),
//                                           ),
//                                           // RatingBar.builder(
//                                           //   initialRating: sortingModel!.restaurants![index].resRating == "" ? 0.0 : double.parse(sortingModel!.restaurants![index].resRating.toString()),
//                                           //   minRating: 0,
//                                           //   direction: Axis.horizontal,
//                                           //   allowHalfRating: true,
//                                           //   itemCount: 5,
//                                           //   itemSize: 15,
//                                           //   ignoreGestures: true,
//                                           //   unratedColor: Colors.grey,
//                                           //   itemBuilder: (context, _) =>
//                                           //       Icon(Icons.star, color: appColorOrange),
//                                           //   onRatingUpdate: (rating) {
//                                           //     print(rating);
//                                           //   },
//                                           // ),
//                                         ],
//                                       ),
//                                    InkWell(
//                                      onTap: (){
//
//                                      },
//                                      child: Align(
//                                          alignment: Alignment.center,
//                                          child: Text("Book Service",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
//
//                                    ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Stack(
//                       //    alignment: Alignment.topCenter,
//                       //   children: [
//                       //     Padding(
//                       //       padding: const EdgeInsets.only(top: 30),
//                       //       child: Card(
//                       //         elevation: 5,
//                       //         shape: RoundedRectangleBorder(
//                       //           borderRadius: BorderRadius.circular(20),
//                       //         ),
//                       //         child: Container(
//                       //           width: 170,
//                       //           child: Padding(
//                       //             padding:  EdgeInsets.only(
//                       //                 bottom: 15, left: 15, right: 15),
//                       //             child: Column(
//                       //               crossAxisAlignment:
//                       //                   CrossAxisAlignment.start,
//                       //               mainAxisAlignment: MainAxisAlignment.end,
//                       //               children: [
//                       //                 Container(
//                       //                   height: 100,
//                       //                   width: 140,
//                       //                   alignment: Alignment.topCenter,
//                       //                   decoration: BoxDecoration(
//                       //                     color: Colors.black45,
//                       //                     borderRadius: BorderRadius.circular(10),
//                       //                     image: DecorationImage(
//                       //                       image: NetworkImage(sortingModel!
//                       //                           .restaurants![index].allImage![0]),
//                       //                       fit: BoxFit.cover,
//                       //                     ),
//                       //                   ),
//                       //                 ),
//                       //                 Text(
//                       //                   sortingModel!.restaurants![index].resName!,
//                       //                   maxLines: 1,
//                       //                   style: TextStyle(
//                       //                       color: appColorBlack,
//                       //                       fontSize: 14,
//                       //                       fontWeight: FontWeight.bold),
//                       //                 ),
//                       //                 Container(height: 8),
//                       //                 Row(
//                       //                   mainAxisAlignment:
//                       //                       MainAxisAlignment.spaceBetween,
//                       //                   crossAxisAlignment:
//                       //                       CrossAxisAlignment.end,
//                       //                   children: [
//                       //                     Column(
//                       //                       crossAxisAlignment:
//                       //                           CrossAxisAlignment.start,
//                       //                       children: [
//                       //                         Container(
//                       //                           width: 130,
//                       //                           child: Text(
//                       //                             sortingModel!.restaurants![index].resDesc!,
//                       //                             maxLines: 2,
//                       //                             style: TextStyle(
//                       //                                 color: appColorBlack,
//                       //                                 fontSize: 12,
//                       //                                 height: 1.2,
//                       //                                 fontWeight: FontWeight.normal),
//                       //                           ),
//                       //                         ),
//                       //                         Text(
//                       //                           "₹" +
//                       //                               sortingModel!
//                       //                                   .restaurants![index]
//                       //                                   .price!,
//                       //                           style: TextStyle(
//                       //                               color: appColorBlack,
//                       //                               fontSize: 16,
//                       //                               fontWeight:
//                       //                                   FontWeight.bold),
//                       //                         ),
//                       //                       ],
//                       //                     ),
//                       //                   ],
//                       //                 ),
//                       //               ],
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ),
//                       //     // Container(
//                       //     //   height: 100,
//                       //     //   width: 140,
//                       //     //   alignment: Alignment.topCenter,
//                       //     //   decoration: BoxDecoration(
//                       //     //     color: Colors.black45,
//                       //     //     borderRadius: BorderRadius.circular(10),
//                       //     //     image: DecorationImage(
//                       //     //       image: NetworkImage(sortingModel!
//                       //     //           .restaurants![index].allImage![0]),
//                       //     //       fit: BoxFit.cover,
//                       //     //     ),
//                       //     //   ),
//                       //     // ),
//                       //   ],
//                       // ),
//                     ),
//                   );
//                 },
//               )
//             : Center(
//                 child: Text(
//                   "Don't have any services",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               );
//   }
//
//   Widget _mapLocation(BuildContext context) {
//     return Container(
//       height: 550,
//       width: MediaQuery.of(context).size.width,
//       // decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 7)),
//       child: GoogleMap(
//         zoomGesturesEnabled: true,
//         initialCameraPosition: CameraPosition(
//           target: showLocation,
//           zoom: 10.0,
//         ),
//         markers: markers,
//         mapType: MapType.normal,
//         onMapCreated: (controller) {
//           setState(() {
//             mapController = controller;
//           });
//         },
//       ),
//     );
//   }
//
//
//   Widget _locationField(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 5),
//           child: Text("Pickup Location", style: TextStyle(
//               color: appColorWhite
//           ),),
//         ),
//         Container(
//           // height: 50,
//           margin: EdgeInsets.only(left: 15, right: 15),
//           child: TextFormField(
//             controller: pickUpController,
//             readOnly: true,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PlacePicker(
//                     apiKey: Platform.isAndroid
//                         ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
//                         : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
//                     onPlacePicked: (result) {
//                       print(result.formattedAddress);
//                       setState(() {
//                         pickUpController.text = result.formattedAddress.toString();
//                         pickLat = result.geometry!.location.lat;
//                         pickLong = result.geometry!.location.lng;
//                       });
//                       Navigator.of(context).pop();
//                       distnce();
//                     },
//                     initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
//                     useCurrentLocation: true,
//                   ),
//                 ),
//               );
//             },
//             decoration:
//             InputDecoration(
//               // labelText: "Pickup Location",
//               filled: true,
//               //fillColor: appColorOrange,
//               hintText: "Pickup Location",
//               prefixIcon: Icon(Icons.search,color: appColorBlack,),
//               suffixIcon: Icon(Icons.clear,color: appColorBlack),
//               enabledBorder: OutlineInputBorder(),
//               focusedBorder: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20.0, top: 1, bottom: 5),
//           child: Text("Drop Location", style: TextStyle(
//               color: appColorWhite
//           ),),
//         ),
//         Container(
//           // height: 60,
//           margin: EdgeInsets.only(left: 15, right: 15),
//           child: TextFormField(
//             controller: dropController,
//             readOnly: true,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PlacePicker(
//                     apiKey: Platform.isAndroid
//                         ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
//                         : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
//                     onPlacePicked: (result) {
//                       print(result.formattedAddress);
//                       setState(() {
//                         dropController.text =
//                             result.formattedAddress.toString();
//                         dropLat = result.geometry!.location.lat;
//                         dropLong = result.geometry!.location.lng;
//                       });
//                       Navigator.of(context).pop();
//                     },
//                     initialPosition: dropLat != 0
//                         ? LatLng(dropLat, dropLong)
//                         : LatLng(currentLocation!.latitude, currentLocation!.longitude),
//                     useCurrentLocation: true,
//                   ),
//                 ),
//               );
//             },
//             decoration: InputDecoration(
//               // labelText: "Drop Location",
//               hintText: "Drop Location",
//               enabledBorder: OutlineInputBorder(),
//               prefixIcon: Icon(Icons.search,color: appColorBlack,),
//               suffixIcon: Icon(Icons.clear,color: appColorBlack),
//               filled: true,
//               focusedBorder: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         SizedBox(height: 20),
//       ],
//     );
//   }
//
//   // _getPickLocation() async {
//   //   LocationResult result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PlacePicker(
//   //     "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
//   //   )));
//   //   // Navigator.of(context).push(MaterialPageRoute(
//   //   //     builder: (context) => PlacePicker(
//   //   //       "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
//   //   //     )));
//   //   print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
//   //   setState(() {
//   //     pickUpController.text = result.formattedAddress.toString();
//   //     cityC.text = result.locality.toString();
//   //     stateC.text = result.administrativeAreaLevel1!.name.toString();
//   //     countryC.text = result.country!.name.toString();
//   //     lat = result.latLng!.latitude;
//   //     long = result.latLng!.longitude;
//   //     pincodeC.text = result.postalCode.toString();
//   //   });
//   // }
//
//   Widget _getCategory(BuildContext context){
//    print("Food Services ${foodCategoryModel}");
//     return foodCategoryModel == null ? Center(
//       child: Image.asset("assets/images/loader1.gif", scale: 1),
//     ) :
//     Container(
//       height: 450,
//       child: GridView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: foodCategoryModel!.product!.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio:4.7 / 5.0,
//           crossAxisCount: 2,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return InkWell(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails(id: foodCategoryModel!.product![index].id)));
//             },
//             child: Padding(
//                 padding: EdgeInsets.all(5),
//                 child: Scrollbar(
//                   thickness: 10,
//                   trackVisibility: true,
//                   // isAlwaysShown: true,
//                   thumbVisibility: true,
//                   radius: Radius.circular(10),
//                   child: Card(
//                     color: Colors.black12,
//                       elevation: 1,
//                       semanticContainer: true,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         side: BorderSide(
//                           color: backgroundgrey, width: 2
//                         ),
//                       ),
//                       clipBehavior: Clip.antiAlias,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           // Center(
//                           //   child: Container(
//                           //     decoration: BoxDecoration(
//                           //         color: appColorOrange,
//                           //         borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
//                           //     height: 80,width: 5,
//                           //   ),
//                           // ),
//                           // SizedBox(width: 5),
//                           Container(
//                             height: 120,
//                               width: MediaQuery.of(context).size.width/1.7,
//                               child: Image.network("${foodCategoryModel!.product![index].profileImage}", height: 50, width: 50, fit: BoxFit.fill,)
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 7, top: 5),
//                                 child: Text("${foodCategoryModel!.product![index].storeDescription}"
//                                     ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 13)
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Text("${foodCategoryModel!.product![index].description}"
//                                     ,style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
//                               )
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5),
//                                 child: Image.asset("assets/images/location2.png", color: backgroundblack, height: 18, width: 18),
//                               ),
//                               SizedBox(width: 3),
//                               Container(
//                                 width: 80,
//                                 child: Text("${foodCategoryModel!.product![index].address}",
//                                   overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: appColorBlack),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           // Padding(
//                           //   padding: const EdgeInsets.only(top: 30),
//                           //   child: Column(
//                           //     crossAxisAlignment: CrossAxisAlignment.start,
//                           //     children: [
//                           //       Padding(
//                           //         padding: const EdgeInsets.only(left: 8),
//                           //         child: Text("${foodCategoryModel!.product![index].uname}",style: TextStyle(color: backgroundgrey,fontWeight: FontWeight.bold,fontSize: 18),
//                           //         ),
//                           //       ),
//                           //       Padding(
//                           //         padding: const EdgeInsets.only(left: 7),
//                           //         child: Text("${foodCategoryModel!.product![index].storeDescription}" ,style: TextStyle(color: backgroundgrey,fontWeight: FontWeight.bold,fontSize: 13)),
//                           //       ),
//                           //       Padding(
//                           //         padding: const EdgeInsets.only(left: 2.5),
//                           //         child: Container(
//                           //             alignment: Alignment.topLeft,
//                           //             margin: EdgeInsets.all(0),
//                           //             width: 180,
//                           //             child: Row(
//                           //               children: [
//                           //               Image.asset("assets/images/location2.png", color: appColorOrange, height: 18, width: 18),
//                           //               SizedBox(width: 3),
//                           //               Container(
//                           //                 width: 80,
//                           //                   child: Text("${foodCategoryModel!.product![index].address}", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: Colors.white),),
//                           //               ),
//                           //             ],
//                           //             ),
//                           //             // Text("",overflow: TextOverflow.ellipsis,maxLines: 4,)
//                           //         ),
//                           //       ),
//                           //       // Text("${foodCategoryModel!.product![index].description}", style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14)),
//                           //     ],
//                           //   ),
//                           // ),
//                           Spacer(),
//                           // Center(
//                           //   child: Container(
//                           //     decoration: BoxDecoration(
//                           //         color: appColorOrange,
//                           //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
//                           //     height: 80,width: 8),
//                           // ),
//                         ],
//                       )),
//                 )),
//           );
//         },
//       ),
//     );
//   }
//
//
//   Widget _getMehndiCategory(BuildContext context){
//     print("Mehndi Category ${mehndiCategoryModel}");
//     return mehndiCategoryModel == null ? Center(
//     child: Image.asset("assets/images/loader1.gif", scale: 1),
//     ) : InkWell(
//            onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryScreen()));
//        },
//       child: Container(
//         height: 450,
//         child: GridView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: mehndiCategoryModel!.imgssss!.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             childAspectRatio:4.7 / 5.0,
//             crossAxisCount: 2,
//           ),
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//                 padding: EdgeInsets.all(5),
//                 child: Scrollbar(
//                   thickness: 10,
//                   trackVisibility: true,
//                   // isAlwaysShown: true,
//                   thumbVisibility: true,
//                   radius: Radius.circular(10),
//                   child: Card(
//                       color: Colors.black12,
//                       elevation: 1,
//                       semanticContainer: true,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                         side: BorderSide(
//                             color: backgroundgrey, width: 2
//                         ),
//                       ),
//                       clipBehavior: Clip.antiAlias,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           // Center(
//                           //   child: Container(
//                           //     decoration: BoxDecoration(
//                           //         color: appColorOrange,
//                           //         borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
//                           //     height: 80,width: 5,
//                           //   ),
//                           // ),
//                           // SizedBox(width: 5),
//                           Container(
//                               height: 120,
//                               // width: double.infinity,
//                               child: Stack(
//                                 children: [
//                                   mehndiCategoryModel == null
//                                       ? Center(
//                                     child: Image.asset("assets/images/loader1.gif", scale: 1,),
//                                   ) :
//                                   Image.network("${mehndiCategoryModel!.imgssss![index].otherImg}", fit: BoxFit.fill,),
//                                   // SizedBox(height: 190,),
//                                   Center(
//                                     child: ImageSlideshow(
//                                       width: double.infinity,
//                                       // height: 170,
//                                       initialPage: 0,
//                                       indicatorColor: appColorOrange,
//                                       // indicatorBackgroundColor: Colors.grey,
//                                       children: mehndiCategoryModel!.imgssss![index].otherImg!.map((item) =>
//                                           CachedNetworkImage(
//                                             imageUrl: item, fit: BoxFit.fill,
//                                             placeholder: (context, url) => Center(
//                                               child: Container(
//                                                 margin: EdgeInsets.all(70.0),
//                                                 child: CircularProgressIndicator(),
//                                               ),
//                                             ),
//                                             errorWidget: (context, url, error) => Container(
//                                               height: 5, width: 5,
//                                               child: Icon(
//                                                 Icons.error,
//                                               ),
//                                             ),
//                                           ),)
//                                           .toList(),
//                                       onPageChanged: (value) {
//                                         print('Page changed: $value');
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               // child: mehndiCategoryModel!.imgssss![index].img == null || mehndiCategoryModel!.imgssss![index].img == "" ? Center(child: Image.asset("assets/images/loader1.gif", height: 20, width: 20,),
//                               // ):
//                               // Image.network("${mehndiCategoryModel!.imgssss![index].otherImg![index]}",
//                               // ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 10, top: 5),
//                                 child: Text("${mehndiCategoryModel!.imgssss![index].cName}"
//                                     ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 13)
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       )),
//                   // child: Card(
//                   //   color: backgroundblack,
//                   //     elevation: 1,
//                   //     semanticContainer: true,
//                   //     shape: RoundedRectangleBorder(
//                   //       borderRadius: BorderRadius.circular(10.0),
//                   //     ),
//                   //     clipBehavior: Clip.antiAlias,
//                   //     child: Row(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       mainAxisAlignment: MainAxisAlignment.start,
//                   //       children: <Widget>[
//                   //         Center(
//                   //           child: Container(
//                   //             decoration: BoxDecoration(
//                   //                 color: appColorOrange,
//                   //                 borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
//                   //             height: 80,width: 8,),
//                   //         ),
//                   //         SizedBox(width: 5,),
//                   //         Center(
//                   //           child: ClipRRect(
//                   //             borderRadius: BorderRadius.circular(100),
//                   //               // radius: 40,
//                   //               child: Image.network("${mehndiCategoryModel!.imgssss![index].img}", height: 60, width: 60, fit: BoxFit.fill)
//                   //           ),
//                   //         ),
//                   //         Padding(
//                   //           padding: const EdgeInsets.only(top: 40.0, left: 5),
//                   //           child: Column(
//                   //             crossAxisAlignment: CrossAxisAlignment.start,
//                   //             children: [
//                   //               Container(
//                   //                 width : 160,
//                   //                   child: Text("${mehndiCategoryModel!.imgssss![index].cName}",overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16, ),)),
//                   //               // Padding(
//                   //               //   padding: const EdgeInsets.only(left: 3.5),
//                   //               //   child: Container(
//                   //               //       alignment: Alignment.topLeft,
//                   //               //       margin: EdgeInsets.all(0),
//                   //               //       width: 180,
//                   //               //       child: Text("Model food systems provide a means of determining how the ingredients and the process alter the characteristics of the final product, as well as evaluating the sensitivity of the characteristics of the food to the different ingredients and processing steps.",overflow: TextOverflow.ellipsis,maxLines: 4,)),
//                   //               // ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //         Spacer(),
//                   //         Center(
//                   //           child: Container(
//                   //             decoration: BoxDecoration(
//                   //                 color: appColorOrange,
//                   //                 borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)
//                   //                 ),
//                   //             ),
//                   //             height: 80,width: 8,),
//                   //         ),
//                   //       ],
//                   //     )),
//                 ));
//           },
//       ),
//     ),
//         );
//   }
//
//   Widget _getHandyManCategory(BuildContext context){
//     print("Hnady Man ${handyManModel}");
//     return handyManModel == null ? Center(
//       child: Image.asset("assets/images/loader1.gif", scale: 1,),
//     )
//         :Container(
//       height: 250,
//       child: GridView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: handyManModel!.imgssss!.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio:5.0 / 10.8,
//           crossAxisCount: 2,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//               padding: EdgeInsets.all(5),
//               child: Scrollbar(
//                 thickness: 1,
//                 trackVisibility: true,
//                 // isAlwaysShown: true,
//                 thumbVisibility: true,
//                 radius: Radius.circular(10),
//                 child: Card(
//                   color: backgroundblack,
//                     elevation: 10,
//                     semanticContainer: true,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     clipBehavior: Clip.antiAlias,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Center(
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: appColorOrange,
//                                 borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
//                             height: 80,width: 8,),
//                         ),
//                         SizedBox(width: 5,),
//                         Center(
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(100),
//                               // radius: 40,
//                               child: Image.network("${handyManModel!.imgssss![index].img}", height: 60, width: 60, fit: BoxFit.fill,)
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 45.0, left: 5),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width : 150,
//                                   child: Text("${handyManModel!.imgssss![index].cName}",overflow: TextOverflow.ellipsis,maxLines: 2, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),)),
//                               // Padding(
//                               //   padding: const EdgeInsets.only(left: 3.5),
//                               //   child: Container(
//                               //       alignment: Alignment.topLeft,
//                               //       margin: EdgeInsets.all(0),
//                               //       width: 180,
//                               //       child: Text("Model food systems provide a means of determining how the ingredients and the process alter the characteristics of the final product, as well as evaluating the sensitivity of the characteristics of the food to the different ingredients and processing steps.",overflow: TextOverflow.ellipsis,maxLines: 4,)),
//                               // ),
//                             ],
//                           ),
//                         ),
//                         Spacer(),
//                         Center(
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: appColorOrange,
//                                 borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
//                             height: 80,width: 8),
//                         ),
//                       ],
//                     )),
//               ));
//         },
//       ),
//     );
//   }
//
//
//   Widget _offerBanners(BuildContext context){
//     print("offer Banners ${offerBannerModel?.title}");
//     return offerBannerModel == null
//         ? Center(
//       child: Image.asset("assets/images/loader1.gif", scale: 1,),
//     ) :
//         Column(
//           children: [
//             Align(
//               alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20),
//                   child: Text("${offerBannerModel!.title!}", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700),),
//                 )
//             ),
//             _CarouselSlider(),
//             ToggleSwitch(
//               minWidth: 50,
//               minHeight: 30,
//               cornerRadius: 20.0,
//               activeBgColors: [[Colors.yellow], [Colors.yellow]],
//               activeFgColor: Colors.white,
//               inactiveBgColor: Colors.blue,
//               // activeThumbImage: const AssetImage('assets/happy_emoji.png'),
//               labels: ["${CustomIcons.img}","${CustomIcons.img1}"],
//               customIcons: [
//                 Icon(Boxicons.bx_abacus),
//                 // Icon(
//                 //   FontAwesomeIcons.box,
//                 //   color: Colors.white,
//                 //   size: 25.0,
//                 // ),
//                 Icon(
//                   FontAwesomeIcons.motorcycle,
//                   color: Colors.black,
//                   size: 25.0,
//                 ),
//               ],
//               inactiveFgColor: Colors.white,
//               initialLabelIndex:status == "Active" ? 1 : 0,
//               totalSwitches: 2,
//               // labels: ['${getTranslated(context, 'no')}', '${getTranslated(context, 'yes')}'],
//               radiusStyle: true,
//               onToggle: (index) {
//                 print('switched to: $index');
//                 if(index == 0){
//                   status = "Inactive";
//                 }
//                 else{
//                   status = "Active";
//                 }
//                 setState(() {
//                 });
//               },
//             ),
//             ToggleButtons(
//                 splashColor: Colors.yellow,
//               constraints: BoxConstraints(minHeight: 20,minWidth: 40),
//                 borderRadius: BorderRadius.circular(100),
//                 isSelected: isSelected,
//                 color: Colors.black,
//                 fillColor: Colors.yellow,
//
//             focusColor: Colors.black,
//             children: [
//               Padding(padding: const EdgeInsets.symmetric(horizontal: 7),
//               child: Image.asset("assets/toggelswich/shipping.png",),),
//               Padding(padding: const EdgeInsets.symmetric(horizontal: 2),
//               child: Image.asset("assets/toggelswich/bke.png"),),],
//             onPressed: (int newIndex) {
//             setState(() {
//               for (int index = 0; index < isSelected.length; index++) {
//             if (index == newIndex) {
//
//             isSelected[index] = true;
//            } else {
//           isSelected[index] = false;
//             }
//        }
//      });
//      }
//      ),
//             // SlidingSwitch(
//             //   value: false,
//             //   width: 250,
//             //   onChanged: (bool value) {
//             //     Image.asset("assets/toggelswich/shipping.png");
//             //
//             //     print(value);
//             //   },
//             //   height : 55,
//             //   animationDuration : const Duration(milliseconds: 400),
//             //   onTap:(){
//             //     Image.asset("assets/toggelswich/shipping.png");
//             //   },
//             //   onDoubleTap:(){},
//             //   onSwipe:(){
//             //     Image.asset("assets/toggelswich/shipping.png");
//             //
//             //   },
//             //
//             //   // textOff : "Female",
//             //   // textOn : "Male",
//             //   // iconOff:
//             //   // Icons.h_mobiledata,
//             //   // iconOn: Icons.add,
//             //
//             //
//             //   contentSize: 17,
//             //   colorOn : const Color(0xffdc6c73),
//             //   colorOff : const Color(0xff6682c0),
//             //   background : const Color(0xffe4e5eb),
//             //   buttonColor : const Color(0xfff7f5f7),
//             //   inactiveColor : const Color(0xff636f7b),
//             // ),
//
//           ],
//         );
//     //     : ImageSlideshow(
//     //   width: MediaQuery.of(context).size.width/1.1,
//     //   height: 180,
//     //   initialPage: 0,
//     //   indicatorColor: appColorOrange,
//     //   indicatorBackgroundColor: Colors.grey,
//     //   children: offerBannerModel!.banners!
//     //       .map(
//     //         (item) => Padding(
//     //       padding: const EdgeInsets.symmetric(horizontal: 10),
//     //       child: ClipRRect(
//     //           borderRadius: BorderRadius.circular(20),
//     //           child: CachedNetworkImage(
//     //             imageUrl: item,
//     //             fit: BoxFit.cover,
//     //             placeholder: (context, url) => Center(
//     //               child: Container(
//     //                 margin: EdgeInsets.all(70.0),
//     //                 child: CircularProgressIndicator(),
//     //               ),
//     //             ),
//     //             errorWidget: (context, url, error) => Container(
//     //               height: 5,
//     //               width: 5,
//     //               child: Icon(
//     //                 Icons.error,
//     //               ),
//     //             ),
//     //           )),
//     //     ),
//     //   )
//     //       .toList(),
//     //   onPageChanged: (value) {
//     //     print('Offer banner changed here: $value');
//     //   },
//     // );
//   }
//
//   Widget _radioButton(BuildContext context) {
//     return Row(
//       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // InkWell(
//         //   onTap: () {},
//         //   child: Container(
//         //     height: 45,
//         //     width: 85,
//         //     decoration: BoxDecoration(
//         //         borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
//         //         color: backgroundblack,
//         //     ),
//         //     child: Center(child: Text("BOOK \nRIDE", style: TextStyle(color:appColorOrange, fontWeight: FontWeight.w500),)),
//         //   ),
//         // ),
//         // ToggleSwitch(
//         //   minWidth: 50.0,
//         //   cornerRadius: 40.0,
//         //   activeBgColors: [[Color(0xFF0047AF)!], [Color(0xFFFFD400)!]],
//         //   activeFgColor: Colors.white,
//         //   inactiveBgColor: Colors.grey,
//         //   inactiveFgColor: Colors.white,
//         //   initialLabelIndex: 1,
//         //   totalSwitches: 2,
//         //   // labels: ['True', 'False'],
//         //   radiusStyle: true,
//         //   onToggle: (index) {
//         //     print('switched to: $index');
//         //   },
//         // ),
//         // InkWell(
//         //   onTap: () {
//         //     Navigator.push(context, MaterialPageRoute(builder: (context) =>Sendpackage()));
//         //   },
//         //   child: Container(
//         //     height: 45,
//         //     width: 85,
//         //     decoration: BoxDecoration(
//         //       borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
//         //       color: backgroundblack,
//         //     ),
//         //     child: Center(child: Text("SEND \nPACKAGE", style: TextStyle(color: appColorOrange, fontWeight: FontWeight.w500))),
//         //   ),
//         // ),
//       ],
//     );
//     // return Padding(
//     //   padding: const EdgeInsets.all(15),
//     //   child: Row(
//     //     children: [
//     //       Image.asset("assets/images/bike.png", scale: 1.4,),
//     //       Row(
//     //         mainAxisAlignment: MainAxisAlignment.center,
//     //         // crossAxisAlignment: CrossAxisAlignment.center,
//     //         // mainAxisAlignment: MainAxisAlignment.center,
//     //         children: [
//     //           Container(
//     //             width: 20,
//     //             height: 20,
//     //             margin: EdgeInsets.only(left: 5, right: 5),
//     //             child: Radio(
//     //                 value: 1,
//     //                 fillColor: MaterialStateColor.resolveWith((states) => backgroundblack),
//     //                 groupValue: _value1,
//     //                 onChanged: (int? value) {
//     //                   setState(() {
//     //                     _value1 = value!;
//     //                     // roleUser = true;
//     //                     // isUpi = false;
//     //                   });
//     //                 }),
//     //           ),
//     //           Text(
//     //             "Book a Ride",
//     //             style: TextStyle(
//     //                 color: backgroundblack, fontSize: 15),
//     //           ),
//     //           const SizedBox(width: 25),
//     //           Image.asset("assets/images/message.png", scale: 1.4),
//     //           Container(
//     //             width: 20,
//     //             height: 20,
//     //             margin: EdgeInsets.only(left: 5, right: 5),
//     //             child: Radio(
//     //                 value: 2,
//     //                 fillColor: MaterialStateColor.resolveWith((states) => backgroundblack),
//     //                 groupValue: _value1,
//     //                 onChanged: (int? value) {
//     //                   setState(() {
//     //                     _value1 = value!;
//     //                     // roleUser = true;
//     //                     // isUpi = false;
//     //                   });
//     //                 }),
//     //           ),
//     //           InkWell(
//     //             onTap: () {
//     //               Navigator.push(context, MaterialPageRoute(builder: (context) => SendPackage()));
//     //             },
//     //             child: Text(
//     //               "Send Package",
//     //               style: TextStyle(
//     //                   color: backgroundblack,
//     //                   fontSize: 15
//     //               ),
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
//
//
//   Widget _banner(BuildContext context) {
//     print("Banners ${bannerModal}");
//     return bannerModal == null
//         ?
//     Center(
//             child: Image.asset("assets/images/loader1.gif", scale: 1,),
//           )
//         :  Container(
//       height: 250,
//           child: Stack(
//        children: [
//            backBannerModel == null
//                ? Center(
//              child: Image.asset("assets/images/loader1.gif", scale: 1,),
//            ) :
//            Image.network("${backBannerModel!.data!.banner}", height: 200, width: MediaQuery.of(context).size.width, fit: BoxFit.fill,),
//       // SizedBox(height: 190,),
//       Positioned(
//           top: 70,
//           left: 50,
//           child:  ImageSlideshow(
//             width: MediaQuery.of(context).size.width/1.3,
//             height: 170,
//             initialPage: 0,
//             indicatorColor: appColorOrange,
//             indicatorBackgroundColor: Colors.grey,
//             children: bannerModal!.banners!
//                 .map((item) => Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: CachedNetworkImage(
//                     imageUrl: item, fit: BoxFit.cover,
//                     placeholder: (context, url) => Center(
//                       child: Container(
//                         margin: EdgeInsets.all(70.0),
//                         child: CircularProgressIndicator(),
//                       ),
//                     ),
//                     errorWidget: (context, url, error) => Container(
//                       height: 5, width: 5,
//                       child: Icon(
//                         Icons.error,
//                       ),
//                     ),
//                   )),
//             ),)
//                 .toList(),
//             onPageChanged: (value) {
//               print('Page changed: $value');
//             },
//           ),)
//
//       ],
//     ),
//         );
//     // ImageSlideshow(
//     //         width: MediaQuery.of(context).size.width/1.1,
//     //         height: 200,
//     //         initialPage: 0,
//     //         indicatorColor: appColorOrange,
//     //         indicatorBackgroundColor: Colors.grey,
//     //         children: bannerModal!.banners!
//     //             .map(
//     //               (item) => Padding(
//     //                 padding: const EdgeInsets.symmetric(horizontal: 10),
//     //                 child: ClipRRect(
//     //                     borderRadius: BorderRadius.circular(20),
//     //                     child: CachedNetworkImage(
//     //                       imageUrl: item,
//     //                       fit: BoxFit.cover,
//     //                       placeholder: (context, url) => Center(
//     //                         child: Container(
//     //                           margin: EdgeInsets.all(70.0),
//     //                           child: CircularProgressIndicator(),
//     //                         ),
//     //                       ),
//     //                       errorWidget: (context, url, error) => Container(
//     //                         height: 5,
//     //                         width: 5,
//     //                         child: Icon(
//     //                           Icons.error,
//     //                         ),
//     //                       ),
//     //                     )),
//     //               ),
//     //             )
//     //             .toList(),
//     //         onPageChanged: (value) {
//     //           print('Page changed: $value');
//     //         },
//     //       );
//   }
//
//   Widget collectionWidget() {
//     return Column(
//       children: [
//         Container(
//           color: backgroundgrey,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(height: 10),
//                 Text(
//                   "Categories",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 // Text(
//                 //   "Hygiene & Safety Store",
//                 //   style: TextStyle(
//                 //       fontSize: 14,
//                 //       fontWeight: FontWeight.bold,
//                 //       color: Colors.grey),
//                 // ),
//                 Container(height: 10),
//                 Container(height: collectionModal == null ? 150 :100 , child: collectionData()),
//                 Container(height: 10),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget collectionData() {
//     return collectionModal == null
//         ? Center(
//             child: Image.asset("assets/images/loader1.gif", scale: 1,),
//           )
//         : collectionModal!.categories!.length > 0
//             ? ListView.builder(
//                 padding: EdgeInsets.only(
//                   bottom: 10,
//                   top: 0,
//                 ),
//                 itemCount: collectionModal!.categories!.length,
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (context, int index,) {
//                   return sortingCard(
//                       context, collectionModal!.categories![index]);
//                 },
//               )
//             : Center(
//                 child: Text(
//                   "No data found",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               );
//   }
//
//   Widget sortingCard(BuildContext context, Categories categories) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 15),
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     SubCategoryScreen(id: categories.id!, name: categories.cName!,image: categories.img,description: categories.description,)
//                     // ViewCategory(id: categories.id!, name: categories.cName!)
//             ),
//           );
//         },
//         child: Card(
//           elevation: 3,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Container(width: 5),
//               Container(
//                 width: 80,
//                 height: 60,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(5),
//                   child: Image.network(
//                     categories.img!,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               Container(width: 10),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     categories.cName!,
//                     style: TextStyle(
//                         color: appColorBlack,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold),
//                     maxLines: 1,
//                   ),
//                 ],
//               ),
//               Container(width: 15)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget bestSellerWidget() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(height: 30),
//         Padding(
//           padding: const EdgeInsets.only(left: 20),
//           child: Text(
//             "Best Service Provider",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 20),
//           child: Text(
//             "check out our best services",
//             style: TextStyle(
//                 fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
//           ),
//         ),
//         Container(height: 30),
//         Container(
//           color: backgroundgrey,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(height: 10),
//                 /*Padding(
//                   padding: const EdgeInsets.only(right: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SearchProduct(
//                                       back: true,
//                                     )),
//                           );
//                         },
//                         child: Text(
//                           "View All",
//                           style: TextStyle(
//                               color: appColorBlack,
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),*/
//                 Container(height: 200,
//                     child: bestSellerItems()
//                 ),
//                 Container(height: 10),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget bestSellerItems() {
//     return allProduct == null
//         ? Center(
//             child: Image.asset("assets/images/loader1.gif", scale: 1,),
//           )
//         : allProduct!.setting!.length > 0
//             ? ListView.builder(
//                 padding: EdgeInsets.only(bottom: 10),
//                 scrollDirection: Axis.horizontal,
//                 shrinkWrap: true,
//                 itemCount: allProduct!.setting!.length,
//                 itemBuilder: (
//                   context,
//                   int index,
//                 ) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         CupertinoPageRoute(
//                           builder: (context) => ViewCategory(
//                             vid: allProduct!.setting![index].id,
//                             name: allProduct!.setting![index].uname,
//                             fromSeller: true,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 20),
//                       child: Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Container(
//                           width: 180,
//                           child: Padding(
//                             padding: const EdgeInsets.only(
//                                 bottom: 15, left: 10, right: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       height: 120,
//                                       width: 140,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(20.0)
//                                       ),
//                                       child: ClipRRect(
//                                         borderRadius: BorderRadius.circular(20),
//                                         child: Image.network(allProduct!
//                                             .setting![index].profileImage!,
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(height: 5),
//                                 Text(
//                                   "${allProduct!.setting![index].fname} ${allProduct!.setting![index].lname}",
//                                   maxLines: 2,
//                                   style: TextStyle(
//                                       color: appColorBlack,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Container(height: 5),
//                                 /*Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "₹" +
//                                               allProduct!.setting![index]
//                                                   .productPrice!,
//                                           style: TextStyle(
//                                               color: appColorBlack,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                           color: appColorOrange,
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15))),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Icon(
//                                           Icons.shopping_bag_outlined,
//                                           color: appColorWhite,
//                                           size: 20,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),*/
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               )
//             : Center(
//                 child: Text(
//                   "Don't have any near by service providers",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               );
//   }
//
//   _CarouselSlider(){
//     return  Padding(
//       padding: EdgeInsets.only(
//           top: 18, bottom: 18, left: 10, right: 10),
//       child: CarouselSlider(
//         options: CarouselOptions(
//           viewportFraction: 1.4,
//           initialPage: 0,
//           enableInfiniteScroll: true,
//           reverse: false,
//           autoPlay: true,
//           autoPlayInterval: Duration(seconds: 7),
//           autoPlayAnimationDuration:
//           Duration(milliseconds: 350),
//           enlargeCenterPage: false,
//           scrollDirection: Axis.horizontal,
//           height: 140,
//           onPageChanged: (position, reason) {
//             setState(() {
//               currentindex = position;
//             });
//             print(reason);
//             print(CarouselPageChangedReason.controller);
//           },
//         ),
//         items: offerBannerModel!.banners!.map((val) {
//           return Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//                 borderRadius:
//                 BorderRadius.circular(20)),
//             // height: 180,
//             // width: MediaQuery.of(context).size.width,
//             child: ClipRRect(
//                 borderRadius:
//                 BorderRadius.circular(20),
//                 child: Image.network(
//                   "${offerBannerModel!.banners!.first.image}",
//                   fit: BoxFit.fill,
//                 )),
//           );
//         }).toList(),
//       ),
//     );
//   }
//   Widget _normalToggleButton () {
//     return Container(
//       height: 20,
//
//       child: Transform.scale(
//
//         scale: 1.5,
//         child: Switch(
//
//           activeColor : Colors.greenAccent,
//           inactiveThumbColor: Colors.redAccent,
//           value: _value,
//           activeThumbImage: AssetImage("assets/toggelswich/shipping.png"),
//           inactiveThumbImage : AssetImage("assets/toggelswich/shipping.png"),
//           onChanged: (bool value){
//             setState(() {
//               _value = value;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
// class CustomIcons {
//   CustomIcons._();
//   static const _kFontFam = 'CustomIcons';
//   static const String? _kFontPkg = null;
//
//   static const img = AssetImage("assets/images/loader1.gif");
//   static const img1 = AssetImage("assets/images/loader1.gif");
// }

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:boxicons/boxicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ez/models/FoodCategoryModel.dart';
import 'package:ez/models/MehndiCategoryModel.dart';
import 'package:ez/models/OfferBannerModel.dart';
// import 'package:ez/models/ride_calculation_model.dart';
// import 'package:ez/screens/RideBooking/finding_ride_screen.dart';
import 'package:ez/screens/view/models/DestinationModel.dart';
import 'package:ez/screens/view/models/GetMainCatModel.dart';
import 'package:ez/screens/view/models/allKey_modal.dart';
import 'package:ez/screens/view/models/allProduct_modal.dart';
import 'package:ez/screens/view/models/bannerModal.dart';
import 'package:ez/screens/view/models/categories_model.dart';
import 'package:ez/screens/view/models/getCart_modal.dart';
import 'package:ez/screens/view/models/getServiceWishList_modal.dart';
import 'package:ez/screens/view/models/getWishList_modal.dart';
import 'package:ez/screens/view/newUI/MyRequestPage.dart';
import 'package:ez/screens/view/newUI/MyWallet.dart';
import 'package:ez/screens/view/newUI/notificationScreen.dart';
import 'package:ez/screens/view/newUI/privacy_policy.dart';
import 'package:ez/screens/view/newUI/searchProduct.dart';
import 'package:ez/screens/view/newUI/sub_category.dart';
import 'package:ez/screens/view/newUI/terms_condition.dart';
import 'package:ez/screens/view/newUI/welcome2.dart';
import 'package:ez/screens/view/newUI/wishList.dart';
// import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ez/constant/global.dart';
import 'package:ez/constant/sizeconfig.dart';
import 'package:ez/screens/view/newUI/detail.dart';
import 'package:ez/screens/view/models/catModel.dart';
import 'package:ez/screens/view/newUI/viewCategory.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:place_picker/entities/location_result.dart';
// import 'package:place_picker/entities/location_result.dart';
// import 'package:place_picker/widgets/place_picker.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'package:ez/share_preference/preferencesKey.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../models/HandyManModel.dart';
import '../Ride/finding_ride_screen.dart';
import '../Ride/ride_calculation_model.dart';
import '../models/BackBannerModel.dart';
import '../models/getUserModel.dart';
import 'Chat_Screen.dart';
import 'GroceryDetails.dart';
import 'SendPackage.dart';
import 'faq_screen.dart';
import 'google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

var homelat;
var homeLong;

class _DiscoverState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  var orientation;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  CatModal? sortingModel;
  BannerModal? bannerModal;
  OfferBannerModel? offerBannerModel;
  HandyManModel? handyManModel;
  MehndiCategoryModel? mehndiCategoryModel;
  FoodCategoryModel? foodCategoryModel;
  AllCateModel? collectionModal;
  // FancyDrawerController? _controller;
  AllProductModal? allProduct;
  GetCartModal? getCartModal;
  GetWishListModal? getWishListModal;
  Position? currentLocation;
  GetUserModel? model;
  final Geolocator geolocator = Geolocator();
  String? _currentAddress;

  int currentindex=0;
  double pickLat = 0;
  double pickLong = 0;
  double dropLat = 0;
  double dropLong = 0;
  var status;
  int _currentPost = 0;


  @override
  void initState() {


    getUserCurrentLocation();
    _getAddressFromLatLng();
    getUserDataFromPrefs();
    getDestination();
    calculateRidePrice();
    // _controller = FancyDrawerController(
    //     vsync: this, duration: Duration(milliseconds: 250))
    //   ..addListener(() {
    //     setState(() {});
    //   });
    markers.add(Marker( //add marker on google map
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: InfoWindow( //popup info
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    super.initState();
  }

  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(27.7089427, 85.3086209);
  //location to show in map

  TextEditingController addressC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController stateC = TextEditingController();
  TextEditingController countryC = TextEditingController();
  TextEditingController pincodeC = TextEditingController();
  TextEditingController pickUpController = TextEditingController();
  TextEditingController dropController = TextEditingController();
  double lat = 0.0;
  double long = 0.0;

  Future getUserCurrentLocation() async {
    print("Home latttt and longg ${homelat} ${homeLong}");

    var status = await Permission.location.request();
    if(status.isDenied) {
      Fluttertoast.showToast(msg: "Permision is requiresd");
    }else if(status.isGranted){
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
        if (mounted)
          setState(() {
            currentLocation = position;
            homelat = currentLocation?.latitude;
            homeLong = currentLocation?.longitude;
          });
      });
      print("LOCATION===" +currentLocation.toString());
    } else if(status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  _getAddressFromLatLng() async {
    await getUserCurrentLocation().then((_) async {
      try {
        print("Addressss function");
        List<Placemark> p = await placemarkFromCoordinates(currentLocation!.latitude, currentLocation!.longitude);
        Placemark place = p[0];
        setState(() {
          _currentAddress = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";

          //"${place.name}, ${place.locality},${place.administrativeArea},${place.country}";
          print("current addresssss nowwwww${_currentAddress}");
        });
      } catch (e) {
        print('errorrrrrrr ${e}');
      }
    });
  }

  getUserDataFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userDataStr = preferences.getString(SharedPreferencesKey.LOGGED_IN_USERRDATA);
    // Map<String, dynamic> userData = json.decode(userDataStr!);
    // print(userData);
    // setState(() {
    //   userID = userData['user_id'];
    // });
    _getAllKey();
    _getBanners();
    _backBanner();
    _getMainCat();
    _getCategories();
    _getMehndiCat();
    _getHandyManCat();
    _getOfferBanners();
    _getCollection();
    sortingApiCall();

    Future.delayed(Duration(seconds: 5),(){
      // _getAllProduct();
    });

    _getCart();
    _getWishList();
    getUserDataApicall();
    _getServiceWishList();
  }

  _getAllKey() async {
    AllKeyModal allKeyModal;
    var uri = Uri.parse('${baseUrl()}/general_setting');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        allKeyModal = AllKeyModal.fromJson(userData);
        if (allKeyModal != null) {
          stripSecret = allKeyModal.setting!.sSecretKey!;
          stripPublic = allKeyModal.setting!.sPublicKey!;
          rozSecret = allKeyModal.setting!.rSecretKey!;
          rozPublic = allKeyModal.setting!.rPublicKey!;
        }
      });
    }
    print(responseData);
  }

  int _value1 = 1;

  sortingApiCall() async {
    // if (mounted)
    //   setState(() {
    //     isLoading = true;
    //   });
    print("ssdsds ${baseUrl()}/get_all_cat_nvip_sorting");
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      final response = await client.post(
        Uri.parse("${baseUrl()}/get_all_cat_nvip_sorting"),
        headers: headers,
      );
      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      sortingModel = CatModal.fromJson(userMap);
      print("Sorting>>>>>>");
      print(dic);
      if (mounted)
        setState(() {
          isLoading = false;
        });
    } on Exception {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      Fluttertoast.showToast(msg: "No Internet connection");
      // Toast.show("No Internet connection", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      throw Exception('No Internet connection');
    }
  }

  // _getBanners() async {
  //   var uri = Uri.parse('${baseUrl()}get_all_banners');
  //   var request = new http.MultipartRequest("GET", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.headers.addAll(headers);
  //   // request.fields['vendor_id'] = userID;
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);
  //   if (mounted) {
  //     setState(() {
  //       bannerModal = BannerModal.fromJson(userData);
  //     });
  //   }
  //   print(responseData);
  // }

  BackBannerModel? backBannerModel;
  _backBanner() async {
    var headers = {
      'Cookie': 'ci_session=76c877581e6065a833bd95288c5d58dc7afba115'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_banner_back_img'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = BackBannerModel.fromJson(json.decode(finalResponse));
      print("Bannersssssssss$jsonResponse");
      setState(() {
        backBannerModel = BackBannerModel.fromJson(json.decode(finalResponse));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  GetMainCatModel? getMainCatModel;

  _getMainCat() async{
    var headers = {
      'Cookie': 'ci_session=18c4e244ae8774010ceca2feffdb543713ce5b35'
    };
    var request = http.MultipartRequest('GET', Uri.parse('https://sodindia.com/api/get_main_cat_img'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetMainCatModel.fromJson(json.decode(finalResponse));
      print("Mehndi serivesss$jsonResponse");
      setState(() {
        getMainCatModel = GetMainCatModel.fromJson(json.decode(finalResponse));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  _getBanners() async{
    print("Banners Api working");
    var headers = {
      'Cookie': 'ci_session=22a2e1e4bee7fd081455779611c9b60a863af0a8'
    };
    var request = http.MultipartRequest('GET', Uri.parse('https://sodindia.com/api/get_all_banners'));
    request.fields.addAll({
      'type_id': '0'
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = BannerModal.fromJson(json.decode(finalResponse));
      print("Bannersssssssss$jsonResponse");
      setState(() {
        bannerModal = BannerModal.fromJson(json.decode(finalResponse));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  _getOfferBanners() async{
    print("offer Bannersss");
    var headers = {
      'Cookie': 'ci_session=64cc5c33c3d0410c422d2132427afd788cee0e77'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_offer_banners'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = OfferBannerModel.fromJson(json.decode(finalResponse));
      print("Offer Bannersss$jsonResponse");
      setState(() {
        offerBannerModel = OfferBannerModel.fromJson(json.decode(finalResponse));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  _getMehndiCat() async{
    print("Mehndi details Api");
    var headers = {
      'Cookie': 'ci_session=bc683ce5943cc87d6c193ab40ea1077028ba3ca9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_mehndi_services'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = MehndiCategoryModel.fromJson(json.decode(finalResponse));
      print("Mehndi serivesss$jsonResponse");
      setState(() {
        mehndiCategoryModel = MehndiCategoryModel.fromJson(json.decode(finalResponse));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }


  _getHandyManCat() async{
    print("Handy Man Api");
    var headers = {
      'Cookie': 'ci_session=9fc22c802baa4796f3d0a1be128441e4a043fca5'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_handy_services'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = HandyManModel.fromJson(json.decode(finalResponse));
      print("Mehndi serivesss$jsonResponse");
      setState(() {
        handyManModel = HandyManModel.fromJson(json.decode(finalResponse));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  _getCategories() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await  getUserCurrentLocation();
    print("Food,Grocery Api");
    var headers = {
      'Cookie': 'ci_session=19ae37817b8d23863ef9b269b178b64435cd91ea'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/grocery_services'));
    print("Current KLat Lokn ${currentLocation?.latitude}");
    print("GFhhghfgffg ${homeLong}",);
    print("kjkhkjhjkhjhk ${homelat}");
    request.fields.addAll({
      'lat': '${currentLocation!.latitude}',
      'long': '${currentLocation!.longitude}'
    });
    print("LatLonggggg ${request.fields}");
    // request.fields.add({
    //   'lat': '${currentLocation!.latitude}',
    //   'long': '${currentLocation!.longitude}'
    // });
    print("Lat Long Parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = FoodCategoryModel.fromJson(json.decode(finalResponse));
      if(jsonResponse.status == 1){
        print("Food Servicesss$jsonResponse");
        String id = jsonResponse.product![0].id.toString();
        preferences.setString("id", id);
        print("Varient id is ${id.toString()}");
        setState(() {
          foodCategoryModel = FoodCategoryModel.fromJson(json.decode(finalResponse));
        });
      } else{
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }


  _getCollection() async {
    var uri = Uri.parse('${baseUrl()}/get_all_cat');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    print(baseUrl.toString());

    request.headers.addAll(headers);
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if (mounted) {
      setState(() {
        collectionModal = AllCateModel.fromJson(userData);
      });
    }
    print(responseData);
  }

  _getAllProduct() async {
    var uri = Uri.parse('${baseUrl()}/service_providers');
    var request = new http.MultipartRequest("POST", uri);
    request.fields.addAll({
      'lat': '${currentLocation!.latitude}',
      'long': '${currentLocation!.longitude}'
    });
    print("locationnnnnn ${request.fields}");
    var response = await request.send();
    print(request);
    print(request.fields);
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        allProduct = AllProductModal.fromJson(userData);
      });
    }

    print(responseData);
  }

  _getCart() async {
    setState(() {
      isLoading = true;
    });

    var uri = Uri.parse('${baseUrl()}/get_cart_items');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        getCartModal = GetCartModal.fromJson(userData);
        isLoading = false;
      });
    }
  }

  _getWishList() async {
    var uri = Uri.parse('${baseUrl()}/wishlist');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        likedProduct.clear();
        getWishListModal = GetWishListModal.fromJson(userData);
        for (var i = 0; i < getWishListModal!.wishlist!.length; i++) {
          likedProduct.add(getWishListModal!.wishlist![i].proId.toString());
        }
      });
    }
  }

  _getServiceWishList() async {
    GetServiceWishListModal getServiceWishListModal;
    var uri = Uri.parse('${baseUrl()}/service_wishlist');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        likedService.clear();
        getServiceWishListModal = GetServiceWishListModal.fromJson(userData);
        for (var i = 0; i < getServiceWishListModal.wishlist!.length; i++) {
          likedService
              .add(getServiceWishListModal.wishlist![i].resId.toString());
        }
      });
    }
  }

  String? user_id;
  getUserDataApicall() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    try {
      Map<String, String> headers = {
        'content-type': 'application/x-www-form-urlencoded',
      };
      var map = new Map<String, dynamic>();
      map['user_id'] = user_id ?? "";

      final response = await client.post(Uri.parse("${baseUrl()}/user_data"),
          headers: headers, body: map);
      print("sddddddd ${map} sdsd ${baseUrl()}/user_data");
      var dic = json.decode(response.body);
      Map<String, dynamic> userMap = jsonDecode(response.body);
      model = GetUserModel.fromJson(userMap);

      userEmail = model!.user!.email!;
      userMobile = model!.user!.mobile!;
      userName = model!.user!.username!;
      userPic = model!.user!.profilePic!;
      print("User Data Model Nowwwwwww ${model}");
      // _username.text = model!.user!.username!;
      // _mobile.text = model!.user!.mobile!;
      // _address.text = model!.user!.address!;
      print("GetUserData>>>>>>");
      print(dic);
      setState(() {
        isLoading = false;
      });
    } on Exception {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "No Internet connection");
      throw Exception('No Internet connection');
    }
  }

  DestinationModel? destinationModel;
  getDestination()async{
    var uri = Uri.parse('${baseUrl()}/destinations');
    var request = new http.MultipartRequest("Post", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields.addAll({'user_id': userID});

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    if (mounted) {
      setState(() {
        destinationList.clear();
        destinationModel = DestinationModel.fromJson(userData);
      });
    }
  }


  Future<Null> refreshFunction()async{
    await _getAddressFromLatLng();
    await getUserCurrentLocation();
    await getUserDataFromPrefs();
    await getDestination();
  }
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(appColorOrange);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
      statusBarColor: appColorOrange,
      statusBarBrightness: Brightness.dark,
    ));
    SizeConfig().init(context);
    /*return FancyDrawerWrapper(
      backgroundColor: Colors.white,
      controller: _controller,
      drawerItems: <Widget>[
        applogo(),
        Container(height: 30),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TabbarScreen()),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.home,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Home",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoreScreenNew(back: true)),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.shopping_bag,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Services",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WishListScreen(back: true)),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.favorite,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Wish List",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile(back: true)),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Profile",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationList()),
            );
          },
          child: Row(
            children: [
              Icon(
                Icons.notifications,
                color: Colors.black45,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Notification",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Alert(
              context: context,
              title: "Log out",
              desc: "Are you sure you want to log out?",
              style: AlertStyle(
                  isCloseButton: false,
                  descStyle: TextStyle(fontFamily: "MuliRegular", fontSize: 15),
                  titleStyle: TextStyle(fontFamily: "MuliRegular")),
              buttons: [
                DialogButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "MuliRegular"),
                  ),
                  onPressed: () async {
                    setState(() {
                      userID = '';

                      userEmail = '';
                      userMobile = '';
                      likedProduct = [];
                      likedService = [];
                    });
                   // signOutGoogle();
                    //signOutFacebook();
                    preferences!
                        .remove(SharedPreferencesKey.LOGGED_IN_USERRDATA)
                        .then((_) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => Welcome2(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    });

                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                ),
                DialogButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "MuliRegular"),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(116, 116, 191, 1.0),
                    Color.fromRGBO(52, 138, 199, 1.0)
                  ]),
                ),
              ],
            ).show();
          },
          child: Row(
            children: [
              Icon(
                Icons.settings_power,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Logout",
                  style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal! * 5,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontStyle: FontStyle.italic)),
            ],
          ),
        ),
        Container(height: 100),
      ],
      child: */
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 109,
        systemOverlayStyle: SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: Color(0xFFFFD400),
          systemNavigationBarColor: Color(0xFFFFD400),
          // statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          // statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        leading:  Padding(
          padding: const EdgeInsets.only(bottom: 15.0,left: 5, right: 10),
          child: InkWell(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: CircleAvatar(
                radius: 20,
                child: Image.asset("assets/images/person.png",)
              // Icon(Icons.person, color: appColorOrange, size: 30),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarIconBrightness: Brightness.dark,
        // ),

        actions: [
          Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: serviceWidget1(),
              ),
              servicesWidget(),
              // Container(height: 5),
              // _searchBar(),
            ],
          ),
        ],
        backgroundColor: Colors.grey[200],
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomLeft: Radius.circular(20),
        //         bottomRight: Radius.circular(20)
        //     )
        // ),
        elevation: 0,
        // title:  _searchBar(),
        // Text(appName,
        //     style: TextStyle(
        //         color: backgroundgrey,
        //         fontSize: 22,
        //         fontWeight: FontWeight.bold,
        //         fontFamily: 'OpenSans',
        //         fontStyle: FontStyle.italic)
        // ),
        centerTitle: false,
        // actions: [
        //   // CircleAvatar(
        //   //   radius: 18,
        //   //   backgroundColor: Colors.grey[100],
        //   //   child: IconButton(
        //   //     icon: Icon(
        //   //       Icons.search,
        //   //       color: appColorBlack,
        //   //       size: 20,
        //   //     ),
        //   //     onPressed: () {
        //   //       Navigator.push(
        //   //         context,
        //   //         MaterialPageRoute(builder: (context) => SearchProduct()),
        //   //       );
        //   //     },
        //   //   ),
        //   // ),
        //   // Container(width: 10),
        //   Container(
        //     // height: 10,
        //     width: 40,
        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: appColorOrange),
        //     child: IconButton(
        //       icon: Icon(
        //         Icons.notifications,
        //         color: appColorBlack,
        //         size: 20,
        //       ),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => NotificationList()),
        //         );
        //       },
        //     ),
        //   ),
        //   Container(width: 10),
        // ],
      ),
      drawer: getDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _searchBar(),
            Container(height: 5),
            allServices(context),
          Column(
            children: [
              SingleChildScrollView(
                child: RefreshIndicator(
                  onRefresh: refreshFunction,
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.6,
                    child: ListView(
                      children: <Widget>[
                        // Container(height: 5),
                        // serviceWidget1(),
                        // // Container(height: 5),
                        // servicesWidget(),
                        // Container(height: 5),

                        // collectionWidget(),
                        // Container(height: 20),
                        _banner(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:_buildDots(),
                        ),
                        Container(height: 10),
                        _offerBanners(context),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:_buildDots1(),
                        ),
                        Container(height: 15),
                        Center(child: _toggelButton()),
                        // _radioButton(context),
                        Container(height: 15),
                        _mapLocation(context),
                        Container(height: 10),
                        _locationField(context),
                        InkWell(
                          onTap: () async{
                            distnce();
                            if(pickLat != 0 && pickLong != 0 && dropLat != 0 && dropLong != 0) {
                              await confirmRideDialog(context);
                            }else{
                              Fluttertoast.showToast(msg: "Please select pick and drop locations first!");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                height: 55,
                                width: MediaQuery.of(context).size.width/2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  // borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
                                  color: Colors.black12,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Text("BOOK NOW", style: TextStyle(fontSize: 16, color: appColorGreen, fontWeight: FontWeight.w600)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                        child: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // _CarouselSlider(),
                        // Container(height: 10,),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(left: 19),
                        //       child: Text("All Popular Services", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w700)),
                        //     )
                        // ),
                        SizedBox(height: 9),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 19, top: 8, bottom: 8),
                            child: Row(
                              children: [
                                Image.asset("assets/images/food.png", color: backgroundblack,height: 35, width: 35),
                                SizedBox(width: 5,),
                                Text("FOOD SERVICES", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 235,
                            decoration:  BoxDecoration(
                                image:  DecorationImage(
                                  image:  AssetImage("assets/images/back.png",),
                                  fit: BoxFit.cover
                                  // fit: BoxFit.fitHeight,
                                )
                            ),
                            child: Column(
                              children: [
                                _getCategory(context),
                              ],
                            )),
                        // SizedBox(height: 9),
                       Container(
                         height: 270,
                         decoration:  BoxDecoration(
                             image:  DecorationImage(
                                 image:  AssetImage("assets/images/back.png"),
                                 fit: BoxFit.cover
                               // fit: BoxFit.fitHeight,
                             )
                         ),
                         child: Column(
                           children: [
                             Align(
                                 alignment: Alignment.centerLeft,
                                 child: Padding(
                                     padding: const EdgeInsets.only(left: 19),
                                     child: Row(
                                       children: [
                                         Image.asset("assets/images/mehndi.png", color: backgroundblack,height: 35, width: 35),
                                         SizedBox(width: 5,),
                                         Text("MEHNDI", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700)),
                                       ],),
                                 ),
                             ),
                             _getMehndiCategory(context),
                           ],
                         ),
                       ),
                        // SizedBox(height: 9,),
                        Container(
                          decoration:  BoxDecoration(
                              image:  DecorationImage(
                                  image:  AssetImage("assets/images/back.png"),
                                  fit: BoxFit.cover
                                // fit: BoxFit.fitHeight,
                              )
                          ),
                          child: Column(
                              children: [
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 19),
                                        child: Row(
                                          children: [
                                            Image.asset("assets/images/handyman.png", color: backgroundblack,height: 35, width: 35,),
                                            SizedBox(width: 5,),
                                            Text("HANDYMAN SERVICES", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700)),
                                          ],)
                                    )
                                ),
                                _getHandyManCategory(context),
                              ],
                          ),
                        ),
                        // SizedBox(height: 30,)
                      ],
                    ),

                  ),
                ),

              ),

            ],
          ),

        ],),
      ),
    );
  }
  getDrawer(){
    print("checking user pic ${userPic}");
    return Drawer(
      // backgroundColor: appColorBlack,
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: appColorOrange,
            ), //BoxDecoration
            child: Row(
              children: [
                SizedBox(height: 20),
                userPic == null || userPic == "" ? CircleAvatar(
                  backgroundColor: appColorWhite,
                  radius: 40,
                  child: Icon(Icons.person,),
                ) : CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(userPic),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$userName",
                        style: TextStyle(fontSize: 18, color: backgroundblack),
                      ),
                      Text("$userEmail",
                        style: TextStyle(color: backgroundblack),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), //DrawerHeader
          ListTile(
            leading: Image.asset("assets/images/home.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text(' Home '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/whats new.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text(' Booking'),
            onTap: () {
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                MaterialPageRoute(builder: (context)=> ChatScreen()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.settings, color: backgroundblack,),
          //   title: const Text('Whats New'),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
          //       MaterialPageRoute(builder: (context)=> RequestService()),
          //     );
          //   },
          // ),
          ListTile(
            leading: Image.asset("assets/images/wallet.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text('Wallet'),
            onTap: () {
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                MaterialPageRoute(builder: (context)=> MyWallet()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/whats new.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text('Whats New'),
            onTap: () {
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                MaterialPageRoute(builder: (context)=> MyRequestPage()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/event.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text('Events'),
            onTap: () {
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                MaterialPageRoute(builder: (context)=> WishListScreen(back: true,)),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/about us.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                MaterialPageRoute(builder: (context)=> WishListScreen(back: true,)),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/refferal.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text('Refferal'),
            onTap: () {
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                MaterialPageRoute(builder: (context)=> WishListScreen(back: true,)),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/emergency contact.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text('Emergancy Contact'),
            onTap: () {
              Navigator.push(
                context,
                // MaterialPageRoute(builder: (context) => ChatPage( chatId: "1", title: "Karan")),
                MaterialPageRoute(builder: (context)=> WishListScreen(back: true,)),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/faq.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text(' FAQ '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FaqScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/privacy policy.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text(' Privacy Policy '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/support.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text(' Support'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsConditionScreen()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/images/claim.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text(' Claim '),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FaqScreen()),
              );
            },
          ),
          /// Only for Testing
          // ListTile(
          //   leading: const Icon(Icons.list_alt, color: backgroundblack,),
          //   title: const Text(' Testing '),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => HomePage()),
          //     );
          //   },
          // ),
          ListTile(
            leading: Image.asset("assets/images/logout.png", color: backgroundblack, height: 30, width: 30,),
            title: const Text('LogOut'),
            onTap: () {
              // Alert(
              //   context: context,
              //   title: "Log out",
              //   desc: "Are you sure you want to log out?",
              //   style: AlertStyle(
              //       isCloseButton: false,
              //       descStyle: TextStyle(fontFamily: "MuliRegular", fontSize: 15),
              //       titleStyle: TextStyle(fontFamily: "MuliRegular")),
              //   buttons: [
              //     DialogButton(
              //       child: Text(
              //         "OK",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16,
              //             fontFamily: "MuliRegular"),
              //       ),
              //       onPressed: () async {
              //         setState(() {
              //           userID = '';
              //           userEmail = '';
              //           userMobile = '';
              //           likedProduct = [];
              //           likedService = [];
              //         });
              //         // signOutGoogle();
              //         //signOutFacebook();
              //         preferences!
              //             .remove(SharedPreferencesKey.LOGGED_IN_USERRDATA)
              //             .then((_) {
              //           Navigator.of(context).pushAndRemoveUntil(
              //             MaterialPageRoute(
              //               builder: (context) => Welcome2(),
              //             ),
              //                 (Route<dynamic> route) => false,
              //           );
              //         });
              //         Navigator.of(context, rootNavigator: true).pop();
              //       },
              //       color: backgroundblack,
              //       // color: Color.fromRGBO(0, 179, 134, 1.0),
              //     ),
              //     DialogButton(
              //       child: Text(
              //         "Cancel",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 16,
              //             fontFamily: "MuliRegular"),
              //       ),
              //       onPressed: () {
              //         Navigator.of(context, rootNavigator: true).pop();
              //       },
              //       color: backgroundblack,
              //       // gradient: LinearGradient(colors: [
              //       //   Color.fromRGBO(116, 116, 191, 1.0),
              //       //   Color.fromRGBO(52, 138, 199, 1.0)
              //       // ]),
              //     ),
              //   ],
              // ).show();
            },
          ),
          Divider(),
          Text("Follow Us")
        ],
      ),
    );
  }
  double totalDistance = 0;
  distnce (){
    totalDistance =  calculateDistance(pickLat, pickLong, dropLat, dropLong);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    try {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
      return 12742 * asin(sqrt(a));
    } on Exception catch (exception) {
      return 0; // only executed if error is of type Exception
    } catch (error) {
      return 0; // executed for errors of all types other than Exception
    }
  }

  RideCalculationModel? rideCalcData;
  String? userId;

  calculateRidePrice() async {
    print("Api Working");
    var headers = {
      'Cookie': 'ci_session=d9be05064d0216a7432b621660dc26feb4d030ed'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/price_culculation_ride'));
    request.fields.addAll({
      'distance': '${calculateDistance(pickLat, pickLong, dropLat, dropLong).toString()}'
    });
    print("this is ride calculation param ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Working Nowwwww");
      var finalResponse = await response.stream.bytesToString();
      rideCalcData = RideCalculationModel.fromJson(jsonDecode(finalResponse));
      print("this is ride calculation data ${rideCalcData!.subTotal.toString()}");
    }
    else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  confirmRideBook() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("user_id");
    print("Api Working");
    var headers = {
      'Cookie': 'ci_session=d9be05064d0216a7432b621660dc26feb4d030ed'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/ride_booking'));
    request.fields.addAll({
      'user_id':'${userId.toString()}',
      'transaction_type':'cash',
      'paid_amount':'${rideCalcData!.finalTotal.toString()}',
      'amount': '${rideCalcData!.subTotal.toString()}',
      'pickup_location': pickUpController.text.toString(),
      'drop_location':dropController.text.toString(),
      'distance': '${calculateDistance(pickLat, pickLong, dropLat, dropLong).toString()}',
      'latitude': '${pickLat.toString()}',
      'longitude':'${pickLong.toString()}',
      'drop_latitude':'${dropLat.toString()}',
      'drop_longitude': '${dropLong.toString()}',
      'gst_charge':'${rideCalcData!.gstCharge.toString()}',
      'culculate_gst_amount':'${rideCalcData!.gst.toString()}',
      'gst_type':'${rideCalcData!.gstType.toString()}',

    });
    print("this is ride booking param ---===>> ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print("Working Nowwwww");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      if(jsonResponse['status']){
        Fluttertoast.showToast(msg: "${jsonResponse['message'].toString()}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => FindingRidePage(
            LatLng(pickLat, pickLong),
            LatLng(dropLat, dropLong),
            pickUpController.text,
            dropController.text,
            "Cash",
            "",
            '${rideCalcData!.finalTotal.toString()}',
            '${totalDistance.toStringAsFixed(2)}'
        )));
      }
      // print("this is ride calculation data ${rideCalcData!.subTotal.toString()}");
    }
    else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  Future<void> confirmRideDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              content: Container(
                height: MediaQuery.of(context).size.height/2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle
                              ),
                            ),
                          ),
                          const SizedBox(width: 6,),
                          Container(
                            width: MediaQuery.of(context).size.width - 70,
                            child: Text("${pickUpController.text.toString()}",
                              maxLines: 2,
                              style: TextStyle(
                              ),
                              overflow: TextOverflow.ellipsis,),
                          )
                        ],
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle
                              ),
                            ),
                          ),
                          const SizedBox(width: 6,),
                          Container(
                            width: MediaQuery.of(context).size.width - 70,
                            child: Text("${dropController.text.toString()}",
                                maxLines: 2,
                                style: TextStyle(
                                ),
                                overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                      Divider(),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Distance : ", style: TextStyle(
                              fontWeight: FontWeight.w600
                          ),),
                          Text('${totalDistance.toStringAsFixed(2)} km')
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price : ", style: TextStyle(
                                fontWeight: FontWeight.w600
                            ),),
                            Text('₹ ${rideCalcData!.subTotal.toString()}')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only( bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("GST Charge (${rideCalcData!.gstCharge.toString()}%) : ", style: TextStyle(
                                fontWeight: FontWeight.w600
                            ),),
                            Text('₹ ${rideCalcData!.gst.toString()}')
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.only( bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total : ", style: TextStyle(
                                fontWeight: FontWeight.w600
                            ),),
                            Text('₹ ${rideCalcData!.finalTotal.toString()}')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: InkWell(
                          onTap: (){
                            confirmRideBook();
                          },
                          child: Container(
                            height: 43,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),  color: appColorOrange),
                            child:
                            Center(
                                child: Text("Confirm", style: TextStyle(fontSize: 18, color: backgroundblack))
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Confirm Ride Request", style: TextStyle(
                    color: backgroundblack, fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appColorOrange
                      ),
                      child: Icon(Icons.clear, color: backgroundblack, size: 14,),
                    ),
                  )
                ],
              ),
              // actions: <Widget>[
              //   InkWell(
              //     child: Text('OK   '),
              //     onTap: () {
              //       // if (_formKey.currentState.validate()) {
              //         // Do something like updating SharedPreferences or User Settings etc.
              //         Navigator.of(context).pop();
              //       // }
              //     },
              //   ),
              // ],
            );
          });
        });
  }

  Widget applogo() {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: 50,
        ),
        SizedBox(
          height: 10,
        ),
        Text(appName,
            style: TextStyle(
                color: appColorBlack,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
                fontStyle: FontStyle.italic)),
        SizedBox(
          height: 5,
        ),
        Text('Your Hygiene App',
            style: TextStyle(
              color: appColorBlack,
              fontSize: 12,
            )),
      ],
    );
  }

  _searchBar() {
    return GestureDetector(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchProduct()));
        },
        child: Container(
          width: double.infinity,
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
            child: Container(

                height: 45,
                width: MediaQuery.of(context).size.width/1.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: Colors.black),
                    color: Colors.white),
                // padding: EdgeInsets.symmetric(vertical: 8),
                // color: Theme.of(context).colorScheme.white,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.search, color: appColorOrange,))
              // ListTile(
              //   dense: true,
              //   // minLeadingWidth: 10,
              //   leading: Icon(
              //     Icons.search, color: appColorOrange,
              //   ),
              // trailing: Icon(Icons.cancel_outlined, color: Colors.black),
              // title: Text("Search", style: TextStyle(fontSize: 16, color:backgroundblack)),
              // ),
            ),
          ),
        ),
      ),
    );
  }

  Widget serviceWidget1() {
    return
      Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // InkWell(
            //   onTap: () {
            //     scaffoldKey.currentState!.openDrawer();
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(border: Border.all(color: Colors.red), borderRadius: BorderRadius.circular(90)),
            //     // child: CircleAvatar(
            //     //   radius: 20,
            //     //   child: Image.asset("assets/images/person.png",)
            //     //   // Icon(Icons.person, color: appColorOrange, size: 30),
            //     // ),
            //   ),
            // ),
            // SizedBox(width: 15),
            Image.asset("assets/images/sod.png", scale: 2.7),
            SizedBox(width: 33),
            // Center(
            //   child: Text("SERVICE ON DEMAND",
            //     style: TextStyle(fontSize: 17, color: backgroundblack, fontWeight: FontWeight.w700),
            //   ),
            // ),

            IconButton(
              icon: Icon(
                Icons.notifications_active,
                color: backgroundblack,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationList()),
                );
              },
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.wallet, color: backgroundblack,size: 30,))

          ],
        ),
      );
  }

  Widget allServices(BuildContext context) {
    return
      getMainCatModel == null ? Center(
        child: Image.asset("assets/images/loader1.gif", scale: 1),
      ) :
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height:70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, border: Border.all(color: Colors.grey, width: 1)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    children: [
                      // CircleAvatar(
                      //     radius: 20,
                      //     // backgroundColor: backgroundblack,
                      //     backgroundImage: NetworkImage("${getMainCatModel!.data!.orderFood}")
                      // ),
                      Image.network("${getMainCatModel!.data!.orderFood}", scale: 30, color: lightBlack),
                      Text("Order Food", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  // ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  //  // radius: 40,
                  // child: Image.network("${getMainCatModel!.data!.orderFood}", height: 20, width: 20, fit: BoxFit.fill,)
                  // ),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      // CircleAvatar(
                      //     radius: 20,
                      //     backgroundColor: backgroundblack,
                      //     backgroundImage: NetworkImage("${getMainCatModel!.data!.bookRide}")
                      // ),
                      Image.network("${getMainCatModel!.data!.bookRide}", scale: 30, color: lightBlack),
                      Text("Book Ride", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(children: [
                    // CircleAvatar(
                    //     radius: 20,
                    //     backgroundColor: Colors.grey,
                    //     backgroundImage: NetworkImage("${getMainCatModel!.data!.sendPackge}")
                    // ),
                    Image.network("${getMainCatModel!.data!.sendPackge}", scale: 30, color: lightBlack),
                    Text("Send Package", style: TextStyle(color: Colors.black)),
                  ],),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      // CircleAvatar(
                      //     radius: 20,
                      //     backgroundColor: backgroundblack,
                      //     backgroundImage: NetworkImage("${getMainCatModel!.data!.handyman}")
                      // ),
                      Image.network("${getMainCatModel!.data!.handyman}", scale: 30, color: lightBlack),
                      Text("Handy Man", style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  SizedBox(width: 20,),
                  Column(
                    children: [
                      // CircleAvatar(
                      //     radius: 20,
                      //     backgroundColor: backgroundblack,
                      //     backgroundImage: NetworkImage("${getMainCatModel!.data!.mehndi}")
                      // ),
                      Image.network("${getMainCatModel!.data!.mehndi}", scale: 30, color: lightBlack),
                      Text("Mehndi", style: TextStyle(color:Colors.black)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }


  Widget servicesWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 90),
          child: Row(
            children: [
              Image.asset("assets/images/locationactive.png", height: 16, width: 16,),
              SizedBox(width: 4),
              Container(
                // width: MediaQuery.of(context).size.width/1.1,
                child: Text(
                  _currentAddress != null
                      ? _currentAddress!
                      : "please wait..",overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
              ),
              // Container(
              //   width: 5,
              // ),
            ],
          ),
        ),
      ],
    );
  }

  Widget serviceWidget() {
    return sortingModel == null
        ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1,),
    )
        : sortingModel!.restaurants!.length > 0
        ? ListView.builder(
      padding: EdgeInsets.only(
        bottom: 10,
        top: 10,
      ),
      itemCount: sortingModel!.restaurants!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, int index,) {
        return InkWell(
          onTap: () {
            print("first here ${sortingModel!.restaurants![index].resId}");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    resId: sortingModel!.restaurants![index].resId,
                  )),
            );
          },
          child: Padding(
            padding:  EdgeInsets.only(right: 10),
            child:  Padding(
              padding:  EdgeInsets.only(top: 30),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: 200,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 110,
                        width: 200,
                        // child: Carousel(
                        //   images: sortingModel!.restaurants
                        //       ![index].logo!.map((it) {
                        //     return Container(
                        //         height: 110,
                        //          width: 170,
                        //       child: ClipRRect(
                        //         borderRadius: BorderRadius.only(
                        //             topLeft: Radius.circular(8),
                        //             topRight: Radius.circular(8)),
                        //         child: CachedNetworkImage(
                        //           imageUrl: it,
                        //           imageBuilder: (context, imageProvider) => Container(
                        //             decoration: BoxDecoration(
                        //               image: DecorationImage(
                        //                 image: imageProvider,
                        //                 fit: BoxFit.fill,
                        //               ),
                        //             ),
                        //           ),
                        //           placeholder: (context, url) => Center(
                        //             child: Container(
                        //               height: 110,
                        //               width: 100,
                        //               // margin: EdgeInsets.all(70.0),
                        //               child: CircularProgressIndicator(
                        //                 strokeWidth: 2.0,
                        //                 valueColor: new AlwaysStoppedAnimation<Color>(
                        //                     appColorGreen),
                        //               ),
                        //             ),
                        //           ),
                        //           errorWidget: (context, url, error) => Icon(Icons.error),
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     );
                        //   }).toList(),
                        //   showIndicator: true,
                        //   dotBgColor: Colors.transparent,
                        //   borderRadius: false,
                        //   autoplay: false,
                        //   dotSize: 4.0,
                        //   dotSpacing: 15.0,
                        // ),
                      ),
                      // Container(
                      //   height: 100,
                      //    width: 170,
                      //   decoration: BoxDecoration(
                      //     color: Colors.black45,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      //     child: Image.network("${sortingModel!
                      //         .restaurants![index].logo![0] }",fit: BoxFit.fill,),
                      //   ),
                      // ),
                      Padding(
                        padding:  EdgeInsets.only(left: 5,top: 5,right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2.7,
                              child: Text(
                                sortingModel!.restaurants![index].resName![0].toUpperCase() + sortingModel!.restaurants![index].resName!.substring(1),
                                maxLines: 2,
                                style: TextStyle(
                                    color: appColorBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "${sortingModel!.restaurants![index].cityName}",
                              maxLines: 1,
                              style: TextStyle(
                                  color: appColorBlack,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Container(height: 5),
                      Padding(
                        padding:  EdgeInsets.only(left: 5,right: 5,bottom: 5),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   width: 130,
                            //   child: Text(
                            //     sortingModel!.restaurants![index].resDesc!,
                            //     maxLines: 1,
                            //     style: TextStyle(
                            //         color: appColorBlack,
                            //         fontSize: 12,
                            //         height: 1.2,
                            //         fontWeight: FontWeight.normal),
                            //   ),
                            // ),
                            // SizedBox(height: 3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹" +
                                      sortingModel!
                                          .restaurants![index]
                                          .price!,
                                  style: TextStyle(
                                      color: appColorBlack,
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                                // RatingBar.builder(
                                //   initialRating: sortingModel!.restaurants![index].resRating == "" ? 0.0 : double.parse(sortingModel!.restaurants![index].resRating.toString()),
                                //   minRating: 0,
                                //   direction: Axis.horizontal,
                                //   allowHalfRating: true,
                                //   itemCount: 5,
                                //   itemSize: 15,
                                //   ignoreGestures: true,
                                //   unratedColor: Colors.grey,
                                //   itemBuilder: (context, _) =>
                                //       Icon(Icons.star, color: appColorOrange),
                                //   onRatingUpdate: (rating) {
                                //     print(rating);
                                //   },
                                // ),
                              ],
                            ),
                            InkWell(
                              onTap: (){

                              },
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Book Service",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Stack(
            //    alignment: Alignment.topCenter,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(top: 30),
            //       child: Card(
            //         elevation: 5,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Container(
            //           width: 170,
            //           child: Padding(
            //             padding:  EdgeInsets.only(
            //                 bottom: 15, left: 15, right: 15),
            //             child: Column(
            //               crossAxisAlignment:
            //                   CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.end,
            //               children: [
            //                 Container(
            //                   height: 100,
            //                   width: 140,
            //                   alignment: Alignment.topCenter,
            //                   decoration: BoxDecoration(
            //                     color: Colors.black45,
            //                     borderRadius: BorderRadius.circular(10),
            //                     image: DecorationImage(
            //                       image: NetworkImage(sortingModel!
            //                           .restaurants![index].allImage![0]),
            //                       fit: BoxFit.cover,
            //                     ),
            //                   ),
            //                 ),
            //                 Text(
            //                   sortingModel!.restaurants![index].resName!,
            //                   maxLines: 1,
            //                   style: TextStyle(
            //                       color: appColorBlack,
            //                       fontSize: 14,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //                 Container(height: 8),
            //                 Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   crossAxisAlignment:
            //                       CrossAxisAlignment.end,
            //                   children: [
            //                     Column(
            //                       crossAxisAlignment:
            //                           CrossAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           width: 130,
            //                           child: Text(
            //                             sortingModel!.restaurants![index].resDesc!,
            //                             maxLines: 2,
            //                             style: TextStyle(
            //                                 color: appColorBlack,
            //                                 fontSize: 12,
            //                                 height: 1.2,
            //                                 fontWeight: FontWeight.normal),
            //                           ),
            //                         ),
            //                         Text(
            //                           "₹" +
            //                               sortingModel!
            //                                   .restaurants![index]
            //                                   .price!,
            //                           style: TextStyle(
            //                               color: appColorBlack,
            //                               fontSize: 16,
            //                               fontWeight:
            //                                   FontWeight.bold),
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     // Container(
            //     //   height: 100,
            //     //   width: 140,
            //     //   alignment: Alignment.topCenter,
            //     //   decoration: BoxDecoration(
            //     //     color: Colors.black45,
            //     //     borderRadius: BorderRadius.circular(10),
            //     //     image: DecorationImage(
            //     //       image: NetworkImage(sortingModel!
            //     //           .restaurants![index].allImage![0]),
            //     //       fit: BoxFit.cover,
            //     //     ),
            //     //   ),
            //     // ),
            //   ],
            // ),
          ),
        );
      },
    )
        : Center(
      child: Text(
        "Don't have any services",
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _mapLocation(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      // decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 7)),
      child: GoogleMap(
        zoomGesturesEnabled: true,
        initialCameraPosition: CameraPosition(
          target: showLocation,
          zoom: 10.0,
        ),
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }


  Widget _locationField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 8, bottom: 5),
          child: Text("Pickup Location", style: TextStyle(
              color: appColorWhite
          ),),
        ),
        Container(
          // height: 50,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: TextFormField(
            controller: pickUpController,
            readOnly: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlacePicker(
                    apiKey: Platform.isAndroid
                        ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
                        : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
                    onPlacePicked: (result) {
                      print(result.formattedAddress);
                      setState(() {
                        pickUpController.text = result.formattedAddress.toString();
                        pickLat = result.geometry!.location.lat;
                        pickLong = result.geometry!.location.lng;
                      });
                      Navigator.of(context).pop();
                      distnce();
                    },
                    initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
                    useCurrentLocation: true,
                  ),
                ),
              );
            },
            decoration:
            InputDecoration(
              // labelText: "Pickup Location",
              filled: true,
              //fillColor: appColorOrange,
              hintText: "Pickup Location",
              prefixIcon: Icon(Icons.search,color: appColorBlack,),
              suffixIcon: Icon(Icons.clear,color: appColorBlack),
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 1, bottom: 5),
          child: Text("Drop Location", style: TextStyle(
              color: appColorWhite
          ),),
        ),
        Container(
          // height: 60,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: TextFormField(
            controller: dropController,
            readOnly: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlacePicker(
                    apiKey: Platform.isAndroid
                        ? "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA"
                        : "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
                    onPlacePicked: (result) {
                      print(result.formattedAddress);
                      setState(() {
                        dropController.text =
                            result.formattedAddress.toString();
                        dropLat = result.geometry!.location.lat;
                        dropLong = result.geometry!.location.lng;
                      });
                      Navigator.of(context).pop();
                    },
                    initialPosition: dropLat != 0
                        ? LatLng(dropLat, dropLong)
                        : LatLng(currentLocation!.latitude, currentLocation!.longitude),
                    useCurrentLocation: true,
                  ),
                ),
              );
            },
            decoration: InputDecoration(
              // labelText: "Drop Location",
              hintText: "Drop Location",
              enabledBorder: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search,color: appColorBlack,),
              suffixIcon: Icon(Icons.clear,color: appColorBlack),
              filled: true,
              focusedBorder: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // _getPickLocation() async {
  //   LocationResult result = await Navigator.push(context, MaterialPageRoute(builder: (context)=> PlacePicker(
  //     "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
  //   )));
  //   // Navigator.of(context).push(MaterialPageRoute(
  //   //     builder: (context) => PlacePicker(
  //   //       "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
  //   //     )));
  //   print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
  //   setState(() {
  //     pickUpController.text = result.formattedAddress.toString();
  //     cityC.text = result.locality.toString();
  //     stateC.text = result.administrativeAreaLevel1!.name.toString();
  //     countryC.text = result.country!.name.toString();
  //     lat = result.latLng!.latitude;
  //     long = result.latLng!.longitude;
  //     pincodeC.text = result.postalCode.toString();
  //   });
  // }

  Widget _getCategory(BuildContext context){
    print("Food Services ${foodCategoryModel}");
    return foodCategoryModel == null ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1),
    ) :
    Container(
      height: 230,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foodCategoryModel!.product!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio:4.7 / 5.0,
          crossAxisCount: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails(id: foodCategoryModel!.product![index].id)));
            },
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                    color: Colors.white,
                    elevation: 1,
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                          color: backgroundgrey, width: 2
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Center(
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: appColorOrange,
                        //         borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                        //     height: 80,width: 5,
                        //   ),
                        // ),
                        // SizedBox(width: 5),
                        Container(
                            height: 140,
                            width: MediaQuery.of(context).size.width/1.7,
                            child: Image.network("${foodCategoryModel!.product![index].profileImage}", height: 50, width: 50, fit: BoxFit.fill,)
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 7, top: 5),
                              child: Text("${foodCategoryModel!.product![index].storeDescription}"
                                  ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 16)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("${foodCategoryModel!.product![index].description}"
                                  ,style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 16)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset("assets/images/location2.png", color: backgroundblack, height: 18, width: 18),
                            ),
                            SizedBox(width: 3),
                            Container(
                              width: 160,
                              child: Text("${foodCategoryModel!.product![index].address}",
                                overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: appColorBlack),
                              ),
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 30),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 8),
                        //         child: Text("${foodCategoryModel!.product![index].uname}",style: TextStyle(color: backgroundgrey,fontWeight: FontWeight.bold,fontSize: 18),
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 7),
                        //         child: Text("${foodCategoryModel!.product![index].storeDescription}" ,style: TextStyle(color: backgroundgrey,fontWeight: FontWeight.bold,fontSize: 13)),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 2.5),
                        //         child: Container(
                        //             alignment: Alignment.topLeft,
                        //             margin: EdgeInsets.all(0),
                        //             width: 180,
                        //             child: Row(
                        //               children: [
                        //               Image.asset("assets/images/location2.png", color: appColorOrange, height: 18, width: 18),
                        //               SizedBox(width: 3),
                        //               Container(
                        //                 width: 80,
                        //                   child: Text("${foodCategoryModel!.product![index].address}", overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: Colors.white),),
                        //               ),
                        //             ],
                        //             ),
                        //             // Text("",overflow: TextOverflow.ellipsis,maxLines: 4,)
                        //         ),
                        //       ),
                        //       // Text("${foodCategoryModel!.product![index].description}", style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14)),
                        //     ],
                        //   ),
                        // ),
                        Spacer(),
                        // Center(
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: appColorOrange,
                        //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
                        //     height: 80,width: 8),
                        // ),
                      ],
                    ))),
          );
        },
      ),
    );
  }


  Widget _getMehndiCategory(BuildContext context){
    print("Mehndi Category ${mehndiCategoryModel}");
    return mehndiCategoryModel == null ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1),
    ) : InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SubCategoryScreen()));
      },
      child: Container(
        height: 230,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mehndiCategoryModel!.imgssss!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio:4.7 / 5.0,
            crossAxisCount: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                    color: Colors.white,
                    elevation: 1,
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                          color: backgroundgrey, width: 2
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Center(
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: appColorOrange,
                        //         borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                        //     height: 80,width: 5,
                        //   ),
                        // ),
                        // SizedBox(width: 5),
                        Container(
                          height: 140,
                          // width: double.infinity,
                          child: Stack(
                            children: [
                              mehndiCategoryModel == null
                                  ? Center(
                                child: Image.asset("assets/images/loader1.gif", scale: 1),
                              ) :
                              Image.network("${mehndiCategoryModel!.imgssss![index].otherImg}", fit: BoxFit.fill),
                              // SizedBox(height: 190,),
                              Center(
                                child: ImageSlideshow(
                                  width: double.infinity,
                                  // height: 170,
                                  initialPage: 0,
                                  // indicatorColor: appColorOrange,
                                  // indicatorBackgroundColor: Colors.grey,
                                  children: mehndiCategoryModel!.imgssss![index].otherImg!.map((item) =>
                                      CachedNetworkImage(
                                        imageUrl: item, fit: BoxFit.fill,
                                        placeholder: (context, url) => Center(
                                          child: Container(
                                            margin: EdgeInsets.all(70.0),
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => Container(
                                          height: 5, width: 5,
                                          child: Icon(
                                            Icons.error,
                                          ),
                                        ),
                                      ),)
                                      .toList(),
                                  onPageChanged: (value) {
                                    print('Page changed: $value');
                                  },
                                ),
                              ),
                            ],
                          ),
                          // child: mehndiCategoryModel!.imgssss![index].img == null || mehndiCategoryModel!.imgssss![index].img == "" ? Center(child: Image.asset("assets/images/loader1.gif", height: 20, width: 20,),
                          // ):
                          // Image.network("${mehndiCategoryModel!.imgssss![index].otherImg![index]}",
                          // ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("${mehndiCategoryModel!.imgssss![index].cName}"
                                ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 16)
                            ),
                          ],
                        ),
                        Spacer(),
                      ],
                    )));
          },
        ),
      ),
    );
  }

  Widget _getHandyManCategory(BuildContext context){
    print("Hnady Man ${handyManModel}");
    return handyManModel == null ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1,),
    )
        :Container(
      height: 230,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: handyManModel!.imgssss!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio:4.7 / 5.0,
          crossAxisCount: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.all(5),
              child: Card(
                  color: Colors.white,
                  elevation: 1,
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                        color: backgroundgrey, width: 2
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Center(
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         color: appColorOrange,
                      //         borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                      //     height: 80,width: 5,
                      //   ),
                      // ),
                      // SizedBox(width: 5),
                      Container(
                        height: 140,
                        // width: double.infinity,
                        child: Stack(
                          children: [
                            handyManModel == null
                                ? Center(
                              child: Image.asset("assets/images/loader1.gif", scale: 1),
                            ) :
                            Image.network("${handyManModel!.imgssss![index].otherImg}", fit: BoxFit.fill),
                            // SizedBox(height: 190,),
                            Center(
                              child: ImageSlideshow(
                                width: double.infinity,
                                // height: 170,
                                initialPage: 0,
                                // indicatorColor: appColorOrange,
                                // indicatorBackgroundColor: Colors.grey,
                                children: handyManModel!.imgssss![index].otherImg!.map((item) =>
                                    CachedNetworkImage(
                                      imageUrl: item, fit: BoxFit.fill,
                                      placeholder: (context, url) => Center(
                                        child: Container(
                                          margin: EdgeInsets.all(70.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) => Container(
                                        height: 5, width: 5,
                                        child: Icon(
                                          Icons.error,
                                        ),
                                      ),
                                    ),)
                                    .toList(),
                                onPageChanged: (value) {
                                  print('Page changed: $value');
                                },
                              ),
                            ),
                          ],
                        ),
                        // child: mehndiCategoryModel!.imgssss![index].img == null || mehndiCategoryModel!.imgssss![index].img == "" ? Center(child: Image.asset("assets/images/loader1.gif", height: 20, width: 20,),
                        // ):
                        // Image.network("${mehndiCategoryModel!.imgssss![index].otherImg![index]}",
                        // ),
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(height: 7,),
                          Center(
                            child: Center(
                              child: Text("${handyManModel!.imgssss![index].cName}"
                                  ,style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 16)
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  )));
        },
      ),
    );
  }


  Widget _offerBanners(BuildContext context){
    print("offer Banners ${offerBannerModel?.title}");
    return offerBannerModel == null
        ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1,),
    ) :
    Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("${offerBannerModel!.title!}", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w700),),
            )
        ),
        SizedBox(height: 5,),
        // Spacer(),
        _CarouselSlider(),
      ],
    );
    //     : ImageSlideshow(
    //   width: MediaQuery.of(context).size.width/1.1,
    //   height: 180,
    //   initialPage: 0,
    //   indicatorColor: appColorOrange,
    //   indicatorBackgroundColor: Colors.grey,
    //   children: offerBannerModel!.banners!
    //       .map(
    //         (item) => Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 10),
    //       child: ClipRRect(
    //           borderRadius: BorderRadius.circular(20),
    //           child: CachedNetworkImage(
    //             imageUrl: item,
    //             fit: BoxFit.cover,
    //             placeholder: (context, url) => Center(
    //               child: Container(
    //                 margin: EdgeInsets.all(70.0),
    //                 child: CircularProgressIndicator(),
    //               ),
    //             ),
    //             errorWidget: (context, url, error) => Container(
    //               height: 5,
    //               width: 5,
    //               child: Icon(
    //                 Icons.error,
    //               ),
    //             ),
    //           )),
    //     ),
    //   )
    //       .toList(),
    //   onPageChanged: (value) {
    //     print('Offer banner changed here: $value');
    //   },
    // );
  }
  List<Widget> _buildDots1() {
    List<Widget> dots = [];
    if (offerBannerModel == null) {
    } else {
      for (int i = 0; i < offerBannerModel!.banners!.length; i++) {
        dots.add(
          Container(
            margin: EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ? backgroundblack : appColorOrange,
            ),
          ),
        );
      }
    }
    return dots;
  }


  Widget _toggelButton( ){
    return ToggleSwitch(
      minWidth: 50,
      minHeight: 30,
      cornerRadius: 20.0,
      activeBgColors: [[Colors.yellow], [Colors.yellow]],
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.blue,
      // activeThumbImage: const AssetImage('assets/happy_emoji.png'),
      // labels: ["${CustomIcons.img}","${CustomIcons.img1}"],
      customIcons: [
        Icon(Boxicons.bx_abacus),
        // Icon(
        //   FontAwesomeIcons.box,
        //   color: Colors.white,
        //   size: 25.0,
        // ),
        Icon(
          FontAwesomeIcons.motorcycle,
          color: Colors.black,
          size: 25.0,
        ),
      ],
      inactiveFgColor: Colors.white,
      initialLabelIndex:status == "Active" ? 1 : 0,
      totalSwitches: 2,
      // labels: ['${getTranslated(context, 'no')}', '${getTranslated(context, 'yes')}'],
      radiusStyle: true,
      onToggle: (index) {
        print('switched to: $index');
        if(index == 0){
          status = "Inactive";
        }
        else{
          status = "Active";
        }
        setState(() {
        });
      },
    );
  }

  Widget _radioButton(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // InkWell(
        //   onTap: () {},
        //   child: Container(
        //     height: 45,
        //     width: 85,
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        //         color: backgroundblack,
        //     ),
        //     child: Center(child: Text("BOOK \nRIDE", style: TextStyle(color:appColorOrange, fontWeight: FontWeight.w500),)),
        //   ),
        // ),
        ToggleSwitch(
          minWidth: 50.0,
          cornerRadius: 40.0,
          activeBgColors: [[Color(0xFF0047AF)!], [Color(0xFFFFD400)!]],
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          initialLabelIndex: 1,
          totalSwitches: 2,
          // labels: ['True', 'False'],
          radiusStyle: true,
          onToggle: (index) {
            print('switched to: $index');
          },
        ),
        // InkWell(
        //   onTap: () {
        //     Navigator.push(context, MaterialPageRoute(builder: (context) =>Sendpackage()));
        //   },
        //   child: Container(
        //     height: 45,
        //     width: 85,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30)),
        //       color: backgroundblack,
        //     ),
        //     child: Center(child: Text("SEND \nPACKAGE", style: TextStyle(color: appColorOrange, fontWeight: FontWeight.w500))),
        //   ),
        // ),
      ],
    );
    // return Padding(
    //   padding: const EdgeInsets.all(15),
    //   child: Row(
    //     children: [
    //       Image.asset("assets/images/bike.png", scale: 1.4,),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         // crossAxisAlignment: CrossAxisAlignment.center,
    //         // mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Container(
    //             width: 20,
    //             height: 20,
    //             margin: EdgeInsets.only(left: 5, right: 5),
    //             child: Radio(
    //                 value: 1,
    //                 fillColor: MaterialStateColor.resolveWith((states) => backgroundblack),
    //                 groupValue: _value1,
    //                 onChanged: (int? value) {
    //                   setState(() {
    //                     _value1 = value!;
    //                     // roleUser = true;
    //                     // isUpi = false;
    //                   });
    //                 }),
    //           ),
    //           Text(
    //             "Book a Ride",
    //             style: TextStyle(
    //                 color: backgroundblack, fontSize: 15),
    //           ),
    //           const SizedBox(width: 25),
    //           Image.asset("assets/images/message.png", scale: 1.4),
    //           Container(
    //             width: 20,
    //             height: 20,
    //             margin: EdgeInsets.only(left: 5, right: 5),
    //             child: Radio(
    //                 value: 2,
    //                 fillColor: MaterialStateColor.resolveWith((states) => backgroundblack),
    //                 groupValue: _value1,
    //                 onChanged: (int? value) {
    //                   setState(() {
    //                     _value1 = value!;
    //                     // roleUser = true;
    //                     // isUpi = false;
    //                   });
    //                 }),
    //           ),
    //           InkWell(
    //             onTap: () {
    //               Navigator.push(context, MaterialPageRoute(builder: (context) => SendPackage()));
    //             },
    //             child: Text(
    //               "Send Package",
    //               style: TextStyle(
    //                   color: backgroundblack,
    //                   fontSize: 15
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }


  Widget _banner(BuildContext context) {
    print("Banners ${bannerModal}");
    return bannerModal == null
        ?
    Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1,),
    )
        :  Container(
      height: 225,
      child: Stack(
        children: [
          backBannerModel == null
              ? Center(
            child: Image.asset("assets/images/loader1.gif", scale: 1,),
          ) :
          Image.network("${backBannerModel!.data!.banner}", height: 150, width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
          // SizedBox(height: 190,),
          Positioned(
            top: 1,
            bottom: 1,
            // left: 5,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
              width: MediaQuery.of(context).size.width,
              // height: 200,
              child: _CarouselSlider2(),
            ),
            // ImageSlideshow(
            //   width: MediaQuery.of(context).size.width/1.1,
            //   height: 170,
            //   initialPage: 0,
            //   // indicatorColor: appColorOrange,
            //   // indicatorBackgroundColor: Colors.grey,
            //   children: bannerModal!.banners!
            //       .map((item) => Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 7),
            //     child: ClipRRect(
            //         borderRadius: BorderRadius.circular(20),
            //         child: CachedNetworkImage(
            //           imageUrl: item, fit: BoxFit.cover,
            //           placeholder: (context, url) => Center(
            //               child: Container(
            //                 margin: EdgeInsets.all(70.0),
            //                 child: CircularProgressIndicator(),
            //               )),
            //           errorWidget: (context, url, error) => Container(
            //             height: 5, width: 5,
            //             child: Icon(
            //               Icons.error,
            //             ),
            //           ),
            //         )),
            //   ),)
            //       .toList(),
            //   onPageChanged: (value) {
            //     print('Page changed: $value');
            //   },
            // ),
          ),
        ],
      ),
    );
    // ImageSlideshow(
    //         width: MediaQuery.of(context).size.width/1.1,
    //         height: 200,
    //         initialPage: 0,
    //         indicatorColor: appColorOrange,
    //         indicatorBackgroundColor: Colors.grey,
    //         children: bannerModal!.banners!
    //             .map(
    //               (item) => Padding(
    //                 padding: const EdgeInsets.symmetric(horizontal: 10),
    //                 child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(20),
    //                     child: CachedNetworkImage(
    //                       imageUrl: item,
    //                       fit: BoxFit.cover,
    //                       placeholder: (context, url) => Center(
    //                         child: Container(
    //                           margin: EdgeInsets.all(70.0),
    //                           child: CircularProgressIndicator(),
    //                         ),
    //                       ),
    //                       errorWidget: (context, url, error) => Container(
    //                         height: 5,
    //                         width: 5,
    //                         child: Icon(
    //                           Icons.error,
    //                         ),
    //                       ),
    //                     )),
    //               ),
    //             )
    //             .toList(),
    //         onPageChanged: (value) {
    //           print('Page changed: $value');
    //         },
    //       );
  }
  List<Widget> _buildDots() {
    List<Widget> dots = [];
    if (bannerModal == null) {
    } else {
      for (int i = 0; i < bannerModal!.banners!.length; i++) {
        dots.add(
          Container(
            margin: EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ? backgroundblack : appColorOrange,
            ),
          ),
        );
      }
    }
    return dots;
  }

  Widget collectionWidget() {
    return Column(
      children: [
        Container(
          color: backgroundgrey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10),
                Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   "Hygiene & Safety Store",
                //   style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey),
                // ),
                Container(height: 10),
                Container(height: collectionModal == null ? 150 :100 , child: collectionData()),
                Container(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget collectionData() {
    return collectionModal == null
        ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1,),
    )
        : collectionModal!.categories!.length > 0
        ? ListView.builder(
      padding: EdgeInsets.only(
        bottom: 10,
        top: 0,
      ),
      itemCount: collectionModal!.categories!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, int index,) {
        return sortingCard(
            context, collectionModal!.categories![index]);
      },
    )
        : Center(
      child: Text(
        "No data found",
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget sortingCard(BuildContext context, Categories categories) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SubCategoryScreen(id: categories.id!, name: categories.cName!,image: categories.img,description: categories.description,)
              // ViewCategory(id: categories.id!, name: categories.cName!)
            ),
          );
        },
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(width: 5),
              Container(
                width: 80,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    categories.img!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categories.cName!,
                    style: TextStyle(
                        color: appColorBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                ],
              ),
              Container(width: 15)
            ],
          ),
        ),
      ),
    );
  }

  Widget bestSellerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Best Service Provider",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "check out our best services",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
        Container(height: 30),
        Container(
          color: backgroundgrey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 10),
                /*Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchProduct(
                                      back: true,
                                    )),
                          );
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              color: appColorBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),*/
                Container(height: 200,
                    child: bestSellerItems()
                ),
                Container(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bestSellerItems() {
    return allProduct == null
        ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1,),
    )
        : allProduct!.setting!.length > 0
        ? ListView.builder(
      padding: EdgeInsets.only(bottom: 10),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: allProduct!.setting!.length,
      itemBuilder: (
          context,
          int index,
          ) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => ViewCategory(
                  vid: allProduct!.setting![index].id,
                  name: allProduct!.setting![index].uname,
                  fromSeller: true,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: 180,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 15, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 120,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(allProduct!
                                  .setting![index].profileImage!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(height: 5),
                      Text(
                        "${allProduct!.setting![index].fname} ${allProduct!.setting![index].lname}",
                        maxLines: 2,
                        style: TextStyle(
                            color: appColorBlack,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    )
        : Center(
      child: Text(
        "Don't have any near by service providers",
        style: TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  _CarouselSlider(){
    return  CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 2.4,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        autoPlayAnimationDuration:
        Duration(milliseconds: 350),
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
        height: 100,
        onPageChanged: (position, reason) {
          setState(() {
            currentindex = position;
          });
          print(reason);
          print(CarouselPageChangedReason.controller);
        },
      ),
      items: offerBannerModel!.banners!.map((val) {
        return Container(
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(20)),
          // height: 180,
          // width: MediaQuery.of(context).size.width,
          child: ClipRRect(
              borderRadius:
              BorderRadius.circular(20),
              child: Image.network(
                "${offerBannerModel!.banners!.first.image}",
                fit: BoxFit.fill,
              )),
        );
      }).toList(),
    );
  }

  _CarouselSlider2(){
    print("-------------------${bannerModal!.banners}");
    return
      bannerModal == null
        ? Center(
      child: Image.asset("assets/images/loader1.gif", scale: 1,),
    ) :
      CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 2.4,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 7),
        autoPlayAnimationDuration:
        Duration(milliseconds: 350),
        enlargeCenterPage: false,
        // scrollDirection: Axis.horizontal,
        height: 140,
        onPageChanged: (position, reason) {
          setState(() {
            currentindex = position;
          });
          print(reason);
          print(CarouselPageChangedReason.controller);
        },
      ),
      items: bannerModal!.banners!
          .map((item) {
        return Container(
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(20)),
          // height: 180,
          // width: MediaQuery.of(context).size.width,
          child: ClipRRect(
              borderRadius:
              BorderRadius.circular(20),
              child:  ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: item, fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                        child: Container(
                          margin: EdgeInsets.all(70.0),
                          child: CircularProgressIndicator(),
                        )),
                    errorWidget: (context, url, error) => Container(
                      height: 5, width: 5,
                      child: Icon(
                        Icons.error,
                      ),
                    ),
                  )),
              // Image.network(
              //   "${offerBannerModel!.banners!.first.image}",
              //   // "${bannerModal!.banners!}",
              //   fit: BoxFit.fill,
              // )
          ),
        );
      }).toList(),
    );
  }
}

class CustomIcons {
  CustomIcons._();
  static const _kFontFam = 'CustomIcons';
  static const String? _kFontPkg = null;

  static const img = AssetImage("assets/images/loader1.gif");
  static const img1 = AssetImage("assets/images/loader1.gif");
}