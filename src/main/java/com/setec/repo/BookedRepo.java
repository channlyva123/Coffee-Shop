package com.setec.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.setec.entiry.Booked;

public interface BookedRepo extends JpaRepository<Booked, Integer> {


}
