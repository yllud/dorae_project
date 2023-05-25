package com.multi.dorae.help;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.multi.dorae.admin.AdminVO;
import com.multi.dorae.admin.EmailSendService;

@Service
public class ContactService {

	@Autowired
	ContactDAO contactDAO;
	@Autowired
	EmailSendService emailSendService;

	public boolean create(ContactVO contactVO, String member_id) {
		if (contactVO.getTitle() == null || contactVO.getTitle().trim().isEmpty()) {
			System.out.println("1:1 문의 제목이 없음");
			return false;
		}
		if (contactVO.getContent() == null || contactVO.getContent().trim().isEmpty()) {
			System.out.println("1:1 문의 내용이 없음");
			return false;
		}

		contactVO.setMember_id(member_id);

		if (contactDAO.insert(contactVO) != 1) {
			System.out.println("1:1 문의 생성에 실패함");
			return false;
		}
		
		return true;
	}

	public boolean updateAnswer(ContactVO contactVO, AdminVO adminVO) {
		if (!StringUtils.hasText(adminVO.getId())) {
			System.out.println("관리자 아이디가 없음");
			return false;
		}
		
		contactVO.setAdmin_id(adminVO.getId());
		
		if (contactDAO.updateAnswer(contactVO) != 1) {
			System.out.println("1:1 문의 답변 등록에 실패함");
		}

		emailSendService.send(contactVO);
		
		return true;
	}

	public ContactVO one(long contact_id, String member_id) {
		ContactVO contactVO = contactDAO.one(contact_id);
		
		if (!contactVO.getMember_id().equals(member_id)) { // 1:1 문의글의 작성자가 현재 세션의 사용자와 다르면
			return null;
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
	
	public int count() {
		return contactDAO.count();
	}
}
