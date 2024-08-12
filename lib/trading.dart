import 'package:flutter/material.dart';
import 'chat.dart';

class WaterTradingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Trading'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Market Listings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _buildMarketListing(context),
              SizedBox(height: 20.0),
              Text(
                'Pricing and Bidding',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _buildPricingAndBidding(),
              SizedBox(height: 20.0),
              Text(
                'Transaction Summary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _buildTransactionSummary(),
              SizedBox(height: 20.0),
              Text(
                'User Reviews and Ratings',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _buildUserReviews(),
              SizedBox(height: 20.0),
              Text(
                'Trade History',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _buildTradeHistory(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMarketListing(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Available Water Quantities for Sale', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            ListTile(
              title: Text('100L - R50'),
              subtitle: Text('Seller: John Mbatha | Rating: 4.5'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _showTradeDetails(context, '100L', 'R50', 'John Mbatha');
              },
            ),
            ListTile(
              title: Text('200L - R90'),
              subtitle: Text('Seller: Simon Ndlovu | Rating: 4.7'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _showTradeDetails(context, '200L', 'R90', 'Simon Ndlovu');
              },
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Filter/sort action
                  },
                  child: Text('Filter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Sort action
                  },
                  child: Text('Sort'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTradeDetails(BuildContext context, String quantity, String price, String seller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Trade Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quantity: $quantity'),
              Text('Price: $price'),
              Text('Seller: $seller'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(passengerName: seller)),
                  );
                },
                child: Text('Contact Seller'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPricingAndBidding() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Market Prices', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            Text('100L - R50'),
            Text('200L - R90'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Place bid action
              },
              child: Text('Place a Bid'),
            ),
            ElevatedButton(
              onPressed: () {
                // Set asking price action
              },
              child: Text('Set Asking Price'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionSummary() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transaction Summary', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            Text('Quantity: 100L'),
            Text('Price: R50'),
            Text('Total Cost: R50 + Fees'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Confirm transaction action
              },
              child: Text('Confirm Transaction'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserReviews() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Reviews', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            ListTile(
              title: Text('John Mbatha'),
              subtitle: Text('Great seller, smooth transaction.'),
              trailing: Icon(Icons.star, color: Colors.yellow),
            ),
            ListTile(
              title: Text('Simon Ndlovu'),
              subtitle: Text('Quick response, good prices.'),
              trailing: Icon(Icons.star, color: Colors.yellow),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Leave feedback action
              },
              child: Text('Leave Feedback'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTradeHistory() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trade History', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10.0),
            ListTile(
              title: Text('100L - R50'),
              subtitle: Text('Date: 13/07/2024'),
              trailing: Icon(Icons.history),
            ),
            ListTile(
              title: Text('200L - R90'),
              subtitle: Text('Date: 14/07/2024'),
              trailing: Icon(Icons.history),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Filter history action
              },
              child: Text('Filter by Date'),
            ),
          ],
        ),
      ),
    );
  }
}
