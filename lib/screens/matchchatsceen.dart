import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/components/commentstream.dart';
import 'package:gulfgoal/components/sendcomment.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/components/sendreply.dart';
import 'package:gulfgoal/config/colors.dart';

class Matchchatscreen extends StatefulWidget {
  @override
  _MatchchatscreenState createState() => _MatchchatscreenState();
}

class _MatchchatscreenState extends State<Matchchatscreen> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
          child: Column(
        children: [
          SizedBox(
            height: 13,
          ),
          Commentstream(id: "5fb6fd888de08c00171a11ba"),
          //       Row(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           CircleAvatar(
          //             backgroundColor: textcolor,
          //           ),
          //           SizedBox(
          //             width: 15,
          //           ),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Boldaccectcolor(
          //                 text: "John Doe",
          //                 size: 14,
          //               ),
          //               Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Container(
          //                     width: MediaQuery.of(context).size.width - 95,
          //                     child: Row(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         Container(
          //                           width: 216,
          //                           child: Contenttext(
          //                               data:
          //                                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy ",
          //                               size: 12),
          //                         ),
          //                         Icon(
          //                           FontAwesomeIcons.heart,
          //                           size: 14,
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                   Row(
          //                     children: [
          //                       Normaltext(
          //                         string: "2 m",
          //                         fontsize: 12,
          //                       ),
          //                       SizedBox(
          //                         width: 25,
          //                       ),
          //                       Normaltext(
          //                         string: "22 likes",
          //                         fontsize: 12,
          //                       ),
          //                       SizedBox(
          //                         width: 27,
          //                       ),
          //                       GestureDetector(
          //                         onTap: () {
          //                           showModalBottomSheet(
          //                             context: context,
          //                             builder: (context) => Sendreply(),
          //                             isScrollControlled: true,
          //                           );
          //                         },
          //                         child: Normaltext(
          //                           string: "Reply",
          //                           fontsize: 12,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //               // SizedBox(
          //               //   height: 13,
          //               // ),
          //               SizedBox(
          //                 height: 17,
          //               ),
          //               Sendreply(
          //                 padding: 0,
          //               ),
          //               Container(
          //                 decoration: BoxDecoration(
          //                     border: Border(
          //                         left:
          //                             BorderSide(color: accentcolor, width: 2))),
          //                 child: Row(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     SizedBox(
          //                       width: 13,
          //                     ),
          //                     CircleAvatar(
          //                       backgroundColor: textcolor,
          //                     ),
          //                     SizedBox(
          //                       width: 15,
          //                     ),
          //                     Column(
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Boldaccectcolor(
          //                           text: "John Doe",
          //                           size: 14,
          //                         ),
          //                         Container(
          //                           width: 200,
          //                           child: Contenttext(
          //                               data:
          //                                   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
          //                               size: 12),
          //                         ),
          //                         SizedBox(
          //                           height: 13,
          //                         ),
          //                       ],
          //                     )
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              start: 30,
              bottom: 20,
            ),
            child: Sendcomment(
              newsid: "5fb6fd888de08c00171a11ba",
              padding: 0,
            ),
          )
        ],
      ))
    ]);
  }
}
