//+------------------------------------------------------------------+
//|                                           util_trailing_stop.mq4 |
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
input int ts = 100;
//+------------------------------------------------------------------+
void updateTS(int magic_no)
  {
   int openedpositions;
   double mySL,myResult;

   openedpositions=OrdersTotal();
   if((openedpositions>0))
     {
      int totalorders=OrdersTotal();
      for(int i=0; i<totalorders; i++) // scan all orders and positions. ..
        {
         if(OrderSelect(i,SELECT_BY_POS))
           {
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic_no) // only look if mygrid and symbol. ..
              {
               int type=OrderType();
               if(type==OP_BUY) // its a long position
                 {
                  mySL=Ask-ts*Point; // new SL

                  double startSl=OrderOpenPrice()+ts*Point;
                  //  Print("Check order Start Stoploss: "+startSl+" Now Ask:"+Ask);
                  if(mySL>OrderStopLoss() && Ask>=startSl)
                    {
                     // OK, we need to change the stoploss

                     //    Print("Modifying at expected:" +startSl+ "< Now Ask"+Ask);
                     myResult=OrderModify(OrderTicket(),OrderOpenPrice(),mySL,OrderTakeProfit(),0,clrGreen);
                    }
                 }
               if(type==OP_SELL)
                 {
                  mySL=Bid+ts*Point; // new SL
                  double startSlSell=OrderOpenPrice()-ts*Point;

                  //    Print("Check order Start Stoploss: "+startSlSell+" Now Bid:"+Bid);

                  if(((mySL<OrderStopLoss()) || (OrderStopLoss()<Point)) && Bid<=startSlSell)
                    {
                     // OK, we need to change the stoploss
                     // Print("Modifying at expected:" +startSlSell+ "> Now bid"+Bid);
                     myResult=OrderModify(OrderTicket(),OrderOpenPrice(),mySL,OrderTakeProfit(),0,clrRed);
                    }
                 }
              }
           }
        }
     }
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
