<%@ page import="com.chainsys.flatmanagement.model.PaymentReceipt"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Receipt</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .receipt-container {
            margin: 50px auto;
            width: 50%;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        .receipt-title {
            text-align: center;
            margin-bottom: 20px;
        }
        .receipt-details {
            margin-bottom: 10px;
        }
        .receipt-details label {
            font-weight: bold;
        }
    </style>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
</head>
<body>
    <div class="container receipt-container">
        <h2 class="receipt-title">Payment Receipt</h2>
        <%
            PaymentReceipt receipt = (PaymentReceipt) request.getAttribute("receipt");
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        %>
        <div class="receipt-details">
            <label>Receipt Number:</label> <span id="receiptNumber"><%= receipt.getReceiptNumber() %></span>
        </div>
        <div class="receipt-details">
            <label>Payment Date:</label> <span id="paymentDate"><%= receipt.getPaymentDate().format(formatter) %></span>
        </div>
        <div class="receipt-details">
            <label>Amount Paid:</label> Ruppes <span id="amountPaid"><%= receipt.getAmount() %></span>
        </div>
        <div class="text-center">
            <a href="payment.jsp" class="btn btn-primary">Back to Payment</a>
            <button onclick="downloadReceipt()" class="btn btn-success">Download Receipt</button>
        </div>
    </div>

    <script>
        function downloadReceipt() {
            const { jsPDF } = window.jspdf;

            // Create a new jsPDF instance
            const doc = new jsPDF();

            // Get receipt details
            const receiptNumber = document.getElementById('receiptNumber').innerText;
            const paymentDate = document.getElementById('paymentDate').innerText;
            const amountPaid = document.getElementById('amountPaid').innerText;
            
            // Define page content and layout
            doc.setFontSize(20);
            doc.text('Payment Receipt', 105, 30, { align: 'center' });

            doc.setFontSize(12);
            doc.text('Receipt Number:', 20, 50);
            doc.setFontSize(14);
            doc.text(receiptNumber, 60, 50);

            doc.setFontSize(12);
            doc.text('Payment Date:', 20, 60);
            doc.setFontSize(14);
            doc.text(paymentDate, 60, 60);

            doc.setFontSize(12);
            doc.text('Amount Paid:', 20, 70);
            doc.setFontSize(14);
            doc.text(amountPaid, 60, 70);

            // Adding a line separator
            doc.setLineWidth(0.5);
            doc.line(20, 75, 190, 75);

            // Additional styling and logo can be added here
            doc.setFontSize(12);
            doc.text('Thank you for your payment!', 105, 90, { align: 'center' });

            // Save the PDF
            doc.save('PaymentReceipt.pdf');
        }
    </script>
</body>
</html>
