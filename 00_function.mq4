//+------------------------------------------------------------------+
//|                                                           00.mq4 |
//|                                                            Hamza |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Hamza"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

input double max_spread = 7;

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
    string spread_msg = "";    

    // Get value of spread in points
    double current_spread = calculateSpread(Ask, Bid);
   

    if (current_spread > max_spread) {
      spread_msg = "ALERT: spread greater than max spread: ";
    }
    else {
      spread_msg = "The current spread (point) is: ";
    }
   
    // DoubleToStr(): Returns text string with the specified numerical value converted into a specified precision format.
    // https://docs.mql4.com/convert/doubletostr

    // NormalizedDouble(): Rounding floating point number to a specified accuracy.
    // https://docs.mql4.com/convert/normalizedouble
    
    // Comment(): This function outputs a comment defined by a user in the top left corner of a chart.
    // https://docs.mql4.com/common/comment

    
    Comment(spread_msg, DoubleToStr(NormalizeDouble(current_spread, 0)));
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

