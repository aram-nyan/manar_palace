import 'package:alux/AppTheme.dart';
import 'package:alux/AppViewController.dart';
import 'package:alux/pages/CompanyInfoPage.dart';
import 'package:alux/pages/ContractPage.dart';
import 'package:alux/pages/FeedbackCall.dart';
import 'package:alux/pages/ForgotPass.dart';
import 'package:alux/pages/HistoryOrders.dart';
import 'package:alux/pages/LocationPage.dart';
import 'package:alux/pages/LoginPage.dart';
import 'package:alux/pages/PrivacyPage.dart';
import 'package:alux/pages/ProfileEdit.dart';
import 'package:alux/pages/ProfilePage.dart';
import 'package:alux/pages/RegisterPage.dart';
import 'package:alux/pages/SupportPage.dart';
import 'package:alux/services/AuthProvide.dart';
import 'package:alux/services/ListViewProvide.dart';
import 'package:alux/services/LoginProvide.dart';
import 'package:alux/services/NewsService.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black54,
    statusBarBrightness: Brightness.dark,
  ));
//  OneSignal.shared.init(
//      "767f73d7-b084-4e50-91ca-032227b6ba45",
//      iOSSettings: {
//        OSiOSSettings.autoPrompt: true,
//        OSiOSSettings.inAppLaunchUrl: false
//      }
//  );
//  OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LoginProvide(),
        ),
        ChangeNotifierProvider.value(
          value: AuthProvide(),
        ),
        ChangeNotifierProvider.value(
          value: NewsViewProvider(),
        ),
        ChangeNotifierProvider.value(
          value: ListViewProvider(),
        ),
      ],
      child: Builder(builder: (BuildContext context) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          routes: {
            ProfilePage.id: (context) => ProfilePage(),
            RegisterPage.id: (context) => RegisterPage(),
            LoginPage.id: (context) => LoginPage(),
            FeedbackCallPage.id: (context) => FeedbackCallPage(),
            SupportPage.id: (context) => SupportPage(),
            CompanyInfoPage.id: (context) => CompanyInfoPage(),
            ForgotPage.id: (context) => ForgotPage(),
            ProfileDataScreen.id: (context) => ProfileDataScreen(),
            HistoryOrder.id: (context) => HistoryOrder(),
            ContractPage.id: (context) => ContractPage(),
            PrivacyPage.id: (context) => PrivacyPage(),
            LocationPage.id: (context) => LocationPage(),
          },
          home: AppViewController(),
        );
      }),
    );
  }
}
