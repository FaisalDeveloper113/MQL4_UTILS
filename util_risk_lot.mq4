//+------------------------------------------------------------------+
//|                                                util_risk_lot.mq4 |
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
double getLot(double stop_loss, double risk)
  {
   Print("Tick Value: ",MarketInfo(Symbol(),MODE_TICKVALUE));
   Print("Tick Size: ",MarketInfo(Symbol(),MODE_TICKSIZE)/Point);
   Print("Pip value: ",NormalizeDouble(((MarketInfo(Symbol(),MODE_TICKVALUE)/(MarketInfo(Symbol(),MODE_TICKSIZE)/Point))*10),2));
   double pipvalue = NormalizeDouble(((MarketInfo(Symbol(),MODE_TICKVALUE)/(MarketInfo(Symbol(),MODE_TICKSIZE)/Point))*10),2);
   pipvalue = pipvalue / 10;
   double lotSize = 0.1;
   double riskamount=(risk/100)*AccountBalance();
   double pipvalue_required=riskamount/stop_loss;
   lotSize = pipvalue_required/pipvalue;
//sl=riskamount/pipValuelot
   int roundDigit=0;
   double step=MarketInfo(Symbol(), MODE_LOTSTEP);

   while(step<1)
     {
      roundDigit++;
      step=step*10;
     }
   Print("Round Digits:",roundDigit);
   lotSize = NormalizeDouble(lotSize,roundDigit);


   if(lotSize<MarketInfo(Symbol(),MODE_MINLOT))
      lotSize=MarketInfo(Symbol(),MODE_MINLOT);
   else
      if(lotSize>MarketInfo(Symbol(),MODE_MAXLOT))
         lotSize=MarketInfo(Symbol(),MODE_MAXLOT);

//
   Print("Lot Size: ",lotSize);
   return lotSize;
  }
//+------------------------------------------------------------------+
