package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.dorae.admin.EmailSendService;

@Service
public class ContactService {

	@Autowired
	ContactDAO contactDAO;
	@Autowired
	EmailSendService emailSendService;

	public boolean contactCreate(ContactVO vo) {
		if (vo.getMember_id() == null || vo.getMember_id().trim().isEmpty()) {
			return false;
		}
		if (vo.getTitle() == null || vo.getTitle().trim().isEmpty()) {
			return false;
		}
		if (vo.getContent() == null || vo.getContent().trim().isEmpty()) {
			return false;
		}

		contactDAO.insert(vo);
		return true;
	}

	public boolean answerUpdate(ContactVO vo) {
		if (vo.getAdmin_id() == null || vo.getAdmin_id().trim().isEmpty()) {
			return false;
		}
		if (vo.getAnswer() == null || vo.getAnswer().trim().isEmpty()) {
			return false;
		}

		contactDAO.answerUpdate(vo);

		emailSendService.send(vo);
		
		return true;
	}

	public ContactVO contactOne(long contact_id) {
		return contactDAO.selectOne(contact_id);
	}

	public List<ContactVO> contactList(String member_id) {
		return contactDAO.selectList(member_id);
	}

	
}
