//+------------------------------------------------------------------+
//|                                                     NewsMain.mq4 |
//|                                        Copyright 2019, KannyTech |
//|                                        https://www.kannytech.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, KannyTech"
#property link      "https://www.kannytech.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
enum selectLine
  {
   LineOnNewsBar =0,
   LineOnNewsStop=1
  };
#import "newsFilter.ex4"
void initiateNews();
int returnNewsStatus(bool High_Impact_News=true
                     ,int High_Start_Time=60//Stop Trade before high News (min)
                     ,int High_Stop_Time=15 //Stop Trade after high News (min)

                     ,bool show_high_line=true//Show verticle Line when high news comes 
                     ,bool Medium_Impact_News=true
                     ,int Medium_Start_Time=60//Stop Trade before medium News (min)
                     ,int Medium_Stop_Time=15 //Stop Trade after medium News (min)

                     ,bool show_medium_line=true//Show verticle Line when medium news comes 
                     ,bool Low_Impact_News=true
                     ,int Low_Start_Time=60//Stop Trade before low News (min)
                     ,int Low_Stop_Time=15 //Stop Trade after low News (min)

                     ,bool show_low_line=true//Show verticle Line when low news comes
                     ,string symbol=""
                     ,string expert=""
                     ,int GMT_Broker_Time=2
                     ,selectLine sl=0
                     ,string extraSymbol=""
                     );
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
enum NewsCloseOrder
  {
   CloseAllRunningOrder=0,
   LetTheOrderRun=1,
  };
///==========================================================================================================================================///


///==========================================================================================================================================///
input string news="     News Settings";//News

input NewsCloseOrder newsClose=CloseAllRunningOrder;// On News Action on Running Orders

input bool High_Impact_News=true;//High Impact News
input int High_Start_Time=60;//Stop Trade before high News (min)
input int High_Stop_Time=15; //Stop Trade after high News (min)


input bool show_high_line=true;//Show verticle Line when high news comes 

input bool Medium_Impact_News=true;//Medium Impact News
input int Medium_Start_Time=60;//Stop Trade before medium News (min)
input int Medium_Stop_Time=15; //Stop Trade after medium News (min)

input bool show_medium_line=true;//Show verticle Line when medium news comes 

input bool Low_Impact_News=true;//Low Impact News
input int Low_Start_Time=60;//Stop Trade before low News (min)
input int Low_Stop_Time=15; //Stop Trade after low News (min)

input bool show_low_line=true;//Show verticle Line when low news comes 
input int GMT_Broker_Time=+2; //GMT_Broker_Time Time of your Broker 

input  selectLine Select_News_Line=0;

input bool mobileAlert=true; //Mobile Alert



//user defiend
input int MagicNumber=12345;//Magic Number
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string Lname="newsLabel3";;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
     {
      // Print("Inside the creater");
      ObjectCreate(0,Lname,OBJ_LABEL,0,0,0);
     }

//if(ObjectFind(0,Lname))
     {
      //  Print("Inside the updation");
      ObjectSetInteger(0,Lname,OBJPROP_XDISTANCE,0);
      ObjectSetInteger(0,Lname,OBJPROP_YDISTANCE,10);
      //--- set the chart's corner, relative to which point coordinates are defined 
      ObjectSetInteger(0,Lname,OBJPROP_CORNER,CORNER_LEFT_UPPER);
      ObjectSetString(0,Lname,OBJPROP_TEXT,"");
      //--- set text font 
      ObjectSetString(0,Lname,OBJPROP_FONT,"Arial");
      //--- set font size 
      ObjectSetInteger(0,Lname,OBJPROP_FONTSIZE,10);
     }

   initiateNews();
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
   static int status=-1,preStatus=-1;
   status=returnNewsStatus(High_Impact_News
                           ,High_Start_Time
                           ,High_Stop_Time

                           ,show_high_line
                           ,Medium_Impact_News
                           ,Medium_Start_Time
                           ,Medium_Stop_Time

                           ,show_medium_line
                           ,Low_Impact_News
                           ,Low_Start_Time
                           ,Low_Stop_Time

                           ,show_low_line
                           ,Symbol()
                           ,WindowExpertName()
                           ,GMT_Broker_Time
                           ,Select_News_Line
                           ,""
                           );
//Print("Name:"+WindowExpertName());
   if(status==0)
     {
      mainActivity();
     }
   if(status==1 || status==2 || status==3)
     {
      if(newsClose==0)
        {
         if(orderCount(OP_BUY,MagicNumber)>0)
            closeTrades(OP_BUY,MagicNumber);
         if(orderCount(OP_SELL,MagicNumber)>0)
            closeTrades(OP_SELL,MagicNumber);
        }
      else if(newsClose==1)
        {
         if((orderCount(OP_BUY,MagicNumber)>0) || (orderCount(OP_SELL,MagicNumber)>0))
           {
            mainActivity();
           }
        }

     }
   if(status!=preStatus)
     {
      if(status==0 && preStatus!=-1)
        {
         // if(ObjectFind(0,Lname))
           {

            // ObjectSetInteger(0,Lname,OBJPROP_COLOR,clrRed);
            ObjectSetString(0,Lname,OBJPROP_TEXT,"");
           }
         Alert("Trading is start");
         if(mobileAlert)
            SendNotification("Trading is start");

         preStatus=status;
        }
      else if(status==1)

        {
         //     if(ObjectFind(0,Lname))
           {
            ObjectSetInteger(0,Lname,OBJPROP_COLOR,clrRed);

            ObjectSetString(0,Lname,OBJPROP_TEXT,"High Impact News");
           }
         Alert("Trading Stop due to high impact news");
         if(mobileAlert)
            SendNotification("Trading Stop due to high impact news");

         preStatus=status;

        }
      else if(status==2)
        {
         //   Print("Inside status 2");
         //    if(ObjectFind(0,Lname))
           {

            //  Print("Inside the medium news");
            ObjectSetInteger(0,Lname,OBJPROP_COLOR,clrBlue);

            ObjectSetString(0,Lname,OBJPROP_TEXT,"Medium Impact News");
           }
         Alert("Trading Stop due to medium impact news");
         if(mobileAlert)
            SendNotification("Trading Stop due to medium impact news");

         preStatus=status;

        }
      else if(status==3)
        {
         //   if(ObjectFind(0,Lname))
           {
            ObjectSetInteger(0,Lname,OBJPROP_COLOR,clrGreen);

            ObjectSetString(0,Lname,OBJPROP_TEXT,"Low Impact News");
           }
         Alert("Trading Stop due to low impact news");

         if(mobileAlert)
            SendNotification("Trading Stop due to low impact news");

         preStatus=status;

        }
     }
//Before End news main
  }
//+------------------------------------------------------------------+
void mainActivity()
  {
  
  }
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
void closeTrades(int type,int magic)
  {
   for(int i=OrdersTotal()-1; i>=0; i--)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderSymbol()==Symbol() && OrderMagicNumber()==magic)
           {
            if(OrderType()==OP_BUY && type==OrderType())
              {
               if(!OrderClose(OrderTicket(),OrderLots(),Bid,5))
                 {Print("Problem in closing order buy"); }

              }
            if(OrderType()==OP_SELL && type==OrderType())
              {
               if(!OrderClose(OrderTicket(),OrderLots(),Ask,5))
                 {Print("Problem in closing order buy"); }
              }

           }

        }

     }
  }
//+------------------------------------------------------------------+
int orderCount(int type,int magic)
  {
   int count1=0;
   for(int i=0;i<OrdersTotal();i++)
     {
      if(OrderSelect(i,SELECT_BY_POS))
        {
         if(OrderMagicNumber()==magic && OrderSymbol()==Symbol())
           {
            if(OrderType()==type)
               count1++;
           }
        }
     }
   return count1;
  }