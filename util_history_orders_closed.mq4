//+------------------------------------------------------------------+
//|                                   util_history_orders_closed.mq4 |
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
void Check_Order_Closed(int Magic_Number)
  {
   int i,hstTotal=OrdersHistoryTotal();
   for(i=0; i<hstTotal; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }
      else
        {
         if(OrderMagicNumber() == Magic_Number && OrderSymbol() == Symbol())
           {
            if(OrderCloseTime() >= 0)
              {
               // Here you find orders that are closed and shown in history
              }
           }
        }
     }
  }