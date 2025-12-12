package com.setec.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.pengrad.telegrambot.TelegramBot;
import com.pengrad.telegrambot.request.SendMessage;
import com.pengrad.telegrambot.response.SendResponse;

import lombok.Data;

@Data
@Service
public class MyTelegramBot {

    @Value("${token}")
    private String token;

    @Value("${chat_id}")
    private long chat_id;

    private TelegramBot bot;
    
    public SendResponse message(String text) {
    	if(bot == null ) {
    		bot = new TelegramBot(token);
    	}
    	SendResponse send = bot.execute(new SendMessage(chat_id, text));
    	
   
    	return send;
    }
}
