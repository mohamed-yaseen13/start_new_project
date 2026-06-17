import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import '../helper_function/helper_function.dart';

class NotificationLocalClass {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future notificationDet() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'test',
        'c_name',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
        playSound: true,
        channelShowBadge: true,
        channelDescription: 'c_des',
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future showNoti({
    int? id,
    required String title,
    required String body,
    required String payload,
  }) async {
    try {
      notificationsPlugin.show(
        id ?? DateTime.now().millisecond,
        title,
        body,
        await notificationDet(),
        payload: payload,
      );
      delay(2500).then((value) => notificationsPlugin.cancelAll());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future init({bool initScheduled = false}) async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        defaultPresentBadge: true,
        // onDidReceiveLocalNotification: (id,title,body,pay)async{
        //
        //   clickNoti(pay!);
        //
        // }
      ),
    );
    await notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (pay) async {
        clickNoti(pay.payload!);
      },
      onDidReceiveBackgroundNotificationResponse:
          localMessagingBackgroundHandler,
    );
  }
}

void clickNoti(String pay) async {
  // Map payload = jsonDecode(pay);
  // if (AuthProvider.isLogin()) {
  //   if (payload.containsKey('message_type_')) {
  //     TicketsProvider ticketsProvider =
  //         Provider.of(Constants.globalContext(), listen: false);
  //     if (payload['message_type_'] == "chat") {
  //       Map message = jsonDecode(payload['data_']);
  //       MessageProvider messageProvider =
  //           Provider.of(Constants.globalContext(), listen: false);
  //       bool check = messageProvider
  //           .checkMessageOfThisChat(convertStringToInt(message['chat_id']));
  //       if (!check) {
  //         int marketId = convertStringToInt(message['market_id']);
  //         int userId = convertStringToInt(message['user_id']);
  //         if (messageProvider.chatEntity == null) {
  //           messageProvider.goToMessagePage(userId: userId, marketId: marketId);
  //         } else {
  //           messageProvider.getMessages(userId: userId, marketId: marketId);
  //         }
  //       }
  //     } else if (payload['message_type_'] == "order") {
  //       int orderId = convertStringToInt(jsonDecode(payload['data_']));
  //       OrderDetailsProvider orderDetailsProvider =
  //           Provider.of(Constants.globalContext(), listen: false);
  //       if (orderDetailsProvider.ordersDetails != null &&
  //           orderDetailsProvider.ordersDetails!.id != orderId) {
  //         orderDetailsProvider.getOrderDetailsData(id: orderId);
  //       }
  //       if (orderDetailsProvider.ordersDetails == null) {
  //         orderDetailsProvider.getOrderDetailsData(id: orderId);
  //         orderDetailsProvider.goToSecOrderDetails();
  //       }
  //     } else if (payload['message_type_'] == "ticket") {
  //       Map message = jsonDecode(payload['data_']);
  //       TicketMessageProvider messageProvider =
  //           Provider.of(Constants.globalContext(), listen: false);
  //       if (ticketsProvider.tickets == null) {
  //         ticketsProvider.goToTicketsPage();
  //         messageProvider.getTicketDetails(id: message['ticket_id']);
  //       } else {
  //         messageProvider.getTicketDetails(id: message['ticket_id']);
  //       }
  //     } else if (payload['message_type_'] == "ticket_status") {
  //       int id = convertStringToInt(jsonDecode(payload['data_']));
  //       TicketMessageProvider messageProvider =
  //           Provider.of(Constants.globalContext(), listen: false);
  //       if (ticketsProvider.tickets == null) {
  //         ticketsProvider.goToTicketsPage();
  //         messageProvider.getTicketDetails(id: id);
  //       } else {
  //         messageProvider.getTicketDetails(id: id);
  //       }
  //     }
  //   }
  // }
}
