package com.setec.service;

import org.springframework.stereotype.Service;

import com.setec.entiry.Booked;
import com.setec.repo.BookedRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BookedService {
	private final BookedRepo bookedRepo;
	
	public Booked save(Booked booked) {
		return bookedRepo.save(booked);
	}
	

}
