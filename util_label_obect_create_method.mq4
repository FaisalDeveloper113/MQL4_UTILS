//+------------------------------------------------------------------+
//|                               util_label_obect_create_method.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

   if(ObjectFind("Spread_Label")<0) // Checks if object is not already created
     {
      if(!ObjectCreate(0,"Spread_Label",OBJ_LABEL,0,0,0))
         Print("Object Failed to create : ", GetLastError()); // error if object failed to create

     }
   ObjectSetString(0,"Spread_Label",OBJPROP_FONT,"Arial");
   ObjectSetInteger(0,"Spread_Label",OBJPROP_COLOR,clrAliceBlue);
   ObjectSetInteger(0,"Spread_Label",OBJPROP_FONTSIZE,2);
   ObjectSetInteger(0,"Spread_Label",OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,"Spread_Label",OBJPROP_YDISTANCE,100);
   ObjectSetString(0,"Spread_Label",OBJPROP_TEXT,0," Spread : "+ DoubleToStr(MarketInfo(Symbol(), MODE_SPREAD),2));
  }
//+------------------------------------------------------------------+

// Prints the Spread on the trading window
