package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.multi.dorae.admin.EmailSendService;
import com.multi.dorae.login.KakaoVO;

@Service
public class ContactService {

	@Autowired
	ContactDAO contactDAO;
	@Autowired
	EmailSendService emailSendService;

	public boolean create(ContactVO contactVO) {
		if (!isValid(contactVO)) {
			return false;
		}

		if (contactDAO.insert(contactVO) != 1) {
			System.out.println("1:1 문의 생성에 실패함");
			return false;
		}
		
		return true;
	}

	public boolean updateAnswer(ContactVO contactVO) {
		if (!isValid(contactVO)) {
			return false;
		}

		if (contactDAO.updateAnswer(contactVO) != 1) {
			System.out.println("1:1 문의 답변 등록에 실패함");
		}

		emailSendService.send(contactVO);
		
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

	public List<ContactVO> listWithPaging(PageVO pageVO) {
		return contactDAO.listWithPaging(pageVO);
	}
	
	public List<ContactVO> listByMemberIdWithPaging(PageVO pageVO, String member_id) {
		return contactDAO.listByMemberIdWithPaging(pageVO, member_id);
	}
	
	public List<ContactVO> list() {
		return contactDAO.list();
	}
	
	public int count() {
		return contactDAO.count();
	}
	
	private boolean isValid(ContactVO contactVO) {
		if (!StringUtils.hasText(contactVO.getTitle())) {
			System.out.println("1:1 문의 제목이 없음");
			return false;
		}
		if (!StringUtils.hasText(contactVO.getContent())) {
			System.out.println("1:1 문의 내용이 없음");
			return false;
		}
		if (!StringUtils.hasText(contactVO.getMember_id())) {
			System.out.println("1:1 문의 멤버가 없음");
			return false;
		}
		return true;
	}
}
