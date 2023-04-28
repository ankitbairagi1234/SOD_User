import 'dart:convert';
import 'dart:io';

import 'package:ez/models/GetProductsModel.dart';
import 'package:ez/models/GetUserCartModel.dart';
import 'package:ez/screens/view/newUI/manage_address.dart';
import 'package:ez/screens/view/newUI/paymentSuccess.dart';
import 'package:ez/screens/view/newUI/placeorder_success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
// import 'package:place_picker/entities/location_result.dart';
// import 'package:place_picker/widgets/place_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/global.dart';
import '../../../models/AddToCartModel.dart';
import '../../../models/DeliveryChargeDistanceModel.dart';

class ViewCart extends StatefulWidget {
  String? product_id;
  ViewCart({Key? key, this.product_id}) : super(key: key);
 // final List <Imgssss> allProducts;
  @override
  State<ViewCart> createState() => _ViewCartState();
}

String? isSelected, payMethod = '', selTime, selDate, promocode;
class _ViewCartState extends State<ViewCart> {
  String? user_id;
  bool? isLoading = false;
  String? id;
  int _counter = 1;
  bool isVisible =true;
  Position? currentLocation;
  var finalTotal;
  var allTotal;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }  void _decrimentConter() {
    setState(() {
      if(_counter<=1){
        setState(() {
          isVisible=true;
        });
      }
      _counter--;
    });
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
  double lat = 0.0;
  double long = 0.0;
  double? totalLocation;

  @override
  void initState() {
    super.initState();
    _getUserCart();
    getDeliveryCahrge();
    getUserCurrentLocation();
  }


  Future getUserCurrentLocation() async {
    print("Lat Long hereeeeeeee ${homelat} ${homeLong}");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          homelat = currentLocation?.latitude;
          homeLong = currentLocation?.longitude;
        });
      calculateDistance(lat, long, homelat, homeLong);
    });
  }

  var homelat;
  var homeLong;

  List<int> qty = [];

  double calculateDistance(lat, long, homelat, homeLong) {
    print("Alll lat lonssss ${lat} ${long} ${homelat} ${homeLong}");
    try {
      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((homelat - lat) * p) / 2 +
          c(lat * p) * c(homelat * p) * (1 - c((homeLong - long) * p)) / 2;
      print("kmmmmmm ${12742 * asin(sqrt(a))}");
      totalLocation = 12742 * asin(sqrt(a));
      print("total location ${totalLocation}");

      return 12742 * asin(sqrt(a));
    } on Exception {
      return 0; // only executed if error is of type Exception
    } catch (error) {
      print("totalLocationnnnnnn${error} ");
      return 0; // executed for errors of all types other than Exception
    }
  }


  AddToCartModel? addToCartModel;
  addToCart(String productId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    id = preferences.getString("id");
    var headers = {
      'Cookie': 'ci_session=76282680e65886d44b5d7a8a0b61ac57d57ba3b3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/add_to_cart'));
    request.fields.addAll({
      'user_id': user_id ?? '',
      'product_id': productId,
      'quantity': _counter.toString(),
      'vendor_id': id ?? " ",
    });
    print("Add To Cart Requset%%%%%%%%%%%% ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AddToCartModel.fromJson(json.decode(finalResponse));
      print("Get Userrrrr**************$jsonResponse");
      setState(() {
        addToCartModel = AddToCartModel.fromJson(json.decode(finalResponse));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  GetUserCartModel? getUserCartModel;
  _getUserCart() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=a4f7eded0ae55693b27377b39c0d806fc3fd3588'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_cart_items'));
    request.fields.addAll({
      'user_id': user_id ?? '',
    });
    print("Get User Cartt ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      print("hjhjjhhhhhhhhhhhhhhh");
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetUserCartModel.fromJson(json.decode(finalResponse));
      print("Get Userrrrr cartttt $jsonResponse");
      if(jsonResponse.responseCode == '1'){
        print("cart&&&&&&&&&&&");
         String? cart_total = jsonResponse.cartTotal ?? "";
         preferences.setString('cart_total', cart_total);
         print("cartt Total@@@@@ ${cart_total}");
         setState(() {
           getUserCartModel = GetUserCartModel.fromJson(json.decode(finalResponse));
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

  String? cart_total;
  DeliveryChargeDistanceModel? deliveryChargeDistanceModel;

  getDeliveryCahrge() async{
    print("Delivery Charge Apiiii");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    cart_total = preferences.getString('cart_total');
    print("Crat Total######### ${cart_total}");
    var headers = {
      'Cookie': 'ci_session=f73c5c046fd411d547789e1923e08203dca73e79'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/price_culculation_food'));
    request.fields.addAll({
      'distance': totalLocation.toString(),
      'subTotal': cart_total ?? ''
    });
    print("Delivery charge by distance ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = DeliveryChargeDistanceModel.fromJson(json.decode(finalResponse));
      print("Delievry charge diatance responseeee$jsonResponse");
      if(jsonResponse.status == true){
        String? vendor_delivery_charge = jsonResponse.vendorDeliveryCharge ?? "";
        String? vendor_gst = jsonResponse.vendorGst ?? "";
        String? deliver_charge = jsonResponse.deliverCharge ?? '';
        String? gst = jsonResponse.gst ?? '';
        String? total = jsonResponse.total ?? '';
        String? subtotal_gst_percentage = jsonResponse.subtotalGstPercentage.toString();

        preferences.setString('gst', gst);
        preferences.setString('deliver_charge', deliver_charge);
        preferences.setString('vendor_gst', vendor_gst);
        preferences.setString('vendor_delivery_charge', vendor_delivery_charge);
        preferences.setString('total', total);
        preferences.setString('subtotal_gst_percentage', subtotal_gst_percentage.toString());

        print("vendor delivery charge ${vendor_delivery_charge}");
        print("vendor gst ${vendor_gst}");
        print("Delivery Charge ${deliver_charge}");
        print("Delivery gst ammount ${gst}");
        print("Total Hereeeee ${total}");
        print("Sub Gst Percentage ${subtotal_gst_percentage}");

        finalTotal = cart_total ?? "" + total ?? '';
        print("Final total here ${finalTotal}");

        // allTotal = cart_total * subtotal_gst_percentage.toString()/100;
        print("All Total Here@@@@@@ ${allTotal}");

        setState(() {
          deliveryChargeDistanceModel = DeliveryChargeDistanceModel.fromJson(json.decode(finalResponse));
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

  String? vendor_delivery_charge;
  String? vendor_gst;
  String? deliver_charge;
  String? gst;
  String? address_id;

  placeOrder() async{
    print("Place Order Apiii");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    vendor_delivery_charge = preferences.getString('vendor_delivery_charge');
    vendor_gst = preferences.getString('vendor_gst');
    deliver_charge = preferences.getString('deliver_charge');
    gst = preferences.getString('gst');
    cart_total = preferences.getString('cart_total');
    id = preferences.getString("id");
    address_id = preferences.getString("address_id");

    var headers = {
      'Cookie': 'ci_session=956e5677c489a7ef30077af5aeef1273dac21384'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/place_order'));
    request.fields.addAll({
      'product_id': widget.product_id.toString(),
      'quantity': _counter.toString(),
      'subTotal': cart_total ?? '',
      'total_price': finalTotal,
      'username': userName,
      'vendor_id': id ?? '',
      'address_mobile': userMobile,
      'address': addressC.text,
      'address_id': address_id ?? "",
      'paymentMethod': payMethod.toString(),
      'sub_gst_amount': '33.5',
      'user_id': user_id ?? "",
      'distance': totalLocation.toString(),
      'dilivery_gst_amount': gst ?? '',
      'delivery_charge': deliver_charge ?? '',
      'vendor_gst': vendor_gst ?? "",
      'vendor_delivery_charge': vendor_delivery_charge ?? "",
    });

    print("Place Order Parameter ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      if(jsonResponse['status'] == true){
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceOrderSuccess()));
      } else{
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }

  removeCart(String productId) async{
    print("Remove cart apiii");
    var headers = {
      'Cookie': 'ci_session=fd7962a8fe5db9e0a60b132cf74e978025ae84fc'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/remove_to_cart'));
    request.fields.addAll({
      'productid': productId,
      'user_id': user_id ?? ""
    });
    print("Remove Carttt ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = json.decode(finalResponse);
      if(jsonResponse['status'] == true){
        Fluttertoast.showToast(msg: '${jsonResponse['message']}');
        Navigator.pop(context);
      } else{
        Fluttertoast.showToast(msg: "${jsonResponse['message']}");
      }
    }
    else {
      setState(() {});
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Get uuser cart ${getUserCartModel!.cart![0].sellingPrice}");
    print("Get&&&&&&& ${getUserCartModel!.cart![0].quantity}");
    print("kjjkjjjjlljklkklkj ${getUserCartModel!.cart![0].productId}");
    return Scaffold(
      backgroundColor: Color(0xffF1F5F8),
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white38,
        title: Text("Cart", style: TextStyle(color: backgroundblack, fontWeight: FontWeight.w900, fontSize: 22),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: backgroundblack),
        ),
        centerTitle: true,
      ),
      body:
      // Container(
      //            decoration: BoxDecoration(
      //           border: Border(top: BorderSide(width: 5)),
      //           borderRadius: const BorderRadius.only(
      //           topLeft: Radius.circular(30.0),
      //           topRight: Radius.circular(30.0),
      //    ), ),
      // ),
      Padding(
        padding: EdgeInsets.only(top:0),
        child : Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  getUserCartModel == null
                      ? Center(
                      child: CupertinoActivityIndicator())
                      : getUserCartModel!.responseCode!= "0"
                      ? getUserCartModel == null ? Center(
                       child: Image.asset("assets/images/loader1.gif"))
                          : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: getUserCartModel!.cart!.length,
                          itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: EdgeInsets.all(15),
                               child: Scrollbar(
                              thickness: 10,
                              trackVisibility: true,
                            // isAlwaysShown: true,
                            thumbVisibility: true,
                            radius: Radius.circular(10),
                            child: SizedBox(
                              height: 120,
                              child: Card(
                              elevation: 10,
                              semanticContainer: true,
                         //  shape: RoundedRectangleBorder(
                        //  borderRadius: BorderRadius.circular(20.0),
                        // ),
                           clipBehavior: Clip.antiAlias,
                              child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: <Widget>[
                           // Center(
                        //   child: Container(
                        //       decoration: BoxDecoration(
                        //           color: appColorOrange,
                        //           borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
                        //       height: 80,width: 5),
                        // ),
                          SizedBox(width: 5),
                          Center(
                          child: getUserCartModel == null ? Center(
                            child: Image.asset("assets/images/loader1.gif"),
                          ) : Image.network("${getUserCartModel!.cart![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, left: 17),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${getUserCartModel!.cart![index].productName}",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14),),
                                // Text("Qty ${getUserCartModel!.cart![index].quantity}", style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14)),
                                Text("₹ ${getUserCartModel!.cart![index].qtyPrice}", style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: .0),
                                          // child:  InkWell(
                                          //   onTap: () {
                                          //     if (_counter >= 1) {
                                          //       _counter -= 1;
                                          //       setState(() {});
                                          //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
                                          //     }
                                          //   },
                                          //   child: Card(
                                          //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
                                          //     child: ClipRRect(
                                          //         borderRadius:
                                          //         BorderRadius.all(Radius.circular(6)),
                                          //         child: Container(
                                          //             // padding: EdgeInsets.all(6),
                                          //             // color: isDark
                                          //             //     ? AppThemes.smoothBlack
                                          //             //     : AppThemes
                                          //             //     .lightTextFieldBackGroundColor,
                                          //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
                                          //         ),
                                          //     ),
                                          //   ),
                                          // ),
                                          child: InkWell(
                                            onTap: () {
                                              // if (_counter >= 1) {
                                              //   _counter -= 1;
                                              //   setState(() {});
                                              //   addToCart(getUserCartModel!.cart![index].productId ??'');
                                              // }
                                              //   setState((){
                                              //   });
                                              //   count[index] -= 1;
                                              //     addToCart(getUserCartModel!.cart![index].productId ??'');
                                              // },
                                              if (qty[index] >= 1) {
                                                qty[index] -= 1;
                                                print("kkkkkkk ${qty[index]}");
                                                print("ooooo ${qty[index]}");
                                                addToCart(getUserCartModel!.cart![index].productId.toString(),
                                                  // getUserCartModel.cart[index].productPrice ?? "",
                                                  // qty[index].toString());
                                                );
                                              }
                                            },
                                            // onTap:() {
                                            //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                                            //   _decrimentConter;
                                            // },
                                            child: (
                                                Center(
                                                    child: Icon(Icons.remove,size: 20,color: Colors.black))
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //     child: Text("${count[index]}",)),
                                        SizedBox(width: 14),
                                        Padding(
                                          padding: const EdgeInsets.only(top: .0),
                                          child:Text("Qty: ${getUserCartModel!.cart![index].quantity}", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),

                                        ),
                                        SizedBox(width: 14),
                                        // SizedBox(width: 60,),
                                        Padding(
                                          padding: const EdgeInsets.only(top:.0),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {});
                                              print("kkkkkkk ${qty[index]}");
                                              qty[index] = qty[index] + 1;
                                              print("ooooo ${qty[index]}");
                                              addToCart(getUserCartModel!.cart![index].productId ??'');
                                            },
                                            child: (
                                                Center(child: const Icon(Icons.add,size: 25,color: Colors.black))),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 100,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: (){
                                            removeCart(getUserCartModel!.cart![index].productId ??'');
                                          },
                                          child: Icon(
                                            Icons.delete, color:Colors.black,size: 35,
                                          ),
                                        ),

                                      ],)

                                  ],
                                ),
                              ],
                          ),
                        ),
                        // Container(
                        //   child: Row(
                        //       children: [
                        //         Padding(
                        //           padding: const EdgeInsets.only(top: 28.0),
                        //           // child:  InkWell(
                        //           //   onTap: () {
                        //           //     if (_counter >= 1) {
                        //           //       _counter -= 1;
                        //           //       setState(() {});
                        //           //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
                        //           //     }
                        //           //   },
                        //           //   child: Card(
                        //           //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
                        //           //     child: ClipRRect(
                        //           //         borderRadius:
                        //           //         BorderRadius.all(Radius.circular(6)),
                        //           //         child: Container(
                        //           //             // padding: EdgeInsets.all(6),
                        //           //             // color: isDark
                        //           //             //     ? AppThemes.smoothBlack
                        //           //             //     : AppThemes
                        //           //             //     .lightTextFieldBackGroundColor,
                        //           //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
                        //           //         ),
                        //           //     ),
                        //           //   ),
                        //           // ),
                        //           child: InkWell(
                        //             onTap: () {
                        //               // if (_counter >= 1) {
                        //               //   _counter -= 1;
                        //               //   setState(() {});
                        //               //   addToCart(getUserCartModel!.cart![index].productId ??'');
                        //               // }
                        //               //   setState((){
                        //               //   });
                        //               //   count[index] -= 1;
                        //               //     addToCart(getUserCartModel!.cart![index].productId ??'');
                        //               // },
                        //               if (qty[index] >= 1) {
                        //                 qty[index] -= 1;
                        //                 print("kkkkkkk ${qty[index]}");
                        //                 print("ooooo ${qty[index]}");
                        //                 addToCart(getUserCartModel!.cart![index].productId.toString(),
                        //                   // getUserCartModel.cart[index].productPrice ?? "",
                        //                   // qty[index].toString());
                        //                 );
                        //               }
                        //             },
                        //             // onTap:() {
                        //             //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                        //             //   _decrimentConter;
                        //             // },
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                   color:backgroundblack,
                        //                   borderRadius: BorderRadius.circular(5)),
                        //               height: 24,
                        //               width: 25,
                        //               child:(
                        //                   Center(
                        //                       child: Icon(Icons.remove,size: 20,color: Colors.white))
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         // Container(
                        //         //     child: Text("${count[index]}",)),
                        //         SizedBox(width: 4),
                        //         Padding(
                        //           padding: const EdgeInsets.only(top: 28.0),
                        //           child:Text("Qty: ${getUserCartModel!.cart![index].quantity}", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                        //
                        //         ),
                        //         SizedBox(width: 4),
                        //         // SizedBox(width: 60,),
                        //         Padding(
                        //           padding: const EdgeInsets.only(top: 28.0),
                        //           child: InkWell(
                        //             onTap: () {
                        //               setState(() {});
                        //               print("kkkkkkk ${qty[index]}");
                        //               qty[index] = qty[index] + 1;
                        //               print("ooooo ${qty[index]}");
                        //               addToCart(getUserCartModel!.cart![index].productId ??'');
                        //             },
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                   color:backgroundblack,
                        //                   borderRadius: BorderRadius.circular(5)),
                        //               height: 24,
                        //               width: 25,
                        //               child:(
                        //                   Center(child: const Icon(Icons.add,size: 20,color: Colors.white))),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //   ),
                        // ),
                        // // Container(
                        // //   child: Row(children: [
                        // //     Padding(
                        // //       padding: const EdgeInsets.only(top: 30.0),
                        // //       child: InkWell(
                        // //         onTap: _decrimentConter,
                        // //         child: Container(
                        // //           decoration: BoxDecoration(
                        // //               color:backgroundblack,
                        // //               borderRadius: BorderRadius.circular(5)),
                        // //           height: 24,
                        // //           width: 27,
                        // //           child: (Center(child: const Icon(Icons.remove,size: 20,color: Colors.white,))
                        // //           ),
                        // //         ),
                        // //       ),
                        // //     ),
                        // //     SizedBox(width: 3,),
                        // //     Padding(
                        // //       padding: const EdgeInsets.only(top: 23.0),
                        // //       child: Text(
                        // //         '$_counter',
                        // //         style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                        // //       ),
                        // //     ),
                        // //     SizedBox(width: 3),
                        // //     Padding(
                        // //       padding: const EdgeInsets.only(top: 30.0),
                        // //       child: InkWell(
                        // //         onTap: _incrementCounter,
                        // //         child: Container(
                        // //           decoration: BoxDecoration(
                        // //               color:backgroundblack,
                        // //               borderRadius: BorderRadius.circular(5)),
                        // //           height: 24,
                        // //           width: 27,
                        // //           child: (Center(child: const Icon(Icons.add,size: 20,color: Colors.white,))
                        // //           ),
                        // //         ),
                        // //       ),
                        // //     ),
                        // //   ],),
                        // // ),
                        // SizedBox(width: 8),
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: InkWell(
                        //       onTap: (){
                        //         removeCart(getUserCartModel!.cart![index].productId ??'');
                        //       },
                        //       child: Icon(
                        //         Icons.delete, color: backgroundblack,
                        //       ),
                        //   ),
                        // ),
                        // Spacer(),
                        // Center(
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(top: 8.0),
                        //     child: Container(
                        //         decoration: BoxDecoration(
                        //             color: appColorOrange,
                        //             borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                        //         ),
                        //         height: 80,width: 8),
                        //   ),
                        // ),
                      ],
                      )),
                            ),
                ));
        },
      )
                  // ListView.builder(
                  //   scrollDirection: Axis.vertical,
                  //   shrinkWrap: true,
                  //   itemCount: getUserCartModel!.cart!.length,
                  //   itemBuilder: (context, index) {
                  //     return
                  //       _itmeList(
                  //         getUserCartModel!.cart![index], index);
                  //   },
                  // )
                      : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            child: Image.asset(
                              "assets/images/emptyCart.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            "Cart is Empty",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  isLoading == null
                      ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                      : Container()
                ],
              ),
            ),
            // Container(
            //   height: MediaQuery.of(context).size.height/40,
            //   // height: MediaQuery.of(context).size.height-85.0-75,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: const BoxDecoration(
            //       color: appColorOrange,
            //       borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(45),
            //         topRight: Radius.circular(45),
            //       ),
            //   ),
              // child: Padding(
              //   padding: const EdgeInsets.only(top:70, left: 30.0, right: 30),
              //   child: SingleChildScrollView(
              //     child: Text("khjjhj"),
              //   ),
              // ),
            // ),
            // Container(
            //   height: 500,
            //   width: MediaQuery.of(context).size.width/1,
            //   child: getUserCartModel == null ? Center(
            //     child: Image.asset("assets/images/loader1.gif"),
            //   ) : ListView.builder(
            //     scrollDirection: Axis.vertical,
            //     itemCount: getUserCartModel!.cart!.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return
            //         Padding(
            //           padding: EdgeInsets.all(15),
            //           child: Scrollbar(
            //             thickness: 10,
            //             trackVisibility: true,
            //             // isAlwaysShown: true,
            //             thumbVisibility: true,
            //             radius: Radius.circular(10),
            //             child: Card(
            //                 elevation: 10,
            //                 semanticContainer: true,
            //                 shape: RoundedRectangleBorder(
            //                   borderRadius: BorderRadius.circular(20.0),
            //                 ),
            //                 clipBehavior: Clip.antiAlias,
            //                 child: Row(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: <Widget>[
            //                     Center(
            //                       child: Container(
            //                           decoration: BoxDecoration(
            //                               color: appColorOrange,
            //                               borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10))),
            //                           height: 80,width: 5),
            //                     ),
            //                     SizedBox(width: 5),
            //                     Center(
            //                       child: ClipRRect(
            //                           borderRadius: BorderRadius.circular(100),
            //                           // radius: 40,
            //                           child: getUserCartModel == null ? Center(
            //                             child: Image.asset("assets/images/loader1.gif"),
            //                           ) : Image.network("${getUserCartModel!.cart![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,)
            //                       ),
            //                     ),
            //                     Padding(
            //                       padding: const EdgeInsets.only(top: 15.0, left: 7),
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Text("${getUserCartModel!.cart![index].productName}",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14),),
            //                           Text("Qty ${getUserCartModel!.cart![index].quantity}", style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14)),
            //                           Text("₹ ${getUserCartModel!.cart![index].qtyPrice}", style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 14)),
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(width: 50,),
            //                     Container(
            //                       child: Row(
            //                         children: [
            //                           Padding(
            //                             padding: const EdgeInsets.only(top: 28.0),
            //                             // child:  InkWell(
            //                             //   onTap: () {
            //                             //     if (_counter >= 1) {
            //                             //       _counter -= 1;
            //                             //       setState(() {});
            //                             //       addToCart(widget.productData['product_id'],widget.productData['product_type']);
            //                             //     }
            //                             //   },
            //                             //   child: Card(
            //                             //     shape: RoundedRectangleBorder(side: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(7)),
            //                             //     child: ClipRRect(
            //                             //         borderRadius:
            //                             //         BorderRadius.all(Radius.circular(6)),
            //                             //         child: Container(
            //                             //             // padding: EdgeInsets.all(6),
            //                             //             // color: isDark
            //                             //             //     ? AppThemes.smoothBlack
            //                             //             //     : AppThemes
            //                             //             //     .lightTextFieldBackGroundColor,
            //                             //             child: const Icon(Icons.remove,size: 20,color: Colors.white,)
            //                             //         ),
            //                             //     ),
            //                             //   ),
            //                             // ),
            //                             child: InkWell(
            //                               onTap: () {
            //                                 // if (_counter >= 1) {
            //                                 //   _counter -= 1;
            //                                 //   setState(() {});
            //                                 //   addToCart(getUserCartModel!.cart![index].productId ??'');
            //                                 // }
            //                                 //   setState((){
            //                                 //   });
            //                                 //   count[index] -= 1;
            //                                 //     addToCart(getUserCartModel!.cart![index].productId ??'');
            //                                 // },
            //                                 if (qty[index] >= 1) {
            //                                   qty[index] -= 1;
            //                                   print("kkkkkkk ${qty[index]}");
            //                                   print("ooooo ${qty[index]}");
            //                                   addToCart(
            //                                     getUserCartModel!.cart![index]
            //                                         .productId.toString(),
            //                                     // getUserCartModel.cart[index].productPrice ?? "",
            //                                     // qty[index].toString());
            //                                   );
            //                                 }
            //                               },
            //                               // onTap:() {
            //                               //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
            //                               //   _decrimentConter;
            //                               // },
            //                               child: Container(
            //                                 decoration: BoxDecoration(
            //                                     color:backgroundblack,
            //                                     borderRadius: BorderRadius.circular(5)),
            //                                 height: 24,
            //                                 width: 25,
            //                                 child:(
            //                                     Center(
            //                                         child: Icon(Icons.remove,size: 20,color: Colors.white))
            //                                 ),
            //                               ),
            //                             ),
            //                           ),
            //                           // Container(
            //                           //     child: Text("${count[index]}",)),
            //                           SizedBox(width: 4),
            //                           Padding(
            //                             padding: const EdgeInsets.only(top: 28.0),
            //                             child: Text(
            //                               '$_counter',
            //                               // "${qty[index].toString()}",
            //                               style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            //                             ),
            //                           ),
            //                           SizedBox(width: 4),
            //                           // SizedBox(width: 60,),
            //                           Padding(
            //                             padding: const EdgeInsets.only(top: 28.0),
            //                             child: InkWell(
            //                               onTap: () {
            //                                 setState(() {});
            //                                 print("kkkkkkk ${qty[index]}");
            //                                 qty[index] = qty[index] + 1;
            //                                 print("ooooo ${qty[index]}");
            //                                 addToCart(getUserCartModel!.cart![index].productId ??'');
            //                               },
            //                               child: Container(
            //                                 decoration: BoxDecoration(
            //                                     color:backgroundblack,
            //                                     borderRadius: BorderRadius.circular(5)),
            //                                 height: 24,
            //                                 width: 25,
            //                                 child:(
            //                                     Center(child: const Icon(Icons.add,size: 20,color: Colors.white))),
            //                               ),
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                     // Container(
            //                     //   child: Row(children: [
            //                     //     Padding(
            //                     //       padding: const EdgeInsets.only(top: 30.0),
            //                     //       child: InkWell(
            //                     //         onTap: _decrimentConter,
            //                     //         child: Container(
            //                     //           decoration: BoxDecoration(
            //                     //               color:backgroundblack,
            //                     //               borderRadius: BorderRadius.circular(5)),
            //                     //           height: 24,
            //                     //           width: 27,
            //                     //           child: (Center(child: const Icon(Icons.remove,size: 20,color: Colors.white,))
            //                     //           ),
            //                     //         ),
            //                     //       ),
            //                     //     ),
            //                     //     SizedBox(width: 3,),
            //                     //     Padding(
            //                     //       padding: const EdgeInsets.only(top: 23.0),
            //                     //       child: Text(
            //                     //         '$_counter',
            //                     //         style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            //                     //       ),
            //                     //     ),
            //                     //     SizedBox(width: 3),
            //                     //     Padding(
            //                     //       padding: const EdgeInsets.only(top: 30.0),
            //                     //       child: InkWell(
            //                     //         onTap: _incrementCounter,
            //                     //         child: Container(
            //                     //           decoration: BoxDecoration(
            //                     //               color:backgroundblack,
            //                     //               borderRadius: BorderRadius.circular(5)),
            //                     //           height: 24,
            //                     //           width: 27,
            //                     //           child: (Center(child: const Icon(Icons.add,size: 20,color: Colors.white,))
            //                     //           ),
            //                     //         ),
            //                     //       ),
            //                     //     ),
            //                     //   ],),
            //                     // ),
            //                     SizedBox(width: 8),
            //                     Align(
            //                       alignment: Alignment.topLeft,
            //                       child: InkWell(
            //                         onTap: (){
            //                           removeCart(getUserCartModel!.cart![index].productId ??'');
            //                         },
            //                         child: Icon(
            //                             Icons.highlight_remove_rounded, color: backgroundblack,
            //                         ),
            //                       ),
            //                     ),
            //                     Spacer(),
            //                     Center(
            //                       child: Padding(
            //                         padding: const EdgeInsets.only(top: 8.0),
            //                         child: Container(
            //                           decoration: BoxDecoration(
            //                               color: appColorOrange,
            //                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
            //                           ),
            //                           height: 80,width: 8),
            //                       ),
            //                     ),
            //                   ],
            //                 )),
            //           ));
            //     },
            //   ),
            // ),
            SizedBox(height: 20),
            InkWell(
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCartScreeen()));
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width/1.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appColorOrange),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sub Total",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack)),
                      Text("₹ ${getUserCartModel!.cartTotal ?? " "}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context,) {
                    return Container(
                      height: 360,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width/1.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10), color: Colors.white,
                                ),
                                child: InkWell(
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
                                              addressC.text = result.formattedAddress.toString();
                                              lat = result.geometry!.location.lat;
                                              long = result.geometry!.location.lng;
                                            });
                                            Navigator.of(context).pop();
                                            // distnce();
                                          },
                                          initialPosition: LatLng(currentLocation!.latitude, currentLocation!.longitude),
                                          useCurrentLocation: true,
                                        ),
                                      ),
                                    );
                                    // _getLocation();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, top: 1),
                                        child: Text(
                                            "Select Address", style: TextStyle(fontSize: 18, color: backgroundblack)
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Icon(Icons.my_location, color: backgroundblack),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                color: backgroundblack,
                                thickness: 1.5,
                                indent : 10,
                                endIndent : 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  // Text("Ankit Bairagi",style: TextStyle(fontWeight:FontWeight.w500,fontSize: 14),),
                                  InkWell( onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAddress()));
                                  },
                                      child: Text("Change Address",style: TextStyle(color: backgroundblack,fontSize: 16,fontWeight: FontWeight.bold),))
                                ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // TextFormField(
                                    //   decoration: InputDecoration(border: InputBorder.none),
                                    //   controller: addressC,
                                    //   maxLines: 2,
                                    //   style: TextStyle(overflow: TextOverflow.ellipsis),
                                    // ),
                                  // Text("A/5 Ratanpuri Indore"),
                                  // Text('+9109599773')
                                ],),
                              ),
                              SizedBox(height: 8,),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
                                },
                                child: Container(
                                  height: 65,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      color: appColorOrange),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Select Payment Method ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: backgroundblack),),
                                        Icon(Icons.arrow_forward_ios,color: backgroundblack,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              payMethod != null && payMethod != ''
                                  ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Divider(), Text(payMethod!)],
                                ),
                              ) : Container(),
                              SizedBox(height: 10),
                              Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                 Text("Order Summary", style: TextStyle(fontSize: 16, color: Colors.black),),
                                 Padding(
                                   padding: const EdgeInsets.all(.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("Sub Total ",style: TextStyle(fontWeight:FontWeight.w500,fontSize: 14)),
                                       Text("₹${getUserCartModel!.cartTotal ?? " "}",style: TextStyle(color: backgroundblack,fontSize: 16,fontWeight: FontWeight.bold))
                                     ],),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("Gst & Services",style: TextStyle(fontWeight:FontWeight.w500,fontSize: 14),),
                                       deliveryChargeDistanceModel == null || deliveryChargeDistanceModel == " " ? Text("0.0") :
                                       Text("₹${deliveryChargeDistanceModel!.gst ?? ""}",style: TextStyle(color: backgroundblack,fontSize: 16,fontWeight: FontWeight.bold),)
                                     ],),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("Delivery Charge",style: TextStyle(fontWeight:FontWeight.w500,fontSize: 14),),
                                       deliveryChargeDistanceModel == null || deliveryChargeDistanceModel == " " ? Text("0.0") :
                                       Text("₹ ${deliveryChargeDistanceModel!.deliverCharge ?? ""}",style: TextStyle(color: backgroundblack,fontSize: 16,fontWeight: FontWeight.bold),)
                                     ],),
                                 ),
                                 SizedBox(height: 20,),
                                 Padding(
                                   padding: const EdgeInsets.all(5.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("Total: ₹${getUserCartModel!.cartTotal ?? " "}", style: TextStyle(fontSize: 15, color: backgroundblack, fontWeight: FontWeight.w500),),
                                       InkWell(
                                         onTap: (){
                                           if(isSelected == null || isSelected!.isEmpty){
                                             Fluttertoast.showToast(
                                                 msg: "Please select address",
                                                 toastLength: Toast.LENGTH_SHORT,
                                                 gravity: ToastGravity.CENTER,
                                                 timeInSecForIosWeb: 1,
                                                 backgroundColor: backgroundblack,
                                                 textColor: Colors.white,
                                                 fontSize: 16.0
                                             );
                                             Navigator.pushReplacement(
                                                 context,
                                                 MaterialPageRoute(
                                                   builder: (BuildContext context) =>
                                                       ManageAddress(
                                                         home: false,
                                                       ),
                                                 ));
                                           } else if(payMethod == null || payMethod!.isEmpty){
                                             Fluttertoast.showToast(
                                                 msg: "Please select payment method",
                                                 toastLength: Toast.LENGTH_SHORT,
                                                 gravity: ToastGravity.CENTER,
                                                 timeInSecForIosWeb: 1,
                                                 backgroundColor: backgroundblack,
                                                 textColor: Colors.white,
                                                 fontSize: 16.0
                                             );
                                             Navigator.push(
                                                 context,
                                                 MaterialPageRoute(
                                                     builder: (BuildContext context) =>
                                                         PaymentScreen()));
                                           }
                                           placeOrder();
                                           // Navigator.push(context, MaterialPageRoute(builder: (context)=> PlaceOrderSuccess()));
                                         },
                                         child: Container(
                                           height: 40,
                                           width: 120,
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(10),
                                               color: appColorOrange
                                           ),
                                           child: Center(child: Text("Place Order",style: TextStyle(color: backgroundblack,fontSize: 15),)),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ],
                               ),
                             ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>GetCartScreeen()));
              },
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: appColorOrange),
                child: Center(child: Text("CheckOut",style: TextStyle(color:backgroundblack,fontSize: 15,fontWeight: FontWeight.bold ),))
              ),
            ),
          ],
        ),
      ),
    );

  }

  // _getLocation() async {
    // LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => PlacePicker(
    //       "AIzaSyBRnd5Bpqec-SYN-wAYFECRw3OHd4vkfSA",
    //     )));
    // print("Deliveryyyyyy lat long ${lat} and ${long}");
    // print("Adddressss herrrr nowwww ${addressC}");
    // print("checking adderss detail ${result.country!.name.toString()} and ${result.locality.toString()} and ${result.country!.shortName.toString()} ");
    // setState(() {
    //   addressC.text = result.formattedAddress.toString();
    //   cityC.text = result.locality.toString();
    //   stateC.text = result.administrativeAreaLevel1!.name.toString();
    //   countryC.text = result.country!.name.toString();
    //   lat = result.latLng!.latitude;
    //   long = result.latLng!.longitude;
    //   pincodeC.text = result.postalCode.toString();
    // });
  // }

}
