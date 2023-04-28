import 'dart:convert';

import 'package:ez/constant/global.dart';
import 'package:ez/models/AddToCartModel.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/FoodCategoryModel.dart';
import '../../../models/GetProductsModel.dart';
import '../../../models/OfferBannerModel.dart';
import '../../../models/car_model.dart';
import 'package:http/http.dart' as http;
import 'cart.dart';
import 'cart_new.dart';


class GroceryDetails extends StatefulWidget {
  String? id;
  String? product_id;
  GroceryDetails({Key? key, this.id, this.product_id,}) : super(key: key);
  @override
  State<GroceryDetails> createState() => _GroceryDetailsState();
}

var homelat;
var homeLong;

class _GroceryDetailsState extends State<GroceryDetails> {

  String? user_id;
  int _counter = 0;
  bool isVisible =true;

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

  List<int> count = [];

  Position? currentLocation;
  FoodCategoryModel? foodCategoryModel;

  Future getUserCurrentLocation() async {
    print("Home latttt and longg ${homelat} ${homeLong}");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((position) {
      if (mounted)
        setState(() {
          currentLocation = position;
          homelat = currentLocation?.latitude;
          homeLong = currentLocation?.longitude;
        });
    });
    print("LOCATION===" +currentLocation.toString());
  }

  @override
  void initState() {
    super.initState();
    // getProductsModel != null ?
    // _getProduct():
    //     Text("No Item Found");
    _getProduct();
    //addToCart();
  }

  GetProductsModel? getProductsModel;
  List<Imgssss> products = [];

  _getProduct() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var headers = {
      'Cookie': 'ci_session=7c15c6fc740d1ef52dc736a240a59131cfd99144'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/get_product_by_id'));
    request.fields.addAll({
      'v_id': widget.id.toString(),
    });
    print("Product vendrorr ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = GetProductsModel.fromJson(json.decode(finalResponse));
      print("Products response here nowwww $jsonResponse");
      print("final responseeee ${finalResponse}");
      if(jsonResponse.status == 1){
        String product_id = jsonResponse.imgssss![0].productId.toString();
        preferences.setString('product_id', product_id);
        print("Product id is ${product_id}");
        setState(() {
          getProductsModel = GetProductsModel.fromJson(json.decode(finalResponse));
        });
      }
      else{
        setState(() {
        });
      }
    }
    else {
      print(response.reasonPhrase);
    }
  }


