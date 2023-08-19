//+------------------------------------------------------------------+
//|                                                           00.mq4 |
//|                                                            Hamza |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

// 1. OrderSend function to open orders on hte indicatores signals
// 2. REtain the order ticket number
// 3. Close the on the reverse of signal  https://docs.mql4.com/trading/orderclose 


#property copyright "Hamza"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

input int Momentum_Period = 14;
input double Momentum_Threshould = 100;

// Global variable
int gBuyTicket = 0;
int gSellTicket = 0;

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
void OnTick() {
    double current_momentum = iMomentum(_Symbol, _Period, Momentum_Period, PRICE_CLOSE, 1);
    double threshould = Momentum_Threshould;

    // Current momentum is above thresholud , open a buy order, close any sells.
    if (current_momentum > threshould) {
        Comment("Go LONG!!!");

       // Send Buy order
        gBuyTicket = OrderSend(_Symbol,
                OP_BUY, // Buy Market
                0.01,   // Lot size
                Ask,    // Price at
                100,    // Slippage
                0,      // Stoploss
                0,      // Take Profit
                "Buy Market", // Comment
                30012021     // magic number, May be used as user defined identifier.
            );

        // Close sell order if exist 
        if (gSellTicket > 0) {
            OrderClose(gSellTicket,  // Ticket of sell order
                0.01,   // Lot size
                Ask,    // Price at
                100     // Slippage
            );
        }
    }

    // Current momentum is below thresholud , open a sell order, close any buys.
    else if (current_momentum < threshould){
        Comment("Go Short!!!");

        // Send Sell order
        gSellTicket = OrderSend(_Symbol,
                OP_SELL, // Sell Market
                0.01,   // Lot size
                Bid,    // Price at
                100,    // Slippage
                0,      // Stoploss
                0,      // Take Profit
                "Sell Market", // Comment
                30012021     // magic number, May be used as user defined identifier.
            );

        // Close buy order if exist
        if (gBuyTicket > 0) {
            OrderClose(gBuyTicket,  // Ticket of buy order
                0.01,   // Lot size
                Bid,    // Price at
                100     // Slippage
            );
        }
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

