package com.setec.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.setec.entiry.Booked;
import com.setec.repo.BookedRepo;
import com.setec.service.MyTelegramBot;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
public class MyControllers {
	@Autowired
	private BookedRepo bookedRepo;
	
	//http://localhost:8080/home
	@GetMapping({"/","/home"})
	public String home(Model model) {
		model.addAttribute("booked", new Booked());
		return "index";
	}
	
	@GetMapping({"/about"})
	public String about() {
		return "about";
	}
	
	@GetMapping({"/service"})
	public String service() {
		return "service";
	}
	
	@GetMapping({"/menu"})
	public String menu() {
		return "menu";
	}
	
	@GetMapping({"/contact"})
	public String contact() {
		return "contact";
	}
	
	@GetMapping({"/reservation"})
	public String reservation(Model model) {
		model.addAttribute("booked", new Booked());
        return "reservation";
	}
	
	@GetMapping({"/testimonial"})
	public String testimonial() {
		return "testimonial";
	}
	
	@Autowired
    private MyTelegramBot bot;

	@PostMapping("/checkout")
	public String checkout(@ModelAttribute Booked booked, Model model) {

	    bookedRepo.save(booked);

	    String message = """
	            📘 *New Booking Received*
	            
	            👤 Name: %s
	            📞 Phone: %s
	            📍 Email: %s
	            📦 Date: %s
	            🕒 Time: %s
	            👤 Persio : %s
	            """.formatted(
	                booked.getName(),
	                booked.getPhoneNumber(),
	                booked.getEmail(),
	                booked.getDate(),
	                booked.getTime(),
	                booked.getPerson()
	            );

	    bot.message(message); // send formatted message

	    model.addAttribute("booked", booked);
	    return "checkout";
	}
}


	

