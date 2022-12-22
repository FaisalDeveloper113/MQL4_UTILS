//+------------------------------------------------------------------+
//|                                              util_open_trade.mq4 |
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
bool Place_Order(int Magic,int Ordertype, double LotSize, double Stoploss, double Takeprofit)
  {
   if(Ordertype == OP_SELL)
     {
      int chk1 = OrderSend(Symbol(), OP_SELL, LotSize, Bid, 3, Stoploss, Takeprofit, "Sell Order", Magic, 0, clrRed);
      if(chk1 < 0)
        {
         Print("OrderSend failed with error #", GetLastError());
         return false;
        }
      else
        {
         Print("OrderSend placed successfully");
         return true;
        }
     }
   if(Ordertype == OP_BUY)
     {
      int chk1 = OrderSend(Symbol(), OP_BUY, LotSize, Ask, 3, Stoploss, Takeprofit, "Buy Order", Magic, 0, clrBlue);
      if(chk1 < 0)
        {
         Print("OrderSend failed with error #", GetLastError());
         return false;
        }
      else
        {
         Print("OrderSend placed successfully");
         return true;
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
