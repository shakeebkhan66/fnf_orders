import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fnf_orders/change_password.dart';
import 'package:fnf_orders/constants.dart';
import 'package:fnf_orders/login_page.dart';
import 'package:http/http.dart' as http;
import 'Models/OrdersModel.dart';
import 'Services/local_notification_service.dart';
import 'Utils/shared_class.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  // TODO Fetch Orders List From Server
  // Creating a List of OrdersModel
  List<OrdersModel> userList = [];
  var token = Constants.preferences?.getString('Token');
  var fcm = Constants.preferences?.getString('FCM');

  sendFcmToken() async {
    final response = await http.put(
        Uri.parse('http://192.168.100.240:5000/api/update-fcm-token/'),
        body: {
          "fcm_token": fcm,
        },
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'Authorization': 'Token ${token}'
        });
    if (response.body == 200) {
      var data = response.body.toString();
      print(data);
      print("Send FCM Token Successfully");
    } else {
      print("Failed");
    }
  }

  // TODO show firebase notifications
  // showFirebaseNotifications(){
  //   //Gives You the Message on Which User Taps
  //   //And It Opened the App from Terminated State
  //   FirebaseMessaging.instance.getInitialMessage().then((message) {
  //     if (message != null) {
  //       final routeFromMessage = message.data["route"];
  //       Navigator.pushNamed(context, routeFromMessage);
  //     }
  //   });
  //
  //   // This Stream will call only When the Application in the Foreground not in the Background
  //   FirebaseMessaging.onMessage.listen((message) {
  //     if (message.notification != null) {
  //       print(message.notification!.body);
  //       print(message.notification!.title);
  //     }
  //     LocalNotificationService.display(message);
  //   });
  //
  //   // When the App is in the Background but Opened and User Taps on the notification
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //     final routeFromMessage = message.data["route"];
  //     Navigator.pushNamed(context, routeFromMessage);
  //     // print(routeFromMessage);
  //   });
  // }

  Future<List<OrdersModel>> getUserApi() async {
    final response = await http
        .get(Uri.parse('http://192.168.100.240:5000/api/myorders/'), headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization': 'Token ${token}',
    });
    var data = jsonDecode(response.body.toString());
    print(fcm);
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(OrdersModel.fromJson(i));
        // // If you simple want to print one simple value then try this
        // print(i['name']);
      }
      return userList;
    } else {
      return userList;
    }
  }

  // TODO Popup Menu Button
  _myPopupButton() {
    return PopupMenuButton(
        child: const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.more_vert_rounded,
              color: Colors.redAccent,
              size: 20,
            )),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  onTap: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const ChangePassword()));
                  },
                  leading: const Icon(
                    Icons.change_circle,
                    color: Colors.green,
                  ),
                  title: const Text(
                    "Change Password",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: (){
                    Constants.preferences
                        ?.setBool("loggedIn", false);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const LoginPage()));
                  },
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
                  title: const Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                value: 2,
              )
            ]);
  }

  // TODO TITLE HEADING
  // Widget _buildExpansionTile() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //     child: Card(
  //       color: const Color(0xffFAF9F6),
  //       child: ExpansionTile(
  //         backgroundColor: const Color(0xffFAF9F6),
  //         title: const Text("Order ID : 1", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
  //         children: [
  //           // const Divider(thickness: 1.3,),
  //           Card(
  //             color: mainColor,
  //             child: ExpansionTile(
  //               backgroundColor: mainColor,
  //               iconColor: Colors.white,
  //               textColor: Colors.white,
  //               collapsedTextColor: Colors.white,
  //               collapsedIconColor: Colors.white,
  //               title: const Text("Customer", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
  //               children: [
  //                 Row(
  //                   children: const [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 26.0),
  //                       child: Align(
  //                           alignment: Alignment.topLeft,
  //                           child: Text(
  //                             "Name",
  //                             style: TextStyle(
  //                                 color: Colors.white, fontWeight: FontWeight.bold),
  //                           )),
  //                     ),
  //                     SizedBox(width: 79,),
  //                     Text("Shakeeb Khan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
  //                   ],
  //                 ),
  //                 const Divider(thickness: 1.3, color: Colors.white,),
  //                 Row(
  //                   children: const [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 26.0),
  //                       child: Align(
  //                           alignment: Alignment.topLeft,
  //                           child: Text(
  //                             "Phone#",
  //                             style: TextStyle(
  //                                 color: Colors.white, fontWeight: FontWeight.bold),
  //                           )),
  //                     ),
  //                     SizedBox(width: 67,),
  //                     Text("+923147896819", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
  //                   ],
  //                 ),
  //                 const Divider(thickness: 1.3, color: Colors.white,),
  //                 Row(
  //                   children: const [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 25.0),
  //                       child: Align(
  //                           alignment: Alignment.topLeft,
  //                           child: Text(
  //                             "Address",
  //                             style: TextStyle(
  //                                 color: Colors.white, fontWeight: FontWeight.bold),
  //                           )),
  //                     ),
  //                     SizedBox(width: 67,),
  //                     Text("Timber Market", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 10.0,),
  //               ],
  //             ),
  //           ),
  //           // const Divider(thickness: 1.3,),
  //           Card(
  //             color: mainColor,
  //             child: ExpansionTile(
  //               initiallyExpanded: true,
  //               backgroundColor: mainColor,
  //               iconColor: Colors.white,
  //               textColor: Colors.white,
  //               collapsedTextColor: Colors.white,
  //               collapsedIconColor: Colors.white,
  //               title: const Text("Products", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
  //               children: [
  //                 Row(
  //                   children: const [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 26.0),
  //                       child: Align(
  //                           alignment: Alignment.topLeft,
  //                           child: Text(
  //                             "Name",
  //                             style: TextStyle(
  //                                 color: Colors.white, fontWeight: FontWeight.bold),
  //                           )),
  //                     ),
  //                     SizedBox(width: 67,),
  //                     Text("Dalda Ghee", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
  //                   ],
  //                 ),
  //                 const Divider(thickness: 1.3, color: Colors.white,),
  //                 Row(
  //                   children: const [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 25.0),
  //                       child: Align(
  //                           alignment: Alignment.topLeft,
  //                           child: Text(
  //                             "Quantity",
  //                             style: TextStyle(
  //                                 color: Colors.white, fontWeight: FontWeight.bold),
  //                           )),
  //                     ),
  //                     SizedBox(width: 67,),
  //                     Text("3", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 10,),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(height: 15,),
  //           Row(
  //             children: const [
  //               Padding(
  //                 padding: EdgeInsets.only(left: 25.0),
  //                 child: Align(
  //                     alignment: Alignment.topLeft,
  //                     child: Text(
  //                       "Total Amount",
  //                       style: TextStyle(
  //                           color: Colors.black87, fontWeight: FontWeight.bold),
  //                     )),
  //               ),
  //               SizedBox(width: 67,),
  //               Text("200", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),),
  //             ],
  //           ),
  //           const Divider(thickness: 1.3,),
  //           Row(
  //             children: const [
  //               Padding(
  //                 padding: EdgeInsets.only(left: 25.0),
  //                 child: Align(
  //                     alignment: Alignment.topLeft,
  //                     child: Text(
  //                       "Discount Amount",
  //                       style: TextStyle(
  //                           color: Colors.black87, fontWeight: FontWeight.bold),
  //                     )),
  //               ),
  //               SizedBox(width: 44,),
  //               Text("50", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),),
  //             ],
  //           ),
  //           const Divider(thickness: 1.3,),
  //           Row(
  //             children: const [
  //               Padding(
  //                 padding: EdgeInsets.only(left: 25.0),
  //                 child: Align(
  //                     alignment: Alignment.topLeft,
  //                     child: Text(
  //                       "Subtotal Amount",
  //                       style: TextStyle(
  //                           color: Colors.black87, fontWeight: FontWeight.bold),
  //                     )),
  //               ),
  //               SizedBox(width: 46,),
  //               Text("150", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),),
  //             ],
  //           ),
  //           const Divider(thickness: 1.3,),
  //           Row(
  //             children: const [
  //               Padding(
  //                 padding: EdgeInsets.only(left: 25.0),
  //                 child: Align(
  //                     alignment: Alignment.topLeft,
  //                     child: Text(
  //                       "Status",
  //                       style: TextStyle(
  //                           color: Colors.black87, fontWeight: FontWeight.bold),
  //                     )),
  //               ),
  //               SizedBox(width: 115,),
  //               Text("Pending", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),),
  //             ],
  //           ),
  //           const Divider(thickness: 1.3,),
  //           Row(
  //             children: [
  //               const Padding(
  //                 padding: EdgeInsets.only(left: 25.0),
  //                 child: Align(
  //                     alignment: Alignment.topLeft,
  //                     child: Text(
  //                       "Change Status",
  //                       style: TextStyle(
  //                           color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
  //                     )),
  //               ),
  //               const SizedBox(width: 50,),
  //               DropdownButton(
  //                 hint: const Text('Status Order'), // Not necessary for Option 1
  //                 value: _selectedLocation,
  //                 onChanged: (newValue) {
  //                   setState(() {
  //                     _selectedLocation = newValue.toString();
  //                   });
  //                 },
  //                 items: _locations.map((location) {
  //                   return DropdownMenuItem(
  //                     child: Text(location),
  //                     value: location,
  //                   );
  //                 }).toList(),
  //               ),
  //
  //             ],
  //           ),
  //           const Divider(thickness: 1.3,),
  //           const SizedBox(height: 20,),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  void initState() {
    sendFcmToken();
    // sleep(
    //     Duration(seconds: 1),
    // );
    // showFirebaseNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xfff2f3f7),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(color: mainColor),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Orders",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  shadows: [
                                    Shadow(
                                        offset: Offset(2.0, 2.0),
                                        blurRadius: 3.0,
                                        color: Colors.grey),
                                  ],
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 185,
                            ),
                            // CircleAvatar(
                            //   radius: 18,
                            //   backgroundColor: Colors.white,
                            //   foregroundColor: Colors.grey,
                            //   child: IconButton(
                            //     onPressed: () {
                            //       PopupMenuButton;
                            //     },
                            //     icon: const Icon(
                            //       CupertinoIcons.ellipsis_vertical,
                            //       color: Colors.redAccent,
                            //       size: 20,
                            //     ),
                            //   ),
                            // ),
                            _myPopupButton(),
                            const SizedBox(
                              width: 10,
                            ),
                            // CircleAvatar(
                            //   radius: 18,
                            //   backgroundColor: Colors.white,
                            //   foregroundColor: Colors.grey,
                            //   child: IconButton(
                            //     onPressed: () {
                            //       Constants.preferences
                            //           ?.setBool("loggedIn", false);
                            //       Navigator.pushReplacement(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (ctx) => const LoginPage()));
                            //     },
                            //     icon: const Icon(
                            //       Icons.logout,
                            //       color: Colors.redAccent,
                            //       size: 20,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ))),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: getUserApi(),
                    builder:
                        (context, AsyncSnapshot<List<OrdersModel>> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return ReusableRow(
                              orderID: snapshot.data![index].id.toString(),
                              customerName: "Shakeeb Khan",
                              customerPhoneNumber: "+923147896819",
                              customerAddress: "Ibrahim Town",
                              productID: snapshot
                                  .data![index].items![0].product!.id
                                  .toString(),
                              productName: userList[index]
                                  .items![0]
                                  .product!
                                  .name
                                  .toString(),
                              productPrice: snapshot
                                  .data![index].items![0].product!.price
                                  .toString(),
                              productUnit: snapshot
                                      .data![index].items![0].product!.weight
                                      .toString() +
                                  " " +
                                  snapshot.data![index].items![0].product!.uom
                                      .toString(),
                              totalAmount:
                                  snapshot.data![index].total.toString(),
                              discountAmount:
                                  snapshot.data![index].discount.toString(),
                              subTotalAmount:
                                  snapshot.data![index].subTotal.toString(),
                              status: snapshot.data![index].status.toString(),
                              quantity: snapshot.data![index].items![0].quantity
                                  .toString(),
                            );
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ReusableRow extends StatefulWidget {
  var orderID;
  String? customerName;
  String? customerPhoneNumber;
  String? customerAddress;
  String? productID;
  String? productName;
  var productPrice;
  var productUnit;
  var quantity;
  String? totalAmount;
  String? discountAmount;
  String? subTotalAmount;
  String? status;
  ReusableRow(
      {required this.orderID,
      required this.customerName,
      required this.customerPhoneNumber,
      required this.customerAddress,
      required this.productID,
      required this.productName,
      required this.productPrice,
      required this.productUnit,
      required this.quantity,
      required this.totalAmount,
      required this.discountAmount,
      required this.subTotalAmount,
      required this.status});

  @override
  State<ReusableRow> createState() => _ReusableRowState();
}

class _ReusableRowState extends State<ReusableRow> {
  @override
  Widget build(BuildContext context) {
    final List<String> _locations = [
      'Pending',
      'Received',
      'Processed',
      'Shipped',
      'Delivered',
      'Cancelled'
    ];
    String? _selectedLocation;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        color: const Color(0xffFAF9F6),
        child: ExpansionTile(
          backgroundColor: const Color(0xffFAF9F6),
          title: Text(
            "Order ID : ${widget.orderID}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          children: [
            // const Divider(thickness: 1.3,),
            Card(
              color: mainColor,
              child: ExpansionTile(
                backgroundColor: mainColor,
                iconColor: Colors.white,
                textColor: Colors.white,
                collapsedTextColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: const Text(
                  "Customer",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 26.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        width: 79,
                      ),
                      Text(
                        "${widget.customerName}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.3,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 26.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Phone#",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        width: 67,
                      ),
                      Text(
                        "${widget.customerPhoneNumber}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.3,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Address",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        width: 67,
                      ),
                      Text(
                        "${widget.customerAddress}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            // const Divider(thickness: 1.3,),
            Card(
              color: mainColor,
              child: ExpansionTile(
                initiallyExpanded: true,
                backgroundColor: mainColor,
                iconColor: Colors.white,
                textColor: Colors.white,
                collapsedTextColor: Colors.white,
                collapsedIconColor: Colors.white,
                title: const Text(
                  "Products",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 26.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "PID",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        width: 82,
                      ),
                      Text(
                        "${widget.productID}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.3,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 26.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        width: 67,
                      ),
                      Text(
                        "${widget.productName}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.3,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Quantity",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        width: 73,
                      ),
                      Text(
                        "${widget.quantity}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.3,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Price",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        width: 73,
                      ),
                      Text(
                        "${widget.productPrice}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1.3,
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Weight",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        width: 62,
                      ),
                      Text(
                        "${widget.productUnit}",
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Total Amount",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  width: 67,
                ),
                Text(
                  "${widget.totalAmount}",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            const Divider(
              thickness: 1.3,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Discount Amount",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  width: 44,
                ),
                Text(
                  "${widget.discountAmount}",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            const Divider(
              thickness: 1.3,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Subtotal Amount",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  width: 46,
                ),
                Text(
                  "${widget.subTotalAmount}",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            const Divider(
              thickness: 1.3,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Status",
                        style: TextStyle(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      )),
                ),
                const SizedBox(
                  width: 115,
                ),
                Text(
                  "${widget.status}",
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
            const Divider(
              thickness: 1.3,
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Change Status",
                        style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      )),
                ),
                const SizedBox(
                  width: 50,
                ),
                DropdownButton(
                  hint:
                      const Text('Status Order'), // Not necessary for Option 1
                  value: _selectedLocation,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLocation = newValue.toString();
                    });
                  },
                  items: _locations.map((location) {
                    return DropdownMenuItem(
                      child: Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
              ],
            ),
            const Divider(
              thickness: 1.3,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
