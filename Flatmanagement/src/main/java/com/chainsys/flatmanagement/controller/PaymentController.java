package com.chainsys.flatmanagement.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.chainsys.flatmanagement.dao.PaymentDao;
import com.chainsys.flatmanagement.model.PaymentReceipt;
import com.chainsys.flatmanagement.model.Tenant;
import com.chainsys.flatmanagement.model.User;

import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

    @Autowired
    private PaymentDao paymentDao;

    @GetMapping("/payment")
    public String paymentPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/index.jsp";
        }

        boolean hasPaid = paymentDao.checkUserPayment(user.getId());
        System.out.println(hasPaid);
        if (!hasPaid) {
            Tenant tenant = paymentDao.getSpecificTenant(user.getId());
            int rent = tenant.getEbBill() + tenant.getRentAmount();
            model.addAttribute("rent", rent);
        }
        List<PaymentReceipt> receipt = paymentDao.getAllReceipt(user.getId());
        model.addAttribute("payement", receipt);
        model.addAttribute("hasPaid", hasPaid);
        return "/payment.jsp";
    }

    @PostMapping("/submitPayment")
    public String submitPayment(HttpSession session, int amount, Model model) {
        User user = (User) session.getAttribute("user");
        if (user != null) {
            String receiptNumber = UUID.randomUUID().toString();
            paymentDao.savePayment(user.getId(), amount, receiptNumber);
            PaymentReceipt receipt = paymentDao.getReceipt(user.getId());
            System.out.println(receipt);
            model.addAttribute("receipt", receipt);
        }
        return "paymentReceipt.jsp";
    }
}

