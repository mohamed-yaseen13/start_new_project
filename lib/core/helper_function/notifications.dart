import 'package:firebase_messaging/firebase_messaging.dart';

Future notificationsFirebase() async {
  FirebaseMessaging.onMessage.listen((event) async {
    if (event.notification != null) {
      appNotifications(
        event.notification!,
        payload: event.data,
        fromWhereClicked: 1,
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) async {
    if (event.notification != null) {
      appNotifications(
        event.notification!,
        click: true,
        fromWhereClicked: 2,
        payload: event.data,
      );
    }
  });
  NotificationSettings settings = await FirebaseMessaging.instance
      .requestPermission(
        sound: true,
        badge: false,
        alert: true,
        criticalAlert: true,
        provisional: true,
      );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  } else {}
}

void appNotifications(
  RemoteNotification data2, {
  bool click = false,
  bool start = false,
  Map? payload,
  required int fromWhereClicked,
}) async {
  // bool showNotificationLocal = true;

  // if (payload!.containsKey('message_type_')) {
  //   print('start_noti1');
  //   if (payload['message_type_'] == "chat") {
  //     print('start_noti2');
  //     try{
  //       Map message = jsonDecode(payload['data_']);
  //       print(message);
  //       MessageModel messageModel = MessageModel.fromJson(message);
  //       MessageProvider messageProvider = Provider.of(Constants.globalContext(), listen: false);
  //       bool check = messageProvider.checkMessageOfThisChat(convertStringToInt(message['chat_id']));
  //       print('start_not3');
  //       if(check){
  //         // messageProvider.addOneMessage(messageModel);
  //         showNotificationLocal = false;
  //       }
  //       // if (!check) {
  //       //   if (messageProvider.chatEntity == null) {
  //       //     messageProvider.goToMessagePage();
  //       //   } else {
  //       //     messageProvider.getMessages();
  //       //   }
  //       // }
  //     }catch(e){
  //       print(e);
  //     }
  //     print('start_not4');
  //   } else if (payload['message_type_'] == "order") {
  //     print('start_noti5');
  //     int orderId = convertStringToInt(jsonDecode(payload['data_']));
  //     OrderDetailsProvider orderDetailsProvider = Provider.of(Constants.globalContext(), listen: false);
  //     if (orderDetailsProvider.ordersDetails != null && orderDetailsProvider.ordersDetails!.id != orderId) {
  //       orderDetailsProvider.getOrderDetailsData(id: orderId);
  //     }
  //     if (orderDetailsProvider.ordersDetails == null) {
  //       orderDetailsProvider.getOrderDetailsData(id: orderId);
  //       orderDetailsProvider.goToSecOrderDetails();
  //     }
  //     print('start_noti6');
  //   }else if(payload['message_type_']=="ticket"){
  //     Map message = jsonDecode(payload['data_']);
  //     TicketMessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
  //     bool check = messageProvider.checkMessageOfThisChat(convertStringToInt(message['ticket_id']));
  //     if(check){
  //       showNotificationLocal = false;
  //     }
  //   }else if(payload['message_type_']=="ticket_status"){
  //     int id = convertStringToInt(jsonDecode(payload['data_']));
  //     TicketMessageProvider messageProvider = Provider.of(Constants.globalContext(),listen: false);
  //     await messageProvider.getTicketDetails(id:id ,fromNoti: true);
  //   }
  // }

  // if(click&&AuthProvider.isLogin()&&fromWhereClicked==2){
  //   clickNoti(jsonEncode(payload));
  //   NotificationLocalClass.notificationsPlugin.cancelAll();
  // }
  // if(showNotificationLocal&&AuthProvider.isLogin()&&!click){
  //   NotificationLocalClass.showNoti(title: data2.title??"", body: data2.body??"", payload: jsonEncode(payload));
  // }
}
