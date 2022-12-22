//+------------------------------------------------------------------+
//|                                 util_get_latest_order_closed.mq4 |
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
//+------------------------------------------------------------------+
bool LastOrder(int x, int Magic_Number) /// 0 -> Buy && 1--> Sell
  {
   if(x==0)
     {
      if(OrderSelect(OrdersHistoryTotal()-1, SELECT_BY_POS,MODE_HISTORY))
        {
         //Print("Order History Total : ", OrdersHistoryTotal());
         if(OrderMagicNumber() == Magic_Number && OrderSymbol() == Symbol())
           {
            if(OrderType() == OP_BUY)
              {
               return true;
              }
           }
        }
     }

   if(x==1)
     {
      if(OrderSelect(OrdersHistoryTotal()-1, SELECT_BY_POS,MODE_HISTORY))
        {
         //Print("Order History Total : ", OrdersHistoryTotal());
         if(OrderMagicNumber() == Magic_Number && OrderSymbol() == Symbol())
           {
            if(OrderType() == OP_SELL)
              {
               return true;
              }
           }
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
