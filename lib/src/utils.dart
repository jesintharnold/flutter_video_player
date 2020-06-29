import 'package:flutter/material.dart';
class Aspect with ChangeNotifier{

  int tap_cnt=0;
  List list_tap_cnt=[
    "16/9",
     "1:1",
      "4:3",
    "16/10",
     "21/9",
     "64/27",
     "2.21/1",
     "2.39/1",
     "5/4"
   ];
  get tap_count{

     if(tap_cnt==0){
       return 16/9;
     }
     else if (tap_cnt==1){
       return 4/3;
     }
     else if(tap_cnt==2){
       return 1/1;
     }
     else if(tap_cnt==3){
       return 16/10;
     }
     else if(tap_cnt==4){
       return 21/9;
     }
     else if(tap_cnt==5){
       return 64/27;
     }
     else if(tap_cnt==6){
       return 2.21/1;
     }
     else if(tap_cnt==7){
       return 2.39/1;
     }
     else if(tap_cnt==8){
       return 5/4;
     }

     else{
       tap_cnt=0;
       return 16/9;
     }
     notifyListeners();
  }
  get tap_name{
    return list_tap_cnt[tap_cnt];
  }
   void addCnt(){
    print(tap_cnt);
    tap_cnt+=1;
    print(tap_cnt);
    notifyListeners();
  }

















}