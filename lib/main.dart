import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Data/repositories/randomeventrepo.dart';
import 'Data/webservices/requestRandomEvent.dart';
import 'Presentation/screens/homeScreen.dart';
import 'business_logic/randomevent/randomevent_cubit.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => RandomeventCubit(
                RandomEventRepository(requestService: RequestService()),
              ),
        child: HomeScreen(),
      ),
    );
  }
}
