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
                'Available Water to Sell',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              _buildAvailableWater(context),
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

  Widget _buildAvailableWater(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.blue[900],
              child: Icon(Icons.water, color: Colors.white),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BuyPage()),
                    );
                  },
                  child: Text('Buy'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellPage()),
                    );
                  },
                  child: Text('Sell'),
                ),
              ],
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
              subtitle: Text('Bought on 13/07/2024'),
              trailing: Icon(Icons.history),
            ),
            ListTile(
              title: Text('200L - R90'),
              subtitle: Text('Sold on 14/07/2024'),
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

class BuyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Water'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildBuyerListTile(context, 'John Mbatha', '100L - R50', '4.5'),
          _buildBuyerListTile(context, 'Simon Ndlovu', '200L - R90', '4.7'),
          // Additional buyers...
        ],
      ),
    );
  }

  Widget _buildBuyerListTile(BuildContext context, String buyer, String details, String rating) {
    return ListTile(
      title: Text(buyer),
      subtitle: Text(details),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        _showSellerDetails(context, buyer, details, rating);
      },
    );
  }

  void _showSellerDetails(BuildContext context, String buyer, String details, String rating) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$buyer\'s Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Water: $details'),
              Text('Rating: $rating'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(passengerName: buyer)),
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
}

class SellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sell Water'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildBidderListTile(context, 'Alice Smith', 'R60 for 100L'),
          _buildBidderListTile(context, 'James Mokoena', 'R95 for 200L'),
          // Additional bidders...
        ],
      ),
    );
  }

  Widget _buildBidderListTile(BuildContext context, String bidder, String offer) {
    return ListTile(
      title: Text(bidder),
      subtitle: Text(offer),
      trailing: Icon(Icons.arrow_forward),
      onTap: () {
        _showBidDetails(context, bidder, offer);
      },
    );
  }

  void _showBidDetails(BuildContext context, String bidder, String offer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bid Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bidder: $bidder'),
              Text('Offer: $offer'),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Action to accept the bid or contact the bidder
                },
                child: Text('Accept Bid'),
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
}

