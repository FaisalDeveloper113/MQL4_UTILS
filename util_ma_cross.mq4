//+------------------------------------------------------------------+
//|                                                util_ma_cross.mq4 |
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
   crossOverMA();
  }
//+------------------------------------------------------------------+
int crossOverMA()
  {
   double firstHighMA=0,firstLowMA=0,secondHighMA=0,secondLowMA=0;
   firstLowMA=NormalizeDouble(iMA(Symbol(),PERIOD_D1,14,0,MODE_EMA,PRICE_CLOSE,1),Digits);
   firstHighMA =NormalizeDouble(iMA(Symbol(),PERIOD_D1,25,0,MODE_EMA,PRICE_CLOSE,1),Digits);
   double thirdma=NormalizeDouble(iMA(Symbol(),PERIOD_D1,40,0,MODE_EMA,PRICE_CLOSE,1),Digits);
//Print("First High Ma :",firstHighMA," first Low Ma:",firstLowMA);
   if(firstLowMA!=firstHighMA)
     {
      secondHighMA=NormalizeDouble(iMA(Symbol(),PERIOD_D1,14,0,MODE_EMA,PRICE_CLOSE,2),Digits);
      secondLowMA=NormalizeDouble(iMA(Symbol(),PERIOD_D1,25,0,MODE_EMA,PRICE_CLOSE,2),Digits);
      if(secondLowMA==secondHighMA)
        {
         int i=3;
         while(secondLowMA==secondHighMA)
           {
            secondHighMA=NormalizeDouble(iMA(Symbol(),PERIOD_D1,14,0,MODE_EMA,PRICE_CLOSE,i),Digits);
            secondLowMA=NormalizeDouble(iMA(Symbol(),PERIOD_D1,25,0,MODE_EMA,PRICE_CLOSE,i),Digits);
            i++;
           }
        }
      //Print("second High Ma:",secondHighMA," second Low Ma:",secondLowMA);
      //Sell Trade
      if((firstHighMA>firstLowMA) && (secondHighMA<secondLowMA) && firstLowMA < thirdma && firstHighMA < thirdma)// && (liveTrade()<tradelimit))
        {
         //cross detected for sell
         return 1;
        }
      //Buy Trade
      else
         if((firstLowMA>firstHighMA) && (secondLowMA<secondHighMA) && firstLowMA > thirdma && firstHighMA > thirdma)
           {
            //cross detected for buy
            return 0;
           }
         else
           {
            return -1;
           }
     }
   return -1;
  }