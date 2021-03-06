package kr.pe.frame.adm.ntc.service;


import kr.pe.frame.cmm.core.model.AjaxModel;

/**
 * FAQ Service 추상 클래스
 * @author 성동훈
 * @since 2017-01-05
 * @version 1.0
 * @see FaqServiceImpl
 *
 * <pre>
 * == 개정이력(Modification Information) ==
 *
 * 수정일      수정자  수정내용
 * ----------- ------- ---------------------------
 * 2017.01.05  성동훈  최초 생성
 *
 * </pre>
 */
public interface FaqService {

	/**
	 * 첨부파일 ID 수정
	 * @param model
	 * @return
	 * @throws Exception
	 */
	AjaxModel updateCmmFileAttchId(AjaxModel model) throws Exception;

	/**
	 * FAQ 삭제
	 * @param model
	 * @return
	 */
	AjaxModel deleteCmmFaq(AjaxModel model);
}