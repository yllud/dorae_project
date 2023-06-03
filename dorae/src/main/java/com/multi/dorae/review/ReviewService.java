package com.multi.dorae.review;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.multi.dorae.search.PlayVO;

@Service
public class ReviewService {

	@Autowired
	ReviewDAO dao;
	@Autowired
	private ServletContext servletContext;

	// 파일 업로드
	public List<String> upload(ReviewVO vo, HttpServletRequest request, MultipartFile[] files) throws Exception {
		List<String> savedNames = new ArrayList<>();
		String uploadPath = request.getSession().getServletContext().getRealPath("resources/upload");

		if (files != null && files.length > 0) {
			for (MultipartFile file : files) {
				if (!file.isEmpty()) {
					String originalFilename = file.getOriginalFilename();
					String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
					String uuid = UUID.randomUUID().toString();

					String savedName = vo.getEmail() + "_" + uuid + extension;
					File target = new File(uploadPath + File.separator + savedName);
					file.transferTo(target);
					savedNames.add(savedName);
				}
			}
		}
		return savedNames;
	}

	// 후기 작성 - db 저장
	public void insert(ReviewVO vo) {
		dao.insert(vo);
	}

	// 전체 게시물 가져오기(페이징)
	public List<ReviewVO> getAll(ReviewPageVO vo) {
		vo.reviewStartEnd(vo.getPage());
		return dao.all(vo);
	}

	// 전체 후기 수 카운트
	public int getAllCount() {
		return dao.count();
	}

	// 전체 후기 페이지 수 계산
	public int getAllpages() {
		int count = dao.count();
		return count / 4 + (count % 4 == 0 ? 0 : 1);
	}

	// 태그 검색 결과 가져오기(페이징)
	public List<ReviewVO> getReviewsByTag(ReviewPageVO vo, String tag) {
		vo.reviewStartEnd(vo.getPage());
		return dao.tagSearch(vo, tag);
	}

	// 태그 검색 결과 수 카운트
	public int getTagCount(String tag) {
		return dao.tagCount(tag);
	}

	// 태그 검색 페이지 수 계산
	public int getTagPages(String tag) {
		int count = dao.tagCount(tag);
		return count / 4 + (count % 4 == 0 ? 0 : 1);
	}

	// 현재 페이지 설정 - 페이지 버튼 페이징 처리
	public int currentButtonPage(ReviewPageVO vo) {
		int currentPage = vo.getPage();
		int buttonsPerPage = 10;
		return (int) Math.ceil((double) currentPage / buttonsPerPage);
	}

	// id로 후기 검색 - 상세페이지 위한 데이터
	public ReviewVO getReviewById(int id) {
		return dao.one(id);
	}

	// 후기 수정(사진 제외)
	public void update(ReviewVO vo) {
		dao.update(vo);
	}

	// 삭제할 이미지 이름 가져오기
	public List<String> getDeletedImg(int id) {
		return dao.deletedImg(id);
	}

	// 사진명 수정
	public void updateImg(ReviewVO vo) {
		dao.imgUpdate(vo);
	}

	// 사진 삭제
	public void deleteImg(List<String> deletedImgList) {
		String uploadedPath = servletContext.getRealPath("/resources/upload");
		// 이미지가 있을 경우 삭제
		for (String deletedImg : deletedImgList) {
			// 삭제할 이미지가 없다면 continue
			if (deletedImg == null) {
				continue;
			}
			String filePathString = uploadedPath + "/" + deletedImg;
			Path filePath = Paths.get(filePathString);

			try {
				Files.delete(filePath);
				System.out.println("-----삭제한 파일: " + deletedImg);
			} catch (Exception e) {
				System.out.println("-----삭제 실패한 파일: " + deletedImg);
				e.printStackTrace();
			}
		}
	}

	// 후기 삭제
	public void delete(int id) {
		dao.delete(id);
	}

	// play db에서 공연명 전체 리스트 가져오기(페이징)
	public List<PlayVO> getPlayAll(ReviewPageVO vo) {
		vo.tagStartEnd(vo.getPage());
		return dao.playList(vo);
	}
	
	// play 전체 수 가져와서 페이지 수 계산
	public int getPlayAllPages() {
		int count = dao.playCount();
		return count / 10 + (count % 10 == 0 ? 0 : 1);
	}
	
	// 공연명으로 검색한 공연 가져오기(페이징)
	public List<PlayVO> getPlayByName(ReviewPageVO vo, String query) {
		vo.tagStartEnd(vo.getPage());
		return dao.playSearch(vo, query);
	}
	
	// 공연명으로 검색한 공연 수 가져와서 페이지 수 계산
	public int getPlayByNamePages(String query) {
		int count = dao.playSearchCount(query);
		return count / 10 + (count % 10 == 0 ? 0 : 1);
	}
	
	// 장르로 검색한 공연 가져오기(페이징)
	public List<PlayVO> getPlayByGenre(ReviewPageVO vo, String genre) {
		vo.tagStartEnd(vo.getPage());
		return dao.genreSearch(vo, genre);
	}
	
	// 공연명으로 검색한 공연 수 가져와서 페이지 수 계산
		public int getPlayByGenrePages(String genre) {
			int count = dao.genreCount(genre);
			return count / 10 + (count % 10 == 0 ? 0 : 1);
		}
}
