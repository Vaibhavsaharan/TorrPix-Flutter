// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:torrpix/constants.dart';
// import 'package:torrpix/providers/homePageProvider.dart';
// import 'package:torrpix/services/searchQuery.dart';
// import 'components/header_with_searchbox.dart';
// import 'package:provider/provider.dart';
//
// import 'components/movie_result_box.dart';
//
// class Home extends StatefulWidget {
//
//   @override
//   _HomeState createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   GlobalKey<ScaffoldState> _globalKey = GlobalKey();
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: buildAppBar(),
//       body: SingleChildScrollView(
//           child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               HeaderWithSearchBox(size: size, key: Key('1')),
//               SizedBox(height: CONST_DEFAULT_PADDING),
//               MovieResultBox()
//             ],
//           ),
//         )
//       );
//   }
//
//   AppBar buildAppBar() {
//     return AppBar(
//       backgroundColor: CONST_PRIMARY_COLOR,
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.menu),
//         onPressed: () {},
//       ),
//     );
//   }
// }
//
//
