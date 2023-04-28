// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'package:http/http.dart' as http;
//
// class CheckoutScreen extends StatefulWidget {
//   @override
//   _CheckoutScreenState createState() => _CheckoutScreenState();
// }
//
// class _CheckoutScreenState extends State<CheckoutScreen> {
//   static const platform = const MethodChannel("razorpay_flutter");
//   late Razorpay _razorpay;
//
//   GetCartModel? cartModel;
//   int count = 0;
//   getCart() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userid = prefs.getString("userId");
//     var headers = {'Content-Type': 'text/plain'};
//     var request = http.Request('POST', Uri.parse('${Urls.baseUrl}/d_cart.php'));
//     request.body = '{"uid":"${userid}"}\r\n';
//     print("checking get cart params here ${request.body}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResult = await response.stream.bytesToString();
//       final jsonResult = GetCartModel.fromJson(json.decode(finalResult));
//       print("ooo ${jsonResult.toString()}");
//       setState(() {
//         cartModel = jsonResult;
//       });
//       print("final response here ${cartModel}");
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   String? userid;
//   String? selectedCoupon;
//   addToCart(String id, String types, String qty) async {
//     print("sdss ${qty}");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     userid = prefs.getString("userId");
//     var headers = {
//       'Content-Type': 'application/json',
//       'Cookie': 'PHPSESSID=c039f60f195fe7ec1655259ba2ce1c77'
//     };
//     var request =
//     http.Request('POST', Uri.parse('${Urls.baseUrl}/d_add_cart.php'));
//     print("sdddd ${types}");
//     if (types == 'normal_product') {
//       request.body = json.encode({
//         "uid": "${userid}",
//         "product_id": "${id}",
//         "qty": "${qty}",
//         'type': 'normal_product'
//       });
//     } else {
//       request.body = json.encode({
//         "uid": "${userid}",
//         "product_id": "${id}",
//         "qty": "${qty}",
//         'type': 'subscription_product'
//       });
//     }
//     print("dddddd ${request.body}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResult = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResult);
//       print("checking result here ${jsonResponse}");
//       getCart();
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//
//     Future.delayed(Duration(milliseconds: 500), () {
//       return getCart();
//     });
//     Future.delayed(Duration(milliseconds: 500), () {
//       return getCouponCodeList();
//     });
//     Future.delayed(Duration(milliseconds: 500), () {
//       return getPaymentList();
//     });
//     Future.delayed(Duration(milliseconds: 500), () {
//       return getViewProfile();
//     });
//   }
//
//   var getUserId;
//   ViewProfile? getProfile;
//   getViewProfile() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     getUserId = prefs.getString("userId");
//     var request = http.MultipartRequest(
//         'POST', Uri.parse('${Urls.baseUrl}/view_profile.php'));
//     request.fields.addAll({'user_id': '${getUserId}'});
//     print(
//         "getserId--------->${request.fields} and ${Urls.baseUrl}/view_profile.php");
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       final result = await response.stream.bytesToString();
//       var finalData = ViewProfile.fromJson(jsonDecode(result));
//       print("ViewProfile-------->${finalData.toString()}");
//       setState(() {
//         getProfile = finalData;
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     //_razorpay.clear();
//   }
//
//   int? pricerazorpayy;
//
//   void openCheckout() async {
//     if (totalValue == null || totalValue == "") {
//       pricerazorpayy =
//           int.parse(cartModel!.getCartList!.total.toString()) * 100;
//     } else {
//       pricerazorpayy = int.parse(totalValue.toString()) * 100;
//     }
//     print("checking razorpay price ${pricerazorpayy.toString()}");
//     Navigator.of(context).pop();
//     var options = {
//       'key': 'rzp_test_1spO8LVd5ENWfO',
//       'amount': '$pricerazorpayy',
//       'name': 'Dairy',
//       'description': 'Dairy',
//       'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Erroroooooooooooo: e');
//     }
//   }
//
//   Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     print("this is not working here");
//     // RazorpayDetailApi();
//     // Order_cash_ondelivery();
//     placeOrder();
//     Fluttertoast.showToast(
//         msg: "Successful",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0);
//     Navigator.push(
//         context, MaterialPageRoute(builder: (context) => DashBoardScreen()));
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Fluttertoast.showToast(
//     //     msg: "ERROR: " + response.code.toString() + " - " + response.message!,
//     //     toastLength: Toast.LENGTH_SHORT);
//     Fluttertoast.showToast(
//         msg: "Payment cancelled by user",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//         msg: "EXTERNAL_WALLET: " + response.walletName!,
//         toastLength: Toast.LENGTH_SHORT);
//   }
//
//   PaymentListModel? paymentListModel;
//   getPaymentList() async {
//     var headers = {'Cookie': 'PHPSESSID=eb401b2c69e7a95bf7d8a293c20162d1'};
//     var request =
//     http.Request('GET', Uri.parse('${Urls.baseUrl}d_paymentgateway.php'));
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResult = await response.stream.bytesToString();
//       final jsonResponse = PaymentListModel.fromJson(json.decode(finalResult));
//       setState(() {
//         paymentListModel = jsonResponse;
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   List<int> qty = [];
//   var selectedAddress;
//
//   Widget productItem(index) {
//     var isDark = Theme.of(context).brightness == Brightness.dark;
//     if (qty.length < index + 1) qty.add(1);
//     qty[index] = int.parse(
//         cartModel!.getCartList!.orderProductData![index].quatity.toString());
//     return Container(
//       margin: getFirstNLastMergin(index, 5),
//       padding: EdgeInsets.only(right: 15),
//       decoration: BoxDecoration(
//           color:  isDark ? AppThemes.smoothBlack: AppThemes.lightWhiteColor,
//           borderRadius: BorderRadius.all(Radius.circular(10))),
//       child: Row(
//         children: [
//           ClipRRect(
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               child: Image.network(
//                 "${Urls.imageUrl}${cartModel!.getCartList!.orderProductData![index].productImage}",
//                 height: 95,
//                 width: 86,
//                 fit: BoxFit.fill,
//               )),
//           Expanded(
//               child: Container(
//                 padding: EdgeInsets.only(left: 12, right: 12),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             "${cartModel!.getCartList!.orderProductData![index].productName}",
//                             style: Theme.of(context).textTheme.headline5!.copyWith(
//                                 fontWeight: FontWeight.w500, fontSize: 15,color: isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor),
//                           ),
//                         ),
//                         Text(
//                           "",
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline5!
//                               .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 6,
//                     ),
//                     Row(
//                       children: [
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "\u{20B9} ${cartModel!.getCartList!.orderProductData![index].productPrice}",
//                             style: Theme.of(context).textTheme.headline1!.copyWith(
//                                 fontWeight: FontWeight.w500,
//                                 color: AppThemes.lightBlueColor,
//                                 fontSize: 13),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               )),
//           InkWell(
//             onTap: () {
//               setState(() {});
//               if (qty[index] >= 1) {
//                 qty[index] -= 1;
//                 print("kkkkkkk ${qty[index]}");
//                 print("ooooo ${qty[index]}");
//                 addToCart(
//                     cartModel!.getCartList!.orderProductData![index].productId
//                         .toString(),
//                     '${cartModel!.getCartList!.orderProductData![index].product_type}',
//                     qty[index].toString());
//               }
//             },
//             child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(6)),
//                 child: Container(
//                     padding: EdgeInsets.all(6),
//                     color: AppThemes.lightTextFieldBackGroundColor,
//                     child: Icon(Icons.remove,
//                         color: AppThemes.lightRedColor, size: 20))),
//           ),
//           Container(
//             padding: EdgeInsets.only(left: 6, right: 6),
//             child: Text(
//               qty[index].toString(),
//               style: Theme.of(context)
//                   .textTheme
//                   .headline5!
//                   .copyWith(fontWeight: FontWeight.w400, fontSize: 15),
//             ),
//           ),
//           InkWell(
//             onTap: () {
//               setState(() {});
//               print("kkkkkkk ${qty[index]}");
//               qty[index] = qty[index] + 1;
//               print("ooooo ${qty[index]}");
//               addToCart(
//                   cartModel!.getCartList!.orderProductData![index].productId
//                       .toString(),
//                   '${cartModel!.getCartList!.orderProductData![index].product_type}',
//                   qty[index].toString());
//             },
//             child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(6)),
//                 child: Container(
//                     padding: EdgeInsets.all(6),
//                     color: AppThemes.lightTextFieldBackGroundColor,
//                     child: Icon(Icons.add,
//                         color: AppThemes.lightButtonBackGroundColor,
//                         size: 20))),
//           ),
//         ],
//       ),
//       // CheckOutProductListTile(
//       //   image: AllImages.tofu,
//       //   name: "Tofu",
//       //   weight: "0.5 KG",
//       //   displayPrice: "₹ 50.00",
//       //   actualPrice: "₹ 35.00",
//       //   onTileTap: () {
//       //     Get.to(ProductDetailScreen());
//       //   },
//       // )
//     );
//   }
//
//   CouponModel? couponModel;
//   getCouponCodeList() async {
//     var request =
//     http.Request('POST', Uri.parse('${Urls.baseUrl}d_couponlist.php'));
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResult = await response.stream.bytesToString();
//       final jsonResult = CouponModel.fromJson(json.decode(finalResult));
//       setState(() {
//         couponModel = jsonResult;
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   String? couponValue;
//   var totalValue;
//   applyCouponCode(String id) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userid = prefs.getString('userId');
//     print("checking user id ${userid}");
//     var headers = {'Content-Type': 'application/json'};
//     var request =
//     http.Request('POST', Uri.parse('${Urls.baseUrl}d_check_coupon.php'));
//     request.body = json.encode({"uid": "${userid}", "cid": "${id}"});
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResult = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResult);
//       setState(() {
//         couponValue = jsonResponse['data']['c_value'];
//       });
//       totalValue = int.parse(cartModel!.getCartList!.total.toString()) -
//           int.parse(couponValue.toString());
//       print("coupon value here ${couponValue} and ${totalValue}");
//       Fluttertoast.showToast(msg: "${jsonResponse['ResponseMsg']}");
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   String? selectedPayment;
//
//   placeOrder() async {
//     print("cccccccccccccc");
//     var datevalue = DateTime.now();
//     var currentDate = datevalue.toString();
//     print("current date ${currentDate}");
//     var splitData = currentDate.split(" ");
//     print("ok final date ${splitData[0]}");
//
//     List productList = [];
//     List subscriptionProductList = [];
//
//     for (var i = 0; i < cartModel!.getCartList!.orderProductData!.length; i++) {
//       productList.add({
//         'product_id':
//         '${cartModel!.getCartList!.orderProductData![i].productId}',
//         "title": "${cartModel!.getCartList!.orderProductData![i].productName}",
//         "price": "${cartModel!.getCartList!.orderProductData![i].productPrice}",
//         "qty": "${cartModel!.getCartList!.orderProductData![i].quatity}",
//         "discount": "0",
//         "image": "${cartModel!.getCartList!.orderProductData![i].productImage}"
//       });
//       subscriptionProductList.add({
//         'product_id':
//         '${cartModel!.getCartList!.orderProductData![i].productId}',
//         "title": "${cartModel!.getCartList!.orderProductData![i].productName}",
//         "sprice":
//         "${cartModel!.getCartList!.orderProductData![i].productPrice}",
//         "qty": "${cartModel!.getCartList!.orderProductData![i].quatity}",
//         "discount": "0",
//         "image": "${cartModel!.getCartList!.orderProductData![i].productImage}",
//         "startdate":
//         "${cartModel!.getCartList!.orderProductData![i].startDate}",
//         "end_date": "${cartModel!.getCartList!.orderProductData![i].endDate}",
//         "select_days":
//         "${cartModel!.getCartList!.orderProductData![i].deliveryDay}",
//         "total_deliveries":
//         "${cartModel!.getCartList!.orderProductData![i].deliveryDay}",
//         "tslot": "${cartModel!.getCartList!.orderProductData![i].timeSlot}"
//       });
//       print("oooooooooo ${productList} and ${productList.length}");
//     }
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userid = prefs.getString('userId');
//     var headers = {
//       'Content-Type': 'application/json',
//       'Cookie': 'PHPSESSID=eb401b2c69e7a95bf7d8a293c20162d1'
//     };
//     var request =
//     http.Request('POST', Uri.parse('${Urls.baseUrl}d_order_now.php'));
//     if (cartModel!.getCartList!.orderProductData![0].subscribe_type == "0") {
//       request.body = json.encode({
//         "type": "Normal",
//         "p_method_id": "${selectedPayment}",
//         "uid": "${userid}",
//         "ndate": "${splitData[0]}",
//         "full_address": "${selectedAddress['address']}",
//         "d_charge": "0",
//         "cou_id": couponValue == null || couponValue == "" ? "0" : "1",
//         "landmark": "",
//         "wall_amt": "0",
//         "cou_amt": "${couponValue.toString()}",
//         "tslot": totalValue == null || totalValue == ""
//             ? "${cartModel!.getCartList!.total}"
//             : "${totalValue}",
//         "transaction_id": "1",
//         "product_total": "${cartModel!.getCartList!.total}",
//         "product_subtotal": "${cartModel!.getCartList!.total}",
//         "a_note": "tes",
//         "name": "${selectedAddress['name']}",
//         "mobile": "${selectedAddress['mobile']}",
//         "ProductData": productList,
//         // [
//         //   {
//         //     "title": "285",
//         //     "price": "1",
//         //     "qty": "1",
//         //     "discount": "2",
//         //     "image": "a.jpg"
//         //   }
//         // ]
//       });
//     } else {
//       request.body = json.encode({
//         "type": "subscription",
//         "p_method_id": "${selectedPayment}",
//         "uid": "${userid}",
//         "ndate": "${splitData[0]}",
//         "full_address": "${selectedAddress['address']}",
//         "d_charge": "0",
//         "cou_id": couponValue == null || couponValue == "" ? "0" : "1",
//         "landmark": "",
//         "wall_amt": "0",
//         "cou_amt": "${couponValue.toString()}",
//         "tslot": totalValue == null || totalValue == ""
//             ? "${cartModel!.getCartList!.total}"
//             : "${totalValue}",
//         "transaction_id": "1",
//         "product_total": couponValue ==  null || couponValue == "" ? "${cartModel!.getCartList!.total}" :"${totalValue}",
//         "product_subtotal": "${cartModel!.getCartList!.total}",
//         "a_note": "tes",
//         "name": "${selectedAddress['name']}",
//         "mobile": "${selectedAddress['mobile']}",
//         "ProductData": subscriptionProductList,
//         // [
//         //   {
//         //     "title": "285",
//         //     "price": "1",
//         //     "qty": "1",
//         //     "discount": "2",
//         //     "image": "a.jpg"
//         //   }
//         // ]
//       });
//     }
//
//     print("place order parameter ${request.body}");
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var finalResult = await response.stream.bytesToString();
//       final jsonResponse = json.decode(finalResult);
//       print("checking jsonresponse here now ${jsonResponse}");
//
//       Fluttertoast.showToast(msg: "${jsonResponse['ResponseMsg']}");
//       if (jsonResponse['Result'] == "true") {
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
//       }
//       setState(() {});
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   var remainingBalance;
//   updateWalletBalance() {
//     if (couponValue == null || couponValue == "") {
//       remainingBalance =
//           double.parse(getProfile!.orderHistory!.wallet.toString()) -
//               double.parse(cartModel!.getCartList!.total.toString());
//       setState(() {});
//     }else{
//       remainingBalance = double.parse(getProfile!.orderHistory!.wallet.toString()) -
//           double.parse(totalValue.toString());
//       setState(() {});
//     }
//     print(" checking remaining wallet here ${remainingBalance}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppThemes.primaryColor,
//         elevation: 1,
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         leading: InkWell(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.arrow_back_ios,
//               color: AppThemes.lightWhiteColor,
//             )),
//         title: Text(
//           "Checkout",
//           style: TextStyle(
//               color: AppThemes.lightWhiteColor,
//               fontSize: 18,
//               fontWeight: FontWeight.w600),
//         ),
//       ),
//       bottomNavigationBar: cartModel == null ||
//           cartModel!.getCartList!.orderProductData!.length == 0
//           ? SizedBox.shrink()
//           : Container(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         height: 45,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(color: AppThemes.primaryColor),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             cartModel == null ||
//                 cartModel!.getCartList!.orderProductData!.length == 0
//                 ? Text(
//               "Total  ",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500),
//             )
//                 : totalValue == null || totalValue == ""
//                 ?  InkWell(
//                 onTap: () {
//                   //  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
//                 },
//                 child: Text(
//                   "Total \u{20B9} ${cartModel!.getCartList!.total.toString()}",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500),
//                 ))
//                 : Text(
//               "Total \u{20B9} ${totalValue}",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500),
//             ),
//             InkWell(
//                 onTap: () async {
//                   // showModalBottomSheet<void>(
//                   //   context: context,
//                   //   builder: (BuildContext context) {
//                   //     return Container(
//                   //       padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
//                   //       height: 200,
//                   //       child: Column(
//                   //         children: [
//                   //           // InkWell(
//                   //           //   onTap:(){
//                   //           //
//                   //           //   },
//                   //           //   child: Container(
//                   //           //     height:45,
//                   //           //     padding: EdgeInsets.symmetric(horizontal: 10),
//                   //           //     alignment:Alignment.centerLeft,
//                   //           //     decoration:BoxDecoration(
//                   //           //       borderRadius: BorderRadius.circular(10),
//                   //           //       color: AppThemes.lightTextGreyColor.withOpacity(0.3),
//                   //           //     ),
//                   //           //     child: Text("Apply Coupon code"),
//                   //           //   ),
//                   //           // ),
//                   //        /// coupon section
//                   //         couponModel == null ? SizedBox.shrink() : couponModel!.couponlist!.length == 0 ? Center(child: Text("No coupon find"),) : Container(
//                   //           height:45,
//                   //           padding: EdgeInsets.symmetric(horizontal: 10),
//                   //           decoration:BoxDecoration(
//                   //             color: AppThemes.lightTextGreyColor.withOpacity(0.5),
//                   //             borderRadius: BorderRadius.circular(9),
//                   //           ),
//                   //           width:MediaQuery.of(context).size.width,
//                   //             child:   DropdownButton(
//                   //               isExpanded: true,
//                   //               underline: Container(),
//                   //               value: selectedCoupon,
//                   //               hint: Text("Select Coupon code"),
//                   //               icon: const Icon(Icons.keyboard_arrow_down),
//                   //               items: couponModel!.couponlist!.map((items) {
//                   //                 return DropdownMenuItem(
//                   //                   value: items.id.toString(),
//                   //                   child: Text(items.couponTitle.toString()),
//                   //                 );
//                   //               }).toList(),
//                   //               // After selecting the desired option,it will
//                   //               // change button value to selected value
//                   //               onChanged: (newValue) {
//                   //                 setState(() {
//                   //                   selectedCoupon = newValue as String?;
//                   //                 });
//                   //               },
//                   //             ),
//                   //           ),
//                   //
//                   //           /// address section
//                   //
//                   //           Container(
//                   //             margin: EdgeInsets.only(top: 10),
//                   //             child: Column(
//                   //               children: [
//                   //                 Text("Shipping Details",style: TextStyle(color: AppThemes.lightBlackColor,fontSize: 16,fontWeight: FontWeight.w600),),
//                   //                 Divider(),
//                   //                 InkWell(
//                   //                   onTap: ()async{
//                   //                     var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAddress()));
//                   //                     print("checking result here ${result}");
//                   //                     if(result == null){
//                   //                     }
//                   //                     else{
//                   //                       setState(() {
//                   //                         selectedAddress = result;
//                   //                       });
//                   //                     }
//                   //                     setState(() {
//                   //                     });
//                   //                     print("selected address here ${selectedAddress['name']} ");
//                   //                   },
//                   //                   child: selectedAddress == null || selectedAddress == "" || selectedAddress == "null" ? Container(
//                   //                     height: 45,
//                   //                     width: MediaQuery.of(context).size.width/2,
//                   //                     alignment: Alignment.center,
//                   //                     decoration: BoxDecoration(
//                   //                       color: AppThemes.primaryColor,
//                   //                       borderRadius: BorderRadius.circular(7)
//                   //                     ),
//                   //                     child:  Text("Add Address",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
//                   //
//                   //                     // Column(
//                   //                     //   crossAxisAlignment: CrossAxisAlignment.start,
//                   //                     //   children: [
//                   //                     //     Text("${selectedAddress}",style: TextStyle(fontWeight: FontWeight.w500),),
//                   //                     //     Divider(),
//                   //                     //     Text("${addressModel!.addressList![i].mobile}, ${addressModel!.addressList![i].address}, ${addressModel!.addressList![i].type}",style: TextStyle(fontWeight: FontWeight.w500),)
//                   //                     //   ],
//                   //                     // ),
//                   //
//                   //                   ) : Container(
//                   //                     child: Column(
//                   //                       children: [
//                   //                         Text("${selectedAddress['name']}",style: TextStyle(fontWeight: FontWeight.w500),),
//                   //                         Divider(),
//                   //                         Text("${selectedAddress['mobile']}, ${selectedAddress['address']}, ${selectedAddress['type']}",style: TextStyle(fontWeight: FontWeight.w500),)
//                   //                       ],
//                   //                     ),
//                   //                   ) ,
//                   //                 )
//                   //               ],
//                   //             ),
//                   //           ),
//                   //
//                   //         ],
//                   //       ),
//                   //     );
//                   //   },
//                   // );
//                   if (selectedAddress == null || selectedAddress == "") {
//                     Fluttertoast.showToast(msg: "Address is required");
//                   } else if (selectedPayment == null ||
//                       selectedPayment == "") {
//                     Fluttertoast.showToast(
//                         msg: "Payment method is required");
//                   } else {
//                     if (selectedPayment == 1 || selectedPayment == "1") {
//                       openCheckout();
//                     } else {
//                       placeOrder();
//                     }
//                   }
//                 },
//                 child: Text(
//                   "PROCEED ",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16),
//                 ))
//           ],
//         ),
//       ),
//       backgroundColor:
//       isDark ? Colors.black : AppThemes.lightTextFieldBackGroundColor,
//       body: ListView(
//         shrinkWrap: true,
//         children: [
//           // Container(
//           //   height: 50,
//           //   padding: EdgeInsets.only(left: 25, right: 25,top: 10),
//           //   margin: EdgeInsets.only(top: 10),
//           //   child: Row(
//           //     crossAxisAlignment: CrossAxisAlignment.start,
//           //   //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: [
//           //       InkWell(
//           //         onTap: () {
//           //           Get.back();
//           //         },
//           //         child: Icon(Icons.arrow_back),
//           //       ),
//           //       SizedBox(width: 10,),
//           //       Text(
//           //         getTranslator("checkout"),
//           //         style: Theme.of(context)
//           //             .textTheme
//           //             .headline5!
//           //             .copyWith(
//           //             fontWeight: FontWeight.w800,
//           //             letterSpacing: 0.5,
//           //             fontSize: 20),
//           //       ),
//           //
//           //       // Column(
//           //       //   mainAxisAlignment: MainAxisAlignment.start,
//           //       //   children: [
//           //       //     InkWell(
//           //       //       onTap: () {
//           //       //         Get.back();
//           //       //       },
//           //       //       child: Icon(Icons.arrow_back),
//           //       //     ),
//           //       //   ],
//           //       // )
//           //     ],
//           //   ),
//           // ),
//
//           Container(
//             height: cartModel == null ||
//                 cartModel!.getCartList!.orderProductData!.length == 0
//                 ? MediaQuery.of(context).size.height / 1
//                 : MediaQuery.of(context).size.height / 2,
//             decoration: BoxDecoration(
//                 color: isDark
//                     ? AppThemes.DarkModeColor
//                     : AppThemes.lightWhiteBackGroundColor,
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(15),
//                     topRight: Radius.circular(15))),
//             child: Container(
//               // constraints: BoxConstraints(
//               //     minHeight: MediaQuery.of(context).size.height - 40),
//               child: cartModel == null
//                   ? Center(
//                 child: CircularProgressIndicator(),
//               )
//                   : cartModel!.getCartList!.orderProductData!.length == 0
//                   ? Center(
//                 child: Text(
//                   "No data to show",
//                   style: TextStyle(
//                       color: isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16),
//                 ),
//               )
//                   : ListView.separated(
//                 itemCount:
//                 cartModel!.getCartList!.orderProductData!.length,
//                 physics: ScrollPhysics(),
//                 separatorBuilder: (context, index) {
//                   return SizedBox(height: 20);
//                 },
//                 itemBuilder: (context, index) {
//                   return productItem(index);
//                 },
//               ),
//             ),
//           ),
//
//           /// coupon section
//           cartModel == null
//               ? SizedBox.shrink()
//               : cartModel!.getCartList!.orderProductData!.length == 0
//               ? SizedBox()
//               : Container(
//               width: MediaQuery.of(context).size.width,
//               padding:
//               EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               margin:
//               EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color:  isDark ? AppThemes.smoothBlack: AppThemes.lightWhiteColor,
//                   border: Border.all(color: AppThemes.primaryColor)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Apply coupons",
//                     style: TextStyle(
//                         color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   couponModel == null
//                       ? SizedBox.shrink()
//                       : couponModel!.couponlist!.length == 0
//                       ? Center(
//                     child: Text("No coupon find",style: TextStyle(color: isDark? AppThemes.lightWhiteColor : AppThemes.lightBlackColor),),
//                   )
//                       : Container(
//                     height: 45,
//                     padding:
//                     EdgeInsets.symmetric(horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: Color(0xffF9F9F9),
//                       borderRadius: BorderRadius.circular(9),
//                     ),
//                     width: MediaQuery.of(context).size.width,
//                     child: DropdownButton(
//                       isExpanded: true,
//                       underline: Container(),
//                       value: selectedCoupon,
//                       hint: Text("Select Coupon code"),
//                       icon: const Icon(
//                           Icons.keyboard_arrow_down),
//                       items: couponModel!.couponlist!
//                           .map((items) {
//                         return DropdownMenuItem(
//                           value: items.id.toString(),
//                           child: Text(
//                               items.couponTitle.toString()),
//                         );
//                       }).toList(),
//                       onChanged: (newValue) {
//                         setState(() {
//                           selectedCoupon =
//                           newValue as String?;
//                         });
//                         print(
//                             "checking coupon item ${selectedCoupon}");
//                         applyCouponCode(
//                             selectedCoupon.toString());
//                       },
//                     ),
//                   ),
//                 ],
//               )),
//
//           /// address section
//
//           cartModel == null
//               ? SizedBox.shrink()
//               : cartModel!.getCartList!.orderProductData!.length == 0
//               ? SizedBox()
//               : Container(
//               width: MediaQuery.of(context).size.width,
//               padding:
//               EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//               margin:
//               EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color:  isDark ? AppThemes.smoothBlack: AppThemes.lightWhiteColor,
//                   border: Border.all(color: AppThemes.primaryColor)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Shipping Address",
//                         style: TextStyle(
//                             color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600),
//                       ),
//                       selectedAddress == null ||
//                           selectedAddress == "" ||
//                           selectedAddress == "null"
//                           ? InkWell(
//                         onTap: () async {
//                           var result = await Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       ManageAddress()));
//                           print("checking result here ${result}");
//                           if (result == null) {
//                           } else {
//                             setState(() {
//                               selectedAddress = result;
//                             });
//                           }
//                           setState(() {});
//                           print(
//                               "selected address here ${selectedAddress['name']} ");
//                         },
//                         child: Container(
//                           height: 40,
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 15),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: AppThemes.primaryColor,
//                               borderRadius:
//                               BorderRadius.circular(7)),
//                           child: Text(
//                             "Add",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 16),
//                           ),
//                         ),
//                       )
//                           : SizedBox()
//                     ],
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       // var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => ManageAddress()));
//                       // print("checking result here ${result}");
//                       // if(result == null){
//                       // }
//                       // else{
//                       //   setState(() {
//                       //     selectedAddress = result;
//                       //   });
//                       // }
//                       // setState(() {
//                       // });
//                       // print("selected address here ${selectedAddress['name']} ");
//                     },
//                     child: selectedAddress == null ||
//                         selectedAddress == "" ||
//                         selectedAddress == "null"
//                         ? SizedBox.shrink()
//                         : Container(
//                       child: Column(
//                         crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${selectedAddress['name']}",
//                             style: TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                           Divider(),
//                           Text(
//                             "${selectedAddress['mobile']}, ${selectedAddress['address']}, ${selectedAddress['type']}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               )),
//
//           /// order summary section
//
//           cartModel == null
//               ? SizedBox.shrink()
//               : cartModel!.getCartList!.orderProductData!.length == 0
//               ? SizedBox()
//               : Container(
//             width: MediaQuery.of(context).size.width,
//             padding:
//             EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             margin:
//             EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color:  isDark ? AppThemes.smoothBlack: AppThemes.lightWhiteColor,
//                 border: Border.all(color: AppThemes.primaryColor)),
//             child: Column(
//               children: [
//                 Text(
//                   "Order Summary",
//                   style: TextStyle(
//                       color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Container(
//                   child: Column(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Sub Total",
//                             style: TextStyle(
//                                 color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14),
//                           ),
//                           cartModel == null
//                               ? SizedBox.shrink()
//                               : Text(
//                             cartModel!.getCartList!.total ==
//                                 null
//                                 ? "\u{20B9} 0"
//                                 : "\u{20B9} ${cartModel!.getCartList!.total}",
//                             style: TextStyle(
//                                 color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Discount",
//                             style: TextStyle(
//                                 color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14),
//                           ),
//                           totalValue == null || totalValue == ""
//                               ? Text(
//                             "\u{20B9} 0",
//                             style: TextStyle(
//                                 color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14),
//                           )
//                               : Text(
//                             "\u{20B9} ${couponValue}",
//                             style: TextStyle(
//                                 color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14),
//                           )
//                         ],
//                       ),
//                       // SizedBox(
//                       //   height: 8,
//                       // ),
//                       // Row(
//                       //   crossAxisAlignment: CrossAxisAlignment.center,
//                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //   children: [
//                       //     Text("Delivery Charge",style: TextStyle(color: AppThemes.lightBlackColor,fontWeight: FontWeight.w500,fontSize: 14),),
//                       //     Text("\u{20B9} 0",style: TextStyle(color: AppThemes.lightBlackColor,fontWeight: FontWeight.w500,fontSize: 14),)
//                       //   ],
//                       // ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Total",
//                             style: TextStyle(
//                                 color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14),
//                           ),
//                           totalValue == null || totalValue == ""
//                               ? Text(
//                               "\u{20B9} ${cartModel!.getCartList!.total}",
//                               style: TextStyle(
//                                   color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 14))
//                               : Text(
//                             "\u{20B9} ${totalValue}",
//                             style: TextStyle(
//                                 color:
//                                 AppThemes.lightBlackColor,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 14),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           /// wallet section
//
//           selectedPayment == "5" || selectedPayment == 5 ?   Container(
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color:  isDark ? AppThemes.smoothBlack: AppThemes.lightWhiteColor,
//                 border: Border.all(color: AppThemes.primaryColor)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Wallet Remaining Balance",
//                   style: TextStyle(
//                       color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 getProfile == null ? SizedBox.shrink() :  remainingBalance == null || remainingBalance == "" ?  Text("\u{20B9} ${getProfile!.orderHistory!.wallet}") : Text("\u{20B9} ${remainingBalance}")
//               ],
//             ),
//           ) : SizedBox.shrink(),
//
//           /// payment section
//
//           cartModel == null
//               ? SizedBox.shrink()
//               : cartModel!.getCartList!.orderProductData!.length == 0
//               ? SizedBox()
//               : Container(
//             width: MediaQuery.of(context).size.width,
//             padding:
//             EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             margin:
//             EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color:  isDark ? AppThemes.smoothBlack: AppThemes.lightWhiteColor,
//                 border: Border.all(color: AppThemes.primaryColor)),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Select Payment Method",
//                   style: TextStyle(
//                       color:  isDark ? AppThemes.lightWhiteColor: AppThemes.lightBlackColor,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 paymentListModel == null
//                     ? Center(
//                   child: CircularProgressIndicator(
//                     color: AppThemes.primaryColor,
//                   ),
//                 )
//                     : paymentListModel!.data!.length == 0
//                     ? Center(
//                   child: Text("No Payment to show"),
//                 )
//                     : Container(
//                     child: ListView.builder(
//                         shrinkWrap: true,
//                         itemCount:
//                         paymentListModel!.data!.length,
//                         itemBuilder: (c, i) {
//                           return RadioListTile(
//                             contentPadding: EdgeInsets.zero,
//                             dense: true,
//                             visualDensity: VisualDensity(
//                                 horizontal: -4, vertical: -4),
//                             title: Text(
//                                 "${paymentListModel!.data![i].title}"),
//                             value:
//                             "${paymentListModel!.data![i].id}",
//                             groupValue: selectedPayment,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedPayment =
//                                     value.toString();
//                               });
//                               if (selectedPayment == "1" ||
//                                   selectedAddress == 1) {
//                               } else {}
//                               print(
//                                   "selected payment here ${selectedPayment}");
//                               updateWalletBalance();
//                             },
//                             activeColor:
//                             AppThemes.primaryColor,
//                             selectedTileColor:
//                             AppThemes.primaryColor,
//                           );
//                         })
//                   // Column(
//                   //   children: [
//                   //     RadioListTile(
//                   //       contentPadding: EdgeInsets.zero,
//                   //       dense: true,
//                   //       visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//                   //       title: Text("RazorPay"),
//                   //       value: "razorpay",
//                   //       groupValue: selectedPayment,
//                   //       onChanged: (value){
//                   //         setState(() {
//                   //           selectedPayment = value.toString();
//                   //         });
//                   //       },
//                   //       activeColor: AppThemes.primaryColor,
//                   //       selectedTileColor: AppThemes.primaryColor,
//                   //     ),
//                   //
//                   //     RadioListTile(
//                   //       contentPadding: EdgeInsets.zero,
//                   //       dense: true,
//                   //       visualDensity: VisualDensity(horizontal: -4, vertical: -4),
//                   //       title: Text("COD"),
//                   //       value: "cod",
//                   //       groupValue: selectedPayment,
//                   //       onChanged: (value){
//                   //         setState(() {
//                   //           selectedPayment = value.toString();
//                   //         });
//                   //       },
//                   //       activeColor: AppThemes.primaryColor,
//                   //       selectedTileColor: AppThemes.primaryColor,
//                   //     ),
//                   //
//                   //   ],
//                   // ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   getFirstNLastMergin(int index, int length) {
//     if (index == 0) {
//       return EdgeInsets.only(left: 15, right: 15, top: 20);
//     } else if (index == length - 1) {
//       return EdgeInsets.only(left: 15, right: 15, bottom: 75);
//     }
//     return EdgeInsets.only(left: 15, right: 15);
//   }
// }
