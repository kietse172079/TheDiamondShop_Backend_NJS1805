const express = require("express");
const router = express.Router();
const {
  createOrder,
  cancelOrder,
  checkOrderForCancellation,
  savePayment,
} = require("../../dao/orders/manageOrdersDAO");

// Route to create an order
router.post("/create-order", async (req, res) => {
  try {
    const orderData = req.body; // Assuming order data is sent in the request body
    const result = await createOrder(orderData);
    res.status(201).json(result); // Return success message and order details
  } catch (error) {
    console.error("Error creating order:", error.message);
    res.status(500).json({ error: "Error creating order" }); // Handle error
  }
});

// POST apply voucher to an order
router.post('/apply-voucher', async (req, res) => {
  const { orderID, voucherID, totalPrice } = req.body;

  try {
    // Check if totalPrice meets prerequisites
    const voucher = await getVoucherById(voucherID);
    if (!voucher) {
      return res.status(404).json({ error: 'Voucher not found' });
    }

    if (totalPrice < voucher.Prerequisites) {
      return res.status(400).json({ error: 'TotalPrice does not meet voucher prerequisites' });
    }

    // Calculate discounted price
    const discountedPrice = totalPrice * (1 - voucher.Discount / 100);

    // Update voucher usage
    await voucherDao.updateVoucherUsage(voucherID);

    // Save voucher in order
    await voucherDao.saveVoucherInOrder(orderID, voucherID);

    res.json({ discountedPrice });
  } catch (error) {
    console.error('Error applying voucher:', error);
    res.status(500).json({ error: 'Error applying voucher' });
  }
});

//====About Save Information of Transaction
// Route to process PayPal payment
router.post("/paypal-payment/:orderId", async (req, res) => {
  const orderId = req.params.orderId;

  try {
    // Assuming paymentAmount is sent in the request body, pass it to savePayment
    const { paymentAmount } = req.body;

    // Save payment details in Transactions table using TotalPrice from createOrder
    const result = await savePayment(orderId, paymentAmount, "PayPal");
    if (result) {
      res.status(200).json({ message: "Payment processed successfully." });
    } else {
      res.status(500).json({ error: "Failed to save payment details." });
    }
  } catch (error) {
    console.error("Error processing PayPal payment:", error);
    res
      .status(500)
      .json({ error: "An error occurred while processing the payment." });
  }
});

// Route to process Cash payment
router.post("/cash-payment/:orderId", async (req, res) => {
  const orderId = req.params.orderId;

  try {
    // Assuming paymentAmount is sent in the request body, pass it to savePayment
    const { paymentAmount } = req.body;

    // Save payment details in Transactions table using TotalPrice from createOrder
    const result = await savePayment(orderId, paymentAmount, "Cash");
    if (result) {
      res.status(200).json({ message: "Payment processed successfully." });
    } else {
      res.status(500).json({ error: "Failed to save payment details." });
    }
  } catch (error) {
    console.error("Error processing Cash payment:", error);
    res
      .status(500)
      .json({ error: "An error occurred while processing the payment." });
  }
});

// POST endpoint to create a new schedule appointment
router.post("/schedule-appointments", async (req, res) => {
  try {
    const appointmentData = req.body; // Assuming JSON body parser middleware is used
    const newAppointment =
      await scheduleAppointmentDAO.createScheduleAppointment(appointmentData);
    res.status(201).json(newAppointment);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// GET endpoint to fetch all schedule appointments
router.get("/schedule-appointments", async (req, res) => {
  try {
    const appointments =
      await scheduleAppointmentDAO.getAllScheduleAppointments();
    res.status(200).json(appointments);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});



module.exports = router;
