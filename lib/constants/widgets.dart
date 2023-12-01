import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';

import '../utils/utils.dart';

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
               Padding(padding: const EdgeInsets.only(right: 20),
               child:  Image.asset(AppConstants.logo,height: 80, width: 80,),
               ),
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
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: 130,
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: AppColors.theme
          ),
          child: Center(
            child: Text(text,
              style:  TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.white
              ),
            ),
          )
        ),
      ),
    );
  }

  static Widget customTextFormField(BuildContext context,String fieldName, bool isDropdown) {
  List<String> list = Utils.retrieveDropdownList(fieldName, isDropdown);
      return Padding(padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
  child: !isDropdown ?TextFormField(
    keyboardType: Utils.getTextInputTypeByField(fieldName),
    decoration: InputDecoration(
      hintText: fieldName,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.theme
      )
    ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.theme,
        ),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'This field is required.';
      }
      return null;
    },
  ):
   Align(
     alignment: Alignment.centerLeft,
     child:  DropdownButtonFormField(
       hint: Text(fieldName),
         items: list.map<DropdownMenuItem<String>>((String val){
           return DropdownMenuItem<String>
             (value: val, child: Text(val));
         }).toList(),
       onChanged: (String? value) {
        //
     },
     validator: (value){
       if (value == null || value.isEmpty) {
         return 'This field is required.';
       }
       return null;
     },
     ),

   )
    
    ,);}

  static Widget customMenuTiles(BuildContext context, String title,
          bool isEnabled, VoidCallback onTap, IconData ic) =>
      Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 220,
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
                                 fontSize: AppConstants.menuTitleFontSize,
                                 fontWeight: FontWeight.bold),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 20, right: 20),
                             child: Text(
                               AppConstants.dummyDescriptionShort,
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
      customMenuTiles(context, AppConstants.comingSoon, false, () {
        showSnackBar(context,AppConstants.comingSoon);
      },Icons.warning_amber);

  static Widget documentTiles(BuildContext context, String title, bool isEnabled) => Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            if(isEnabled) {
              Utils.redirectToForms(context,title);
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
                  Icon(Utils.documentTilesIcon(title),
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

  static Widget personalInfo(BuildContext context){
    return SafeArea(child:  Column(
      children: [
       const Padding(padding:  EdgeInsets.only(left: 20),child:  Align(
         alignment: Alignment.centerLeft,
         child: Text(
           AppConstants.personalInfo,
           style: TextStyle(
             fontSize: AppConstants.formTitle,
             fontWeight: FontWeight.bold
           ),
         ),
       ),),
     SizedBox(
       width:  MediaQuery.of(context).size.width,
       child:   Row(
       children: [
         Expanded(
           child:  CustomWidgets.customTextFormField(context,AppConstants.lName, false),),
         Expanded(
           child:  CustomWidgets.customTextFormField(context,AppConstants.fName, false),),
         Expanded(
           child:  CustomWidgets.customTextFormField(context,AppConstants.mName, false),)
       ],
     ),),

        SizedBox(
          width:  MediaQuery.of(context).size.width,
          child: Row(
            children: [
             Expanded(child:  CustomWidgets.customTextFormField(context,AppConstants.birthday,false),),
              SizedBox(
                width: 220,
                child:  CustomWidgets.customTextFormField(context,AppConstants.age,false),
              )
            ],
          ),
        ),
        CustomWidgets.customTextFormField(context,AppConstants.address,false),

      ],
    ));}

}
