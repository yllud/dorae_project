package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.dorae.admin.EmailSendService;
import com.multi.dorae.login.KakaoVO;

@Service
public class ContactService {

	@Autowired
	ContactDAO contactDAO;
	@Autowired
	EmailSendService emailSendService;

	public boolean create(ContactVO vo) {
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

	public boolean updateAnswer(ContactVO vo) {
		if (vo.getAnswer() == null || vo.getAnswer().trim().isEmpty()) {
			return false;
		}

		contactDAO.answerUpdate(vo);

		emailSendService.send(vo);
		
		return true;
	}

	public ContactVO one(long contact_id, KakaoVO kakaoVO) {
		ContactVO contactVO = contactDAO.one(contact_id);
		
		if (!contactVO.getMember_id().equals(kakaoVO.getEmail())) { // 1:1 문의글의 작성자가 현재 세션의 사용자와 다르면
			contactVO = null;
		}
		
		return contactVO;
	}
	
	public ContactVO one(long contact_id) {
		return contactDAO.one(contact_id);
	}

	public List<ContactVO> listByMemberId(String member_id) {
		return contactDAO.listByMemberId(member_id);
	}
	
	public List<ContactVO> list() {
		return contactDAO.list();
	}
	
	public List<ContactVO> listAll() {
		return contactDAO.listAll();
	}

	
}
