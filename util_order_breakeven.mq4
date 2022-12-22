//+------------------------------------------------------------------+
//|                                         util_order_breakeven.mq4 |
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
   breakEven(113);
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|             // do initialize magic number before using                                                     |
//+------------------------------------------------------------------+
void breakEven(int magic)
    {
     int openedpositions;
     double myResult;

     openedpositions = OrdersTotal();
     if((openedpositions > 0))
         {
          int totalorders = OrdersTotal();
          for(int i = 0; i < totalorders; i++) // scan all orders and positions. ..
              {
               if(OrderSelect(i, SELECT_BY_POS))
                   {
                    if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic) // only look if mygrid and symbol. ..
                        {
                         int type = OrderType();
                         if(type == OP_BUY) // its a long position
                             {
                              if(OrderStopLoss() != OrderOpenPrice())
                                  {
                                   myResult = OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice(), OrderTakeProfit(), 0, clrGreen);
                                  }
                             }
                         if(type == OP_SELL)
                             {
                              if(OrderStopLoss() != OrderOpenPrice())
                                  {
                                   myResult = OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice(), OrderTakeProfit(), 0, clrRed);
                                  }
                             }
                        }
                   }
              }
         }
    }