//+------------------------------------------------------------------+
//|                                        util_close_all_trades.mq4 |
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
   closeAllTrades(ORDER_TYPE_BUY,113);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|Function used to close all trades                                 |
//+------------------------------------------------------------------+
void closeAllTrades(ENUM_ORDER_TYPE type, int magic)
  {
   for(int i = 0; i < OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {
         if(OrderSymbol() == Symbol()  && OrderType() == type && OrderMagicNumber() == magic)
           {
            if((type == OP_BUY || type == OP_SELL))
              {
               //Print("Just Before Close");
               if(!OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 5, clrGreen))
                 {
                  Print("Problem in closing order", GetLastError());
                 }
               else
                  Print("Order Closed");
              }
            if(type == OP_BUYSTOP || type == OP_SELLSTOP || (type == OP_BUYLIMIT) || (type == OP_SELLLIMIT))
              {
               if(!OrderDelete(OrderTicket(), clrBrown))
                 {
                  Print("Problem in closing Pending order ", GetLastError());
                 }
               Print("Pending Orders Closed");
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