  AddToCartModel? addToCartModel;
  addToCart(String productId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user_id= preferences.getString("user_id");
    var headers = {
      'Cookie': 'ci_session=76282680e65886d44b5d7a8a0b61ac57d57ba3b3'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://sodindia.com/api/add_to_cart'));
    request.fields.addAll({
      'user_id': user_id ?? '',
      'product_id': productId,
      'quantity': _counter.toString(),
      'vendor_id': widget.id.toString(),
    });
    print("Add To Cart Requset ${request.fields}");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200){
      var finalResponse = await response.stream.bytesToString();
      final jsonResponse = AddToCartModel.fromJson(json.decode(finalResponse));
      print("Get Userrrrr cartttt$jsonResponse");
      setState(() {
        addToCartModel = AddToCartModel.fromJson(json.decode(finalResponse));
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Products here nowww ${getProductsModel!.imgssss![0].productImage}");
    print("Products here_________ ${getProductsModel!.imgssss![0].catName}");
    print("Products here%%%%%%%%%% ${getProductsModel!.imgssss![0].variantName}");
    print("service found ${getProductsModel!.msg}");
    return Scaffold(
      backgroundColor: Color(0xffF1F5F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white38,
        title: Text("Food", style: TextStyle(color: backgroundblack, fontWeight: FontWeight.w900, fontSize: 22),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: backgroundblack),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewCart()));
            }, icon: Icon(Icons.shopping_cart, color: backgroundblack),
            ),
          ),
        ],
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
      SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top:0),
          child : Column(
            children: [
              // Container(
              //   height: MediaQuery.of(context).size.height/40,
              //   // height: MediaQuery.of(context).size.height-85.0-75,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: const BoxDecoration(
              //       color: appColorOrange,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(45),
              //         topRight: Radius.circular(45),
              //       )),
              //   // child: Padding(
              //   //   padding: const EdgeInsets.only(top:70, left: 30.0, right: 30),
              //   //   child: SingleChildScrollView(
              //   //     child: Text("khjjhj"),
              //   //   ),
              //   // ),
              // ),
              Container(
                height: MediaQuery.of(context).size.height/1.4,
                width: MediaQuery.of(context).size.width/1,
                child: getProductsModel == null  || getProductsModel == ""  ? Center(
                  child: CircularProgressIndicator(color: backgroundblack,),
                ) : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: getProductsModel!.imgssss!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.all(15),
                        child: Scrollbar(
                          thickness: 10,
                          trackVisibility: true,
                          // isAlwaysShown: true,
                          thumbVisibility: true,
                          radius: Radius.circular(10),
                          child: Container(
                            height: 130,
                            child: Card(
                                elevation: 10,
                                semanticContainer: true,
                                // shape: RoundedRectangleBorder(
                                //   borderRadius: BorderRadius.circular(20.0),
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
                                    //       height: 90,width: 5),
                                    // ),
                                    SizedBox(width: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                                      child: Container(
                                        // color: Colors.white,
                                        height: 90,
                                        width: 90,
                                        child: Image.network("${getProductsModel!.imgssss![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,),
                                      ),
                                    ),
                                    // Center(
                                    //   child: ClipRRect(
                                    //       borderRadius: BorderRadius.circular(100),
                                    //       // radius: 40,
                                    //       child: getProductsModel == null ? Center(
                                    //         child: Image.asset("assets/images/loader1.gif"),
                                    //       ) : Image.network("${getProductsModel!.imgssss![index].productImage}", height: 70, width: 70, fit: BoxFit.fill,)
                                    //   ),
                                    // ),
                                    // Text("Imageee ${getProductsModel!.imgssss![index].productImage}"),
                                    SizedBox(width: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 24.0, left: 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${getProductsModel!.imgssss![index].productName}",style: TextStyle(color: backgroundblack,fontWeight: FontWeight.bold,fontSize: 15),),
                                          SizedBox(height: 5,),
                                          Text("${getProductsModel!.imgssss![index].variantName}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13),),
                                          SizedBox(height: 5,),
                                          Row(
                                            children: [
                                              Text("₹ ${getProductsModel!.imgssss![index].productPrice}",style: TextStyle(color: appColorBlack,fontSize: 13)),
                                              SizedBox(width: 7),
                                              Text("₹ ${getProductsModel!.imgssss![index].sellingPrice}",style: TextStyle(color: appColorBlack,fontWeight: FontWeight.bold,fontSize: 13)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    isVisible ?
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isVisible = false;
                                          // addToCart(getProductsModel!.imgssss![index].productId ??'');
                                          // products.add(getProductsModel!.imgssss![index]);
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 35.0),
                                        child: Container(
                                          height:40,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: backgroundblack,
                                          ),
                                          child: Center(
                                              child: Text("Add",style: TextStyle(color: Colors.white, fontSize: 16))),
                                        ),
                                      ),
                                      // Card(
                                      //   elevation: 2,
                                      //   child: Container(
                                      //     height:40,
                                      //     width: 70,
                                      //     decoration: BoxDecoration(border: Border.all(color:Colors.blue)),
                                      //     child: Center(child: Text('Add',style: TextStyle(color:Colors.green),)),
                                      //   ),
                                      // ),
                                    ):
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
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
                                              if (_counter >= 1) {
                                                _counter -= 1;
                                                setState(() {});
                                                addToCart(getProductsModel!.imgssss![index].productId ??'');
                                              }
                                            },
                                            // onTap:() {
                                            //   // addToCart(getProductsModel!.imgssss![index].productId ??'');
                                            //   _decrimentConter;
                                            // },
                                            child: (
                                                Center(
                                                    child: Icon(Icons.remove,size: 20,color: appColorBlack)
                                                )
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            '$_counter',
                                            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(width: 6),
                                        // SizedBox(width: 60,),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: InkWell(
                                            onTap: () {
                                              _counter += 1;
                                              setState(() {});
                                              addToCart(getProductsModel!.imgssss![index].productId ??'');
                                            },
                                            child: (
                                                Center(child: const Icon(Icons.add,size: 20,color: appColorBlack))),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Spacer(),
                                    // Center(
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //         color: appColorOrange,
                                    //         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))),
                                    //     height: 80,width: 8),
                                    // ),
                                  ],
                                )),
                          ),
                        ));
                  },
                ),
              ),
              SizedBox(height: 50,),
              isVisible ?
              SizedBox.shrink():
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewCart()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewCart(allProducts: products,)));
                },
                child: addToCartModel == null  ? CircularProgressIndicator(color: backgroundblack,) : Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width/1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: appColorOrange),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text("2 iTEMS |",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack),),
                        // SizedBox(width: 5),
                        Text("₹ ${addToCartModel!.price}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: backgroundblack)),
                        Text("View Cart >",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: backgroundblack))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}