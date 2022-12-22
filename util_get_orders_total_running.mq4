//+------------------------------------------------------------------+
//|                                util_get_orders_total_running.mq4 |
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
   Orders_Total(113);
  }
//+------------------------------------------------------------------+
int Orders_Total(int magic_number)
  {
   int orders_total = 0;
   for(int i = 0; i < OrdersTotal(); i++)
     {
      if(OrderSelect(i, SELECT_BY_POS))
        {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic_number)
           {
            if(OrderType() == OP_BUY || OrderType() == OP_SELL)
              {
               orders_total++;
              }
           }
        }
     }
   return orders_total;
  }