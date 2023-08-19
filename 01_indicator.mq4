//+------------------------------------------------------------------+
//|                                                           00.mq4 |
//|                                                            Hamza |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Hamza"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

input int Momentum_Period = 14;
input double Momentum_Threshould = 100;

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
void OnTick(){
    double current_momentum = iMomentum(_Symbol, _Period, Momentum_Period, PRICE_CLOSE, 1);
    double threshould = Momentum_Threshould;

    if (current_momentum > threshould) {
        Comment("Go LONG!!!");
    }
    else if (current_momentum < threshould){
        Comment("Go Short!!!");
    }

}
//+------------------------------------------------------------------+

double calculateSpread(double pAsk, double pBid){
   /* Calculate spread
   */
   double current_spread = pBid-pAsk;
   
   // divide by _Point variable, to give spread in points.
   double point_spread = current_spread/_Point;
   point_spread = NormalizeDouble(current_spread, 0);
   return point_spread;
}

