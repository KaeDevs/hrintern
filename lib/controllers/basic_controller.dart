
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends GetxController{
    var tip_no = 1.obs;
    var max_pages = 3.obs;

    void increaseTipNo() {
    if (tip_no.value < max_pages.value) {
      tip_no.value += 1;
    }
  }

  void decreaseTipNo() {
    if (tip_no.value > 1) {
      tip_no.value -= 1;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tip_no.value =1 ;
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tip_no.value =1 ;

  }

}