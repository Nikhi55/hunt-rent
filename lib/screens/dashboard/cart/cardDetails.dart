import 'package:flutter/material.dart';
import 'package:hunt_and_rent/base/resizer/fetch_pixels.dart';
import 'package:hunt_and_rent/base/widget_utils.dart';
import 'package:hunt_and_rent/resources/resources.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'Debit/MasterCard';
  final TextEditingController cardnocontroller = TextEditingController();
  final TextEditingController expirydatecontroller = TextEditingController();
  final TextEditingController cvvcontroller = TextEditingController();
  final TextEditingController nameoncardcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: R.textStyle
              .mediumMetropolis()
              .copyWith(fontSize: FetchPixels.getPixelHeight(18)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Methods',
              style: R.textStyle.mediumMetropolis().copyWith(
                  fontSize: FetchPixels.getPixelHeight(18),
                  color: Colors.grey[500]),
            ),
            SizedBox(height: 10),
            buildPaymentMethodTile(
              context,
              'Debit/MasterCard',
              R.images.cardLogo,
              selectedPaymentMethod == 'Debit/MasterCard',
            ),
            SizedBox(height: 10),
            buildPaymentMethodTile(
              context,
              'Credit Card',
              R.images.credit,
              selectedPaymentMethod == 'Credit Card',
            ),
            SizedBox(height: 10),
            buildPaymentMethodTile(
              context,
              'Cash on Delivery',
              R.images.cash,
              selectedPaymentMethod == 'Cash on Delivery',
            ),
            // SizedBox(height: 10),
            // buildPaymentMethodTile(
            //   context,
            //   'Hunt&Rent Pay',
            //   R.images.cash,
            //   selectedPaymentMethod == 'Hunt&Rent Pay',
            // ),
            Spacer(),
            Text(
              'Total Amount: QR 545.00',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Implement your payment logic here
              },
              child: Text('Pay Now'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentMethodTile(
    BuildContext context,
    String title,
    String image,
    bool isSelected,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = title;
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? R.colors.theme : R.colors.fillColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    getAssetImage(image, scale: FetchPixels.getPixelHeight(4)),
                    SizedBox(width: 10),
                    Text(
                      title,
                      style: R.textStyle.semiBoldMetropolis().copyWith(
                            fontSize: FetchPixels.getPixelHeight(16),
                          ),
                    ),
                  ],
                ),
                Radio<String>(
                  value: title,
                  groupValue: selectedPaymentMethod,
                  activeColor: R.colors.theme,
                  onChanged: (String? value) {
                    setState(() {
                      selectedPaymentMethod = value!;
                    });
                  },
                ),
                // SizedBox(width: 10),
                // Container(
                //   width: 20,
                //   height: 20,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: isSelected ? R.colors.theme : Colors.transparent,
                //     border: Border.all(
                //       color: R.colors.theme,
                //     ),
                //   ),
                // ),
              ],
            ),
            if (isSelected &&
                (title == 'Debit/MasterCard' || title == 'Credit Card'))
              buildCardDetailsForm(),
          ],
        ),
      ),
    );
  }

  Widget buildCardDetailsForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            controller: cardnocontroller,
            cursorColor: R.colors.blackColor,
            textInputAction: TextInputAction.next,
            style: R.textStyle.regularMetropolis().copyWith(
                height: 1,
                fontSize: FetchPixels.getPixelHeight(16),
                color: R.colors.blackColor),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Card Number',
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: expirydatecontroller,
                  cursorColor: R.colors.blackColor,
                  textInputAction: TextInputAction.next,
                  style: R.textStyle.regularMetropolis().copyWith(
                      height: 1,
                      fontSize: FetchPixels.getPixelHeight(16),
                      color: R.colors.blackColor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Expiry Date',
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cvvcontroller,
                  cursorColor: R.colors.blackColor,
                  textInputAction: TextInputAction.next,
                  style: R.textStyle.regularMetropolis().copyWith(
                      height: 1,
                      fontSize: FetchPixels.getPixelHeight(16),
                      color: R.colors.blackColor),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'CVV',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          TextFormField(
            keyboardType: TextInputType.text,
            controller: nameoncardcontroller,
            cursorColor: R.colors.blackColor,
            textInputAction: TextInputAction.next,
            style: R.textStyle.regularMetropolis().copyWith(
                height: 1,
                fontSize: FetchPixels.getPixelHeight(16),
                color: R.colors.blackColor),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Name on Card',
            ),
          ),
          // SizedBox(height: 10),
          Row(
            children: [
              Checkbox(value: true, onChanged: (bool? value) {}),
              Text('Securely save card and details'),
            ],
          ),
        ],
      ),
    );
  }
}
