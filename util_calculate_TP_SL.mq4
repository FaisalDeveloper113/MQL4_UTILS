//+------------------------------------------------------------------+
//|                                         util_calculate_TP_SL.mq4 |
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

// Calculation of SL and TP with respect to quotes
// StopLoss as input points
   double StopLoss = 100;
   double TakeProfit  = 100;
   double Sellstoploss=NormalizeDouble(Bid+StopLoss*SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE), Digits);
   double Sellprofit=NormalizeDouble(Bid-TakeProfit*SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE), Digits);



   double Buystoploss=NormalizeDouble(Ask-StopLoss*SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE), Digits);
   double Buyprofit=NormalizeDouble(Ask+TakeProfit*SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE), Digits);
  }
//+------------------------------------------------------------------+
