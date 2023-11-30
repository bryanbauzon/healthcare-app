import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';
import 'package:holy_trinity_healthcare/constants/strings.dart';

class CustomWidgets {
  static Widget customAppBar(
          BuildContext context, String appName, String appDescription) =>
      Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          color: AppColors.theme,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset('images/logo.png',height: 150, width: 150,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appName,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white),
                    ),
                    Text(
                      appDescription,
                      style: TextStyle(
                          fontSize: 20,
                          color: AppColors.white),
                    ),
                  ],
                ),
            Expanded(child:  Align(
              alignment: Alignment.centerRight,
              child:  IconButton(onPressed: (){
                showSnackBar(context,'info here...');
              }, icon: Icon(Icons.info_outline, size: 50, color: AppColors.white,)),
            ))
              ],
            )
          )));

  static Widget customButton(
      BuildContext context, String text, VoidCallback onTap) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.theme),
          foregroundColor: MaterialStateProperty.all(AppColors.white)),
      onPressed: onTap,
      child: Text(text),
    );
  }

  static Widget customTextFormField(String fieldName) => TextFormField(
        decoration: InputDecoration(
          hintText: fieldName,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );

  static Widget customMenuTiles(BuildContext context, String title,
          bool isEnabled, VoidCallback onTap, IconData ic) =>
      Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: isEnabled ? AppColors.enabled : AppColors.disabled,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child:Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(50)
                        ),

                        height: 80,
                        width: 80,
                        child:  Icon(
                          ic,
                          color: isEnabled ? AppColors.enabled : AppColors.disabled,
                          size: 45,
                        ),
                      ),
                     SizedBox(
                       width: MediaQuery.of(context).size.width/2,
                       child:  Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Text(
                             title,
                             style: TextStyle(
                                 color: AppColors.white,
                                 fontSize: 30,
                                 fontWeight: FontWeight.bold),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20, right: 20),
                             child: Text(
                               StringConstants.dummyDescriptionShort,
                               textAlign: TextAlign.center,
                               style: TextStyle(
                                 color: AppColors.white,
                                 fontSize: 15,
                               ),
                             ),
                           )
                         ],),
                     )
                    ],
                  ),
                )
            ),
          ),
        ),
      );

  static Widget comingSoonMenuTiles(BuildContext context) =>
      customMenuTiles(context, StringConstants.comingSoon, false, () {
        showSnackBar(context,StringConstants.comingSoon);
      },Icons.warning_amber);

  static Widget dummyDocument(BuildContext context, String title, bool isEnabled) => Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            if(isEnabled) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$title in progress...')),
              );
            }
          },
          child: Container(
              height: 210,
              width: 420,
              decoration: BoxDecoration(
                color: isEnabled? AppColors.enabled: AppColors.disabled,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Icon(Icons.account_tree_outlined,
                 color: AppColors.white,
                    size: 40,
                 ),
                  Padding(padding: const EdgeInsets.only(left:20),child: Text(
                    title,
                    style: TextStyle(color: AppColors.white,
                        fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),)
                ]
              )),
        ),
      );

  static void showSnackBar(BuildContext context, String message) =>
  ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(content: Text(message)),
  );
}
