import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/models/citymodel/citymodel.dart';
import 'package:local_notification_flutter_project/ui/models/eparchymodel/eparchymodel.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';

final UiAddressIp getAddress2 = Get.put(UiAddressIp());
var urlEparchy = Uri.parse(getAddress2.Get_url('GetEparchy'));
final UiPhoneController getinfo = Get.put(UiPhoneController());

TextForm(TextEditingController control, String name) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: control,
      onSaved: (value) {
        getinfo.fname.value = value!.toPersianDigit();
      },
      style: const TextStyle(
          fontFamily: 'IransansDn', fontSize: 10, color: Colors.black45),
      obscureText: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        labelText: name,
        //
      ),
    ),
  );
}

Titr(String name) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Text(
      name,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
  );
}

OstanName(String name) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: DropdownSearch<EparchyModel>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: name,
          // hintText: "country in menu mode",
        ),
      ),
      // dropdownSearchDecoration: InputDecoration(labelText: "Name"),

      asyncItems: (String filter) async {
        var response = await httpClient.get(
          'GetEparchy',
          queryParameters: {"filter": filter},
        );
        // var response = await Dio().get(
        //   Uri.parse(getAddress2.Get_url('GetEparchy')).toString(),
        //   queryParameters: {"filter": filter},
        // );
        var models = EparchyModel.fromJsonList(response.data);
        return models;
      },
      onChanged: (EparchyModel? eparchy) {
        getinfo.ostan.value = eparchy!.EparchyTitle.toString();
        getinfo.ostanid.value = eparchy.EparchyId;
      },
    ),
  );
}

CityName(String name) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: DropdownSearch<CityModel>(
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: name,
          // hintText: "country in menu mode",
        ),
      ),
      // dropdownSearchDecoration: InputDecoration(labelText: "Name"),

      asyncItems: (String filter) async {
        var response = await httpClient.get(
          'GetEparchy',
          queryParameters: {"EparchyId": getinfo.ostanid.value.toString()},
        );
        // var response = await Dio().get(
        //   Uri.parse(getAddress2.Get_url('GetCity')).toString(),
        //   queryParameters: {"EparchyId": getinfo.ostanid.value.toString()},
        // );
        var models = CityModel.fromJsonList(response.data);
        return models;
      },

      onChanged: (CityModel? citymodel) {
        getinfo.city.value = citymodel!.CityName.toString();
        getinfo.cityid.value = citymodel.CityId;
      },
    ),
  );
}

TitrTop(String warning, String text, String request) {
  return Padding(
    padding: EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              warning,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              width: 5,
            ),
            Text(text),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(request),
      ],
    ),
  );
}

String? gender;
TextFieldTop(
    String name, String text, String val, Function press, String groupname) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.greenAccent),
        borderRadius: BorderRadius.circular(20),
      ), //BoxDecoration

      /** CheckboxListTile Widget **/
      child: RadioListTile(
        title: Text(name),
        subtitle: Text(
          text,
          style: TextStyle(
            fontSize: 10,
          ),
        ),
        value: val,
        groupValue: groupname,
        onChanged: (val) {
          press;
        },
      ),
    ), //Container
  );
}
