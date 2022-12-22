//+------------------------------------------------------------------+
//|                                         util_dollar_trailing.mq4 |
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

  }
//+------------------------------------------------------------------+

input double dollars = 20;    // Start Trailing After X Dollar Profit
void Dollar_Trailing(int x) // 0->Buy 1->Sell
  {
   double Dif = 0;

   if(x==0)
      Dif = Calculate_Order_Profit(OP_BUY);

   if(x==1)
      Dif = Calculate_Order_Profit(OP_SELL);

   if(Dif >  dollars)
     {
      if(x==1)
         if(Stop_Point_Sell == 0)
            Stop_Point_Sell = (int)(Dif - dollars);

      if(x==0)
         if(Stop_Point_Buy == 0)
            Stop_Point_Buy = (int)(Dif - dollars);

      if((Dif - dollars) > Stop_Point_Sell && x == 1)
         Stop_Point_Sell = (int)(Dif - dollars);

      if((Dif - dollars) > Stop_Point_Buy && x == 0)
         Stop_Point_Buy = (int)(Dif - dollars);


     }



   if(x==1 && Stop_Point_Sell != 0)
      if((int)Dif <= (Stop_Point_Sell))
        {
         Print("Stop Point Sell: ", Stop_Point_Sell, "Profit : ", (int)Dif);
         closeAllTrades(OP_SELL);
        }
   if(x==0 && Stop_Point_Buy != 0)
      if((int)Dif <= (Stop_Point_Buy))
        {
         Print("Stop Point Buy: ", Stop_Point_Buy, "Profit : ", (int)Dif);
         closeAllTrades(OP_BUY);
        }


   if(orderCount(OP_SELL)==0)
      Stop_Point_Sell = 0;
   if(orderCount(OP_BUY)==0)
      Stop_Point_Buy = 0;
  }
//+------------------------------------------------------------------+
