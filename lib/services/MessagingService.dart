import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class MessagingService {
  static String? fcmToken; // Variable to store the FCM token

  static final MessagingService _instance = MessagingService._internal();

  factory MessagingService() => _instance;

  MessagingService._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init(BuildContext context) async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
        'User granted notifications permission: ${settings
            .authorizationStatus}');

    // Retrieving the FCM token
    fcmToken = await _fcm.getToken();
    //log('fcmToken: $fcmToken');

    // Handling background messages using the specified handler
//    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listening for incoming messages while the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');

      if (message.notification != null) {
        if (message.notification!.title != null &&
            message.notification!.body != null) {
          final notificationData = message.data;
          //  final screen = notificationData['screen'];

          // NotificationApi notificationApi = NotificationApi(context: context);
          //
          // notificationApi.showNotification(
          //     title: message.data["title"]!,
          //     body: message.data["body"]!,
          //     id: Random.secure().nextInt(100),
          //     payload:  notificationData["user_id"] ?? "");
        }
      }
    });

    // Handling the initial message received when the app is launched from dead (killed state)
    // When the app is killed and a new notification arrives when user clicks on it
    // It gets the data to which screen to open
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        //  _handleNotificationClick(context, message);
      }
    });

    // Handling a notification click event when the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          'onMessageOpenedApp: ${message.notification!.title.toString()}');
      //_handleNotificationClick(context, message);
    });
  }

  // Handling a notification click event by navigating to the specified screen
//   Future<void> _handleNotificationClick(
//       BuildContext context, RemoteMessage message) async {
//     final notificationData = message.data;
//
//     if (notificationData.containsKey('screen')) {
//       final screen = notificationData['screen'];
//       if (screen == "chat") {
//         final senderUserId = notificationData['user_id'];
//
//         UserServices userServices = UserServices();
//
//         var chatProvider =
//             Provider.of<ChatServiceProvider>(context, listen: false);
//
//         //   var userProvider = Provider.of<UserProvider>(context,listen: false);
//
//         UserModal currentUser =
//             await userServices.getUserById(Globals.firebaseUser!.uid);
//
//         UserModal chatUser = await userServices.getUserById(senderUserId);
//
//         if (currentUser.isGuest) {
//           if (context.mounted) {
//             Globals.showCreateAccountDialog(context);
//           }
//           return;
//         }
//
//         ChatRoomModal? chatroomModel;
//         if (context.mounted) {
//           chatroomModel = await chatProvider.getChatroomModel(
//               currentUser, chatUser, context);
//         }
//
//         if (chatroomModel != null) {
//           if (context.mounted) {
//             Navigator.of(context, rootNavigator: true)
//                 .push(MaterialPageRoute(builder: (context) {
//               return ChatRoomPage(
//                 targetUser: chatUser,
//                 userModel: currentUser,
//                 firebaseUser: Globals.firebaseUser!,
//                 chatroom: chatroomModel!,
//               );
//             }));
//           }
//         }
//       }
//     }
//   }
// }

// Handler for background messages
  @pragma('vm:entry-point')
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    debugPrint('Handling a background message: ${message.notification!.title}');
  }
}
