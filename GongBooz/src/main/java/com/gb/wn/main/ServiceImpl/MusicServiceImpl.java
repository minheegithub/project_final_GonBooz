package com.gb.wn.main.ServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gb.wn.main.DAO.MusicDAO;
import com.gb.wn.main.Service.MusicService;

@Service("MusicService")
public class MusicServiceImpl implements MusicService{
	
	@Autowired
	private MusicDAO MusicDAO;

	@Override
	public String findMusic(String selectedName) {
		
		return MusicDAO.findMusic(selectedName);
	}

}
