import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidgetParser extends WidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      ClickListener? listener) {
    InputDecoration? decoration=parseInputDecoration(map['decoration'],buildContext,listener);
    String? initialValue=map['initialValue'];
    TextEditingController controller=map['controller'] as TextEditingController;
    bool? obscureText=map['obscureText'];
    FocusNode focusNode=map['focusNode'] as FocusNode;
    String values=map['value'];
    return TextField(
       decoration: decoration,
       onChanged:(value){
          listener!.onClicked(value);
       },
       focusNode: focusNode,
       controller: controller,
       onEditingComplete: (){
         listener!.onClicked(values);
       },
       keyboardType: parseKeyboardType(map['keyboardType']),
       obscureText: obscureText!,
    );
  }

  @override
  String get widgetName => "TextFormField";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as TextField;
    Map<String, dynamic> json = {
      'decoration':widget.decoration,
      'onChanged':widget.onChanged,
      'onEditingCompleted':widget.onEditingComplete,
      'controller':realWidget.controller,
      'keyboardType':exportKeyboardType(realWidget.keyboardType),
      'obscureText':realWidget.obscureText,
    };
    return json;
  }

  @override
  Type get widgetType => Align;

  InputDecoration? parseInputDecoration(map, BuildContext buildContext, ClickListener? listener) {
     if (map == null) {
    return null;
  }
  return InputDecoration(
    border: map['border'],
    hintText: map['hintText'],
    errorText: map['errorText'],
    labelText: map['labelText'],
    prefix: DynamicWidgetBuilder.buildFromMap(map['prefix'], buildContext, listener),
    prefixIcon: DynamicWidgetBuilder.buildFromMap(map['prefixIcon'], buildContext, listener),
    suffixIcon:  DynamicWidgetBuilder.buildFromMap(map['suffixIcon'], buildContext, listener),
    suffix:  DynamicWidgetBuilder.buildFromMap(map['suffixIcon'], buildContext, listener)
    // borderRadius: map['borderRadius'],
    // color: map['color']
  );
  }

  parseKeyboardType(map) {
    TextInputType keyboardType=TextInputType.text;
    switch(map){
      case 'emailAddress':
         keyboardType=TextInputType.emailAddress;
         break;
      case 'dateTime':
         keyboardType=TextInputType.datetime;
         break;
      case 'number':
         keyboardType=TextInputType.number;  
         break;
      case 'multiline':
         keyboardType=TextInputType.multiline;   
         break;    
    }
  }

  exportKeyboardType(TextInputType keyboardType) {
    if(keyboardType==TextInputType.emailAddress){
      return 'emailAddress';
    }
    if(keyboardType==TextInputType.datetime){
      return 'dateTime';
    }
    if(keyboardType==TextInputType.number){
      return 'number';
    }
    if(keyboardType==TextInputType.multiline){
      return 'multiline';
    }
  }
}
