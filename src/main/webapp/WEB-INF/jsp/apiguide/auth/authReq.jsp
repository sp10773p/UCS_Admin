<%--
    Class Name : authReq.jsp
    Description : Key 발급 신청하기
    Modification Information
    수정일 수정자 수정내용
    ----------- -------- ---------------------------
    2017-03-31  정안균   최초 생성

    author : 정안균
    since : 2017-03-31
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kr.pe.frame.cmm.core.base.Constant" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<html>
<head>
	<link rel="stylesheet" href="<c:url value='/css/base.css'/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/common.css'/>"/>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/main/sub.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/nicescroll.css'/>" />
	
	<script src="<c:url value='/js/jquery.min.js'/>"></script>
	<script src="<c:url value='/js/jquery.form.js'/>"></script>
	<script src="<c:url value='/js/jquery-ui.js'/>" charset="utf-8"></script>
	<script src="<c:url value='/js/jquery.nicescroll.js'/>"></script>
	<script src="<c:url value='/js/dtree.js'/>" charset="utf-8"></script>
	<script src="<c:url value='/js/view.js'/>" charset="utf-8"></script>
	<script src="<c:url value='/js/common.js'/>" charset="utf-8"></script>
	<c:set var="session" value='<%= request.getSession(false).getAttribute(Constant.SESSION_KEY_USR.getCode())%>'/>
	<c:set var="userDiv" value="${session.getUserDiv()}" />
	<script>
	    $(function () {
	    	if("${userDiv}" == "M" || "${userDiv}" == "S") {
    			$.comm.send("/apiguide/selectCmmApiKeyMng.do", {},
	                function(data){
	                    if(data) {
	                    	var resultData = data.data;
	                    	if(!fn_apiCheck(resultData)) {
	                    		$.comm.forward("apiguide/auth/authView");
	                    	}
	                    }
			         }, "인증키 확인"
			     );	
	    	} else {
	    		alert("몰관리자로 로그인하셔야 합니다");
	    		parent.location.href = "<c:out value="/"/>";
	    	}
	    	
	    	//Key 발급 신청하기
            $('#btnIssue').on('click', function(event) {
            	var resultData = $.comm.sendSync("/apiguide/selectCmmApiKeyMng.do", {}, "인증키 확인").data;
    			if(resultData) {
    				if(!fn_apiCheck(resultData)) return false;
    			}
    			
            	if(!$("#agree").prop("checked")){
        			alert("해당 약관을 동의해주십시오.")
        			return false;
        		}
            	
            	if($("#use_url").val() == ""){
        			alert("사용 URL 을 입력해주세요");
        			return false;
        		}
            	
            	if($("#use_case").val() == ""){
        			alert("사용처를 입력해주세요");
        			return false;
        		}
            	
            	var fn_callback = function (data) {
                	if(data) {
                		if (data.code.indexOf('I') == 0) {
                			$.comm.forward("apiguide/auth/authView");	   
                        }
                 	}
                }

                $.comm.send("/apiguide/saveCmmApiKeyMng.do", {}, fn_callback, "Key 발급 신청");
    	    });
	    	
            //취소
            $('#btnCancel').on('click', function(event) {
            	$.comm.forward("apiguide/auth/authView");	
    	    });
	    	
	    });
	    
	    function fn_apiCheck(resultData) {
	    	if(resultData) {
	    		var apiKey = resultData["API_KEY"];
	        	if(apiKey && apiKey.length > 0) {
	        		alert('이미 발급한 인증키가 존재 합니다.');
	        		return false;	
	        	} else {
	        		var apiReqDt =  $.trim(resultData["API_REQ_DT"]).replace(/\/|-/g, '');
	        		if(apiReqDt) {
	        			alert('이미 발급 신청하셨습니다.');
	        			return false;		
	        		} 
	        	}
	    	}
        	return true;
	    }
	</script>
</head>
<body>
<div class="inner-box bg_sky">
	<div class="padding_box">
		<div class="bg_frame_content">
            <ul class="info_box box">
                <li><span>ㆍ</span>오픈 API(Open API)를 발급받으시려면, 약관 동의 후 아래 정보를 입력하시고 키발급 신청하기 버튼을 눌러주세요.</li>
            </ul>
            <div class="title_frame">
			    <p>API 약관 동의</p>
				<div class="policy_txt api">
					<p class="tit_article">제 1 장 총칙</p>
					<dl>
						<dt>제 1 조 (목적)</dt>
						<dd>본 약관은 한국무역정보통신(이하 "회사")이 인터넷사이트(www.goglobal.co.kr, 이하 당사이트라고만 함)를 통하여 제공하는 Open API 서비스 및 기타 이와 관련된 모든 서비스(이하 "API 서비스")의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.</dd>
					</dl>
					<dl>
						<dt>제 2 조 (약관의 효력과 변경)</dt>
						<dd>1. 본 약관은 API서비스의 이용을 위하여 “KTNET goGlobal”에 가입한 이용자가 본 약관에 동의를 함으로써 발생됩니다.</dd>
						<dd>2. API 서비스의 이용하기 위해서는 본 약관에 동의한 후 인증키 발급을 신청하여야 합니다.</dd>
						<dd>3. 회사는 이 약관을 서비스를 이용하고자 하는 자와 회원이 알 수 있도록 서비스가 제공되는 인터넷사이트 (http://www.goglobal.co.kr) 화면에 게시함으로써 공지합니다.</dd>
						<dd>4. 회사가 필요하다고 인정되는 경우 이 약관을 변경할 수 있으며, 변경된 약관은 적용일자 및 변경사유를 명시하여 적용일자 15일전부터 적용일자 전일까지 제3항의 방법으로 공지함으로써 이용자가 직접 확인하도록 할 것입니다. 이용자가 변경된 약관에 동의하지 아니하는 경우, 이용자는 이용계약을 해지(이용자 탈퇴)할 수 있으며, 계속 사용의 경우는 약관 변경에 대한 동의로 간주됩니다. 변경된 약관은 공지한 적용일자부터 그 효력이 발생됩니다.</dd>
					</dl>
					<dl>
						<dt>제 3 조 (약관의 해석 및 관련 법령과의 관계)</dt>
						<dd>1. 회사는 개별 서비스에 대해서는 별도의 이용약관 및 정책(이하 "별도약관 등")을 둘 수 있으며, 해당 내용이 본 약관과 상충할 경우에는 별도약관 등이 우선하여 적용됩니다.</dd>
						<dd>2. 본 약관에 명시되지 않은 사항이나 해석에 대해서는 전자무역촉진에관한법률, 대외무역법, 상법, 전기통신사업법, 전자서명법, 전자거래기본법 및 정보통신망이용촉진및정보보호등에관한법률 등 관련 법령의 규정 및 일반적인 상관례에 의합니다.</dd>
						<dd>3. 이용자는 회사가 제공하는 서비스를 이용함에 있어서 제2항의 관련 법령을 준수하여야 하며, 이 약관의 규정을 들어 관련법령 위반에 대한 면책을 주장할 수 없습니다.</dd>
					</dl>

					<dl>
						<dt>제 4 조 (용어의 정의)</dt>
						<dd>1. 본 약관에서 사용하는 용어의 정의는 다음과 같습니다.</dd>
						<dd>
							<ul>
								<li>1) Open API : Application Programming Interface의 약자로, 정보 소유자가 정보 이용자에게 정보를 제공하기 위하여 정의한 규약을 말합니다.</li>
								<li>2) API 서비스 : 전자상거래 수출신고를 자동 처리를 돕기 위하여 회사가 API를 제공하고 운영하는 것을 말합니다.</li>
								<li>3) API 서비스 페이지 : 회사가 API 서비스를 제공하고 있는 웹페이지“www.goglobal.co.kr”을말합니다. </li>
								<li>4) 인증Key : 관련 시스템이 API서비스 이용 승낙을 받은 이용자임을 식별할 수 있도록 회사가 이용자별로 할당하는 고유한 값을 말합니다.</li>
							</ul>
						</dd>
						<dd>2. 본 약관에서 사용하는 용어 중 제1항에 정하지 아니한 것은 “KTNET goGlobal 서비스”이용 약관 또는 관계 법령에서 정하는 바에 따르며, 그 외에는 일반 관례에 따릅니다.</dd>
					</dl>
					<p class="tit_article">제 2 장 API 서비스 제공 및 이용</p>
					<dl>
						<dt>제 5 조 (서비스의 제공)</dt>
						<dd>1. API 이용자는 API 서비스를 이용함에 있어 인증키 신청 화면을 통하여 신청 후 회사의 승인 거쳐 인증키를 발급받아야 하며, 발급받은 인증키를 이용하여 API 서비스를 이용할 수 있습니다.</dd>
						<dd>2. 인증키 발급 신청 시 API 이용자가 필수 입력해야하는 항목들은 성실히 입력되어야 합니다.</dd>
						<dd>3. 회사는 API 서비스 이용가능시간 또는 이용가능횟수를 지정 및 변경할 수 있으며, 이를 홈페이지를 통하여 사전에 고지하여야 합니다.</dd>
					</dl>
					<dl>
						<dt>제 6 조 (인증키 발급 및 주의사항)</dt>
						<dd>1. 발급된 인증키는 인증키를 발급 신청한 API 이용자 외에 제3자가 이용할 수 없으며, 제3자가 사용한 사실이 드러난 경우 회사는 해당 인증키의 사용을 중지할 수 있습니다.</dd>
						<dd>2. API 이용자는 1개의 인증키만을 발급받아 사용할 수 있으며, 어떠한 경우에도 2개 이상의 인증키를 발급받거나 그러한 시도를 하여서는 안됩니다.</dd>
						<dd>3. 회사는 이용자가 제 6조에서 정한 바에 따라 인증키 발급 신청을 완료한 경우 신청자의 발급 요청 사항을 확인하여 요청사항 및 기술적 여건, 관련 법규 등을 고려하여 발급 신청의 승인여부를 결정하며, 하자가 없는 경우 발급 신청에 대한 승인을 합니다.</dd>
						<dd>4. API 인증키 발급은 다음 각 호에 해당하는 발급요청에 대하여는 승인을 제한할 수 있습니다.</dd>
						<dd>
							<ul>
								<li>1) 다른 사람의 명의를 사용하여 신청하였을 때</li>
								<li>2) 발급 요청 내용을 허위로 기재하여 신청하였을 때</li>
								<li>3) 사회의 안녕 질서 혹은 미풍양속을 저해할 목적으로 신청하였을 때</li>
								<li>4) 다른 사람의 API 서비스 이용을 방해하거나 그 정보를 도용하는 등의 행위를 하였을 때</li>
								<li>5) 당 API 서비스를 이용하여 법령과 본 약관이 금지하는 행위를 하는 경우</li>
								<li>6) 기타 API 서비스가 정한 발급신청요건이 미비 되었을 때</li>
							</ul>
						</dd>
						<dd>5. 당 API 서비스는 다음 각 호에 해당하는 경우 그 사유가 해소될 때까지 발급 요청 승인을 유할 수 있습니다.</dd>
						<dd>
							<ul>
								<li>1) 서비스 관련 제반 용량이 부족한 경우</li>
								<li>2) 기술상 장애 사유가 있는 경우</li>
								<li>3) 이용신청자가 회사에 납부할 요금을 체납하고 있는 경우</li>
								<li>4) 기타 회사가 필요하다고 인정되는 경우</li>
							</ul>
						</dd>
						<dd>6. 발급요청 한 승인이 정상적으로 이루어지지 않은 이용자의 개인정보 및 신청정보는 개인정보 보호 등을 위하여 신청정보가 최초 전송된 날을 포함하여 60일이 경과한 후 삭제처리 됩니다.</dd>
					</dl>
					<dl>
						<dt>제 7 조 (계약사항의 변경)</dt>
						<dd>회원은 이용 신청 시 기재한 사항이 변경되었을 경우, 회사가 정한 별도의 이용방법으로 정해진 양식 및 방법에 의하여 수정하여야 합니다.</dd>
					</dl>
					<dl>
						<dt>제 8 조 (회원정보 사용에 대한 동의)</dt>
						<dd>1. 이용자가 본 약관에 따라 발급 신청 때, 회원정보를 수집, 이용하는 것에 대한 동의 여부를 결정할 수 있습니다. 단, 필수항목에 대한 수집, 이용 동의를 하지 않을 경우에는 서비스를 이용할 수 없습니다.</dd>
						<dd>2. 당 서비스의 이용자 정보는 다음 각 호와 같이 수집, 사용, 관리, 보호되며, “goGlobal”사이트의 개인정보처리방침이 적용됩니다.</dd>
						<dd>
							<ul>
								<li>1) 개인정보의 수집 : 당 사이트는 이용자의 서비스 가입 시 이용자가 제공하는 정보와 당 사이트 이용 시 자동으로 시스템에서 수집되는 이용정보를 통하여 이용자의 정보를 수집합니다.</li>
								<li>2) 개인정보의 사용 : 당 서비스에서 수집한 개인정보는 회원관리, 계약이행 및 요금관리, 서비스 안내 등 개인정보처리방침에서 고지한 범위 내에서 사용하며, 이용자의 사전 동의없이 고지한 범위를 초과하거나 제3자에게 제공하지 않습니다. 단, 법령의 규정에 의하거나 수사기관의 요구가 있는 경우, 급박한 생명, 신체, 재산의 이익을 위하여 필요하다고 인정된 경우, 통계작성 및 학술연구 등의 목적으로 특정 개인을 알아볼 수 없는 형태로 제공하는 경우에는 예외로 합니다.</li>
								<li>3) 개인정보의 관리 : 이용자는 개인정보의 보호 및 관리를 위하여 당 사이트의 개인정보관리 기능을 이용하여 수시로 개인정보를 수정하거나 삭제할 수 있습니다. 단, 서비스 제공을 위해서 반드시 필요한 필수항목은 삭제할 수 없습니다.</li>
								<li>4) 개인정보의 보호 : 이용자의 개인정보는 오직 이용자만이 열람, 수정, 삭제 할 수 있으며, 이는 전적으로 이용자의 아이디와 비밀번호에 의해 관리되고 있습니다.</li>
								<li>5) 개인정보 보유 및 파기 : 당 서비스는 개인정보의 수집 및 이용목적이 달성된 후에는 관계 법령에서 정한 기간 동안 보관해야 하는 경우를 제외하고는 해당 개인정보를 지체 없이 파기하며, 파기 절차 및 방법은 개인정보처리방침에서 별도로 고지합니다.</li>
							</ul>
						</dd>
					</dl>
					<p class="tit_article">제 3 장 서비스 이용</p>
					<dl>
						<dt>제 9 조 (서비스의 이용개시)</dt>
						<dd>1. 회사는 이용자의 이용신청을 승낙한 때부터 서비스를 개시합니다. 단, 일부 서비스의 경우에는 지정된 일자부터 서비스를 개시합니다.</dd>
						<dd>2. 회사의 업무상 또는 기술상의 장애로 인하여 서비스를 개시하지 못하는 경우에는 사이트에 공지하거나 이용자에게 이를 통지합니다.</dd>
					</dl>
					<dl>
						<dt>제 10 조 (서비스 이용시간)</dt>
						<dd>1. 서비스 이용시간은 당 사이트의 업무상 또는 기술상 특별한 지장이 없는 한 연중무휴, 1일 24시간을 원칙으로 합니다.</dd>
						<dd>2. 제1항의 이용시간은 정기점검 등의 필요로 인하여 당 사이트가 정한 날 또는 시간은 예외로 합니다.</dd>
					</dl>
					<dl>
						<dt>제 11 조 (서비스의 중지 및 휴면계정 처리)</dt>
						<dd>1. 다음 각 호에 해당하는 경우 서비스 제공을 중지 또는 일시 중지할 수 있습니다.</dd>
						<dd>
							<ul>
								<li>1) 전자무역 촉진에 관한 법률, 대외무역법, 상법, 관세법, 전기통신사업법 등 관계법령 및 본 약관의 규정을 위반한 경우나 서비스에 관한 당 사이트의 업무수행 또는 설비에 현저한 지장을 초래하거나 초래할 위험이 있는 행위를 한 경우</li>
								<li>2) 서비스용 설비의 보수 또는 공사로 인한 부득이한 경우</li>
								<li>3) 전기통신사업법에 규정된 기간통신사업자가 전기통신 서비스를 중지했을 경우</li>
								<li>4) 기타 당 서비스의 소정절차에 따라 서비스 중단 대상자로 선정된 경우</li>
							</ul>
						</dd>
						<dd>2. 당 서비스에 보관되거나 전송된 이용자의 메시지 및 기타 통신 메시지 등의 내용이 국가의 비상사태, 정전, 당 사이트의 관리 범위 외의 서비스 설비 장애 및 기타 불가항력에 의하여 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우, 기타 통신 데이터의 손실이 있을 경우에 당 서비스는 관련 책임을 부담하지 아니합니다.</dd>
						<dd>3. 당 서비스가 정상적인 서비스 제공의 어려움으로 인하여 일시적으로 서비스를 중지하여야 할 경우에는 서비스 중지 1주일 전에 홈페이지에 서비스 중지사유 및 일시를 공지한 후 서비스를 중지할 수 있으며, 이 기간 동안 이용자가 공지내용을 인지하지 못한 데 대하여 당 사이트는 책임을 부담하지 아니합니다. 부득이한 사정이 있을 경우 위 사전 공지기간은 감축되거나 생략될 수 있습니다. 또한 위 서비스 중지에 의하여 보관되거나 전송된 메시지 및 기타 통신 메시지 등의 내용이 보관되지 못하였거나 삭제된 경우, 전송되지 못한 경우 기타 통신 데이터의 손실이 있을 경우에 대하여도 당 사이트는 책임을 부담하지 아니합니다.</dd>
						<dd>4. 당 서비스의 사정으로 서비스를 영구적으로 중단하여야 할 경우에는 제3항에 의거합니다. 다만, 이 경우 사전 공지기간은 1개월로 합니다.</dd>
						<dd>5. 당 서비스는 사전 공지 후 서비스를 일시적으로 수정, 변경 및 중단할 수 있으며, 이에 대하여 이용자 또는 제3자에게 어떠한 책임도 부담하지 아니합니다.</dd>
						<dd>6. 당 서비스는 긴급한 시스템 점검, 증설 및 교체 등 부득이한 사유로 인하여 예고 없이 일시적으로 서비스를 중단할 수 있으며, 새로운 서비스로의 교체 등 당 서비스가 적절하다고 판단하는 사유에 의하여 현재 제공되는 서비스를 완전히 중단할 수 있습니다.</dd>
						<dd>7. 당 서비스는 국가비상사태, 정전, 서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 불가능할 경우, 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다. 다만, 이 경우 그 사유 및 기간 등을 이용자에게 사전 또는 사후에 공지합니다.</dd>
						<dd>8. 당 서비스는 통제할 수 없는 사유로 인한 서비스중단의 경우(시스템관리자의 고의나 과실이 없는 디스크장애, 시스템다운 등)에 사전통지가 불가능하므로 사후에 공지합니다.</dd>
						<dd>9. 당 서비스를 특정범위로 분할하여 각 범위 별로 이용가능시간을 별도로 지정할 수 있습니다. 다만, 이 경우 그 내용을 공지합니다.</dd>
						<dd>10. 당 서비스는 이용자가 본 약관의 내용에 위배되는 행동을 한 경우, 임의로 서비스 사용을 제한 및 중지하거나 이용자의 동의 없이 이용계약을 해지할 수 있습니다. 이 경우 당 사이트는 이용자의 접속을 금지할 수 있습니다.</dd>
						<dd>11. 이용자가 다음 각 호에 모두 해당 될 경우에는 이용자의 계정을 휴면 계정으로 전환하며, 휴면 계정으로 전환된 이용자의 성명·이메일·전화번호·휴대폰번호 등의 개인정보는 별도 DB에 암호화하여 분리저장하고 이용자의 요구가 있을 경우(로그인 시 포함) 사용가능 계정으로 복원합니다.</dd>
						<dd>
							<ul>
								<li>1) 1년간 당 서비스로 정보교환 이력이 없는 경우 (단, 이용자의 요청으로 미 이용 기간을 달리 정할 수 있음)</li>
								<li>2) 1년간 거래내역이 없는 경우</li>
								<li>3) 미수내역이 없는 경우</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 12 조 (이용계약의 해지)</dt>
						<dd>1. 이용자가 서비스 이용계약을 해지할 경우에는 해지를 원하는 날로부터 5일 전까지 "서비스해지 신청서"를 당 사이트에 제출하여야 합니다.</dd>
						<dd>2. 당 서비스는 다음 각 호에 해당하는 사유가 발생한 때에는 이용계약을 해지할 수 있으며 일정 기간 내에 재가입을 제한할 수 있습니다.</dd>
						<dd>
							<ul>
								<li>1) 이용요금을 정한 기일 내에 납부하지 아니한 경우</li>
								<li>2) 관계법령 및 약관을 위반하여 당 서비스의 운영에 업무기술상 막대한 지장을 초래한 경우</li>
								<li>3) 기타 부적당하다고 판단한 경우</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 13 조 (정보 제공 및 홍보물 게재)</dt>
						<dd>1. 당 서비스를 운영함에 있어서 각종 정보를 서비스에 게재하는 방법 등으로 이용자에게 제공할 수 있습니다.</dd>
						<dd>2. 당 서비스에 적절하다고 판단되거나 활용 가능성 있는 홍보물을 게재할 수 있습니다.</dd>
					</dl>
					<dl>
						<dt>제 14 조 (제출된 게시물의 저작권)</dt>
						<dd>1. 이용자가 게시한 게시물의 내용에 대한 권리는 이용자에게 있습니다.</dd>
						<dd>2. 당 서비스에 게시된 내용을 사전 통지 없이 편집, 이동 할 수 있는 권리를 보유하며, 다음의 경우 사전 통지 없이 삭제할 수 있습니다.</dd>
						<dd>
							<ul>
								<li>1) 본 서비스 약관에 위배되거나 상용 또는 불법, 음란, 저속하다고 판단되는 게시물을 게시한 경우</li>
								<li>2) 다른 이용자 또는 제 3자를 비방하거나 중상 모략으로 명예를 손상시키는 내용인 경우</li>
								<li>3) 공공질서 및 미풍양속에 위반되는 내용인 경우</li>
								<li>4) 범죄적 행위에 결부된다고 인정되는 내용인 경우</li>
								<li>5) 제3자의 저작권 등 기타 권리를 침해하는 내용인 경우</li>
								<li>6) 기타 관계 법령에 위배되는 내용인 경우</li>
							</ul>
						</dd>
						<dd>3. 이용자의 게시물이 타인의 저작권을 침해함으로써 발생하는 민, 형사상의 책임은 전적으로 이용자가 부담하여야 합니다.</dd>
					</dl>
					<dl>
						<dt>제 15 조 (이용자의 행동규범 및 서비스 이용제한)</dt>
						<dd>1. 이용자가 제공하는 정보의 내용이 허위인 것으로 판명되거나, 그러하다고 의심할 만한 합리적인 사유가 발생할 경우 당 사이트는 이용자의 본 서비스 사용을 일부 또는 전부 중지할 수 있으며, 이로 인해 발생하는 불이익에 대해 책임을 부담하지 아니합니다.</dd>
						<dd>2. 이용자가 당 사이트 서비스를 통하여 게시, 전송, 입수하였거나 전자메일 및 기타 다른 수단에 의하여 게시, 전송 또는 입수한 모든 형태의 정보에 대하여는 이용자가 모든 책임을 부담하며 당 서비스는 어떠한 책임도 부담하지 아니합니다.</dd>
						<dd>3. 당 서비스가 제공한 서비스가 아닌 가입자 또는 기타 유관기관이 제공하는 서비스의 내용상의 정확성, 완전성, 품질을 보장하지 않습니다. 따라서 당 사이트는 이용자가 위 내용을 이용함으로 인하여 입게 된 모든 종류의 손실이나 손해에 대하여 책임을 부담하지 아니합니다.</dd>
						<dd>4. 이용자는 본 서비스를 통하여 다음과 같은 행동을 하지 않는데 동의합니다.</dd>
						<dd>
							<ul>
								<li>• 1) 타인의 아이디, 비밀번호, 발급키를 도용하는 행위</li>
								<li>• 2) 저속, 음란, 모욕적, 위협적이거나 타인의 프라이버시를 침해할 수 있는 내용을 전송, 게시, 게재, 전자메일 또는 기타의 방법으로 전송하는 행위</li>
								<li>• 3) 서비스를 통하여 전송된 내용의 출처를 위장하는 행위</li>
								<li>• 4) 법률, 계약에 의하여 이용할 수 없는 내용을 게시, 게재, 전자메일 또는 기타의 방법으로 전송하는 행위</li>
								<li>• 5) 타인의 특허, 상표, 영업비밀, 저작권, 기타 지적재산권을 침해하는 내용을 게시, 게재, 전자메일 또는 기타의 방법으로 전송하는 행위</li>
								<li>• 6) 당 서비스의 승인을 받지 아니한 광고, 판촉물, 정크메일, 스팸, 행운의 편지, 피라미드 조직 등 기타 다른 형태의 권유를 게시, 게재, 전자메일 또는 기타의 방법으로 전송하는 행위</li>
								<li>• 7) 다른 이용자의 개인정보를 수집 또는 저장하는 행위</li>
							</ul>
						</dd>
						<dd>5. 당 서비스는 이용자가 본 약관을 위배했다고 판단되면 서비스와 관련된 모든 정보를 이용자의 동의 없이 삭제할 수 있습니다.</dd>
					</dl>
					<p class="tit_article">제 4 장 의무 및 책임</p>
					<dl>
						<dt>제 16 조 (당 서비스의 의무)</dt>
						<dd>1. 당 서비스는 법령과 본 약관이 금지하거나 미풍양속에 반하는 행위를 하지 않으며, 계속적, 안정적으로 서비스를 제공하기 위해 노력할 의무가 있습니다.</dd>
						<dd>2. 당 서비스는 이용자가 안전하게 당 사이트서비스를 이용할 수 있도록 이용자의 개인정보 (신용정보 포함) 보호를 위한 보안시스템을 갖추어야 합니다.</dd>
					</dl>
					<dl>
						<dt>제 17 조 (이용자의 의무)</dt>
						<dd>1. 이용자는 당 서비스의 사전 승낙 없이 서비스를 이용하여 어떠한 영리행위도 할 수 없습니다.</dd>
						<dd>2. 이용자는 당 서비스를 이용하여 얻은 정보를 당 사이트의 사전승낙 없이 복사, 복제, 변경, 번역, 출판·방송 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없습니다.</dd>
						<dd>3. 이용자는 당 서비스 이용과 관련하여 다음 각 호의 행위를 하여서는 안 됩니다.</dd>
						<dd>
							<ul>
								<li>1) 타인의 명예를 훼손하거나 모욕하는 행위</li>
								<li>2) 해킹행위 또는 컴퓨터바이러스의 유포행위</li>
								<li>3) 타인의 의사에 반하여 광고성 정보 등 일정한 내용을 지속적으로 전송하는 행위</li>
								<li>4) 서비스의 안정적인 운영에 지장을 주거나 줄 우려가 있는 일체의 행위</li>
								<li>5) 기타 전기통신 관련 법령에 위배되는 행위 (삭제하는 법률 조항에 명시된 내용 확인 필요)</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 18 조 (회원 ID, 비밀번호, 발급키 관리에 대한 의무와 책임)</dt>
						<dd>1. 회사는 사이트 내에서 일부 서비스 신청 시 이용요금을 부과할 수 있으므로, 이용자는 아이디, 비밀번호, 발급키)관리를 철저히 하여야 합니다.</dd>
						<dd>2. 이용자 아이디, 비밀번호, 관리키의 관리 소홀, 부정 사용에 의하여 발생하는 모든 결과에 대한 책임은 이용자 본인에게 있으며, 회사의 시스템 고장 등 회사의 책임있는 사유로 발생하는 문제에 대해서는 회사가 책임을 집니다.</dd>
						<dd>3. 이용자는 본인의 아이디, 비밀번호, 발급키를 제 3자에게 이용하게 해서는 안 되며, 이용자 본인의 아이디, 비밀번호, 발급키를 도난당하거나 제 3자가 사용하고 있음을 인지하는 경우에는 바로 회사에 통보하고 회사의 안내가 있는 경우 그에 따라야 합니다.</dd>
					</dl>
					<p class="tit_article">제 5 장 이용 요금</p>
					<dl>
						<dt>제 19 조 (요금의 종류)</dt>
						<dd>1. 당 서비스에서 제공하는 서비스 이용자는 회사가 정한 이용요금을 납부하여야 한다.</dd>
						<dd>2. 서비스 이용과 관련하여 사용자가 납입하여야 할 요금의 종류는 다음과 같습니다.</dd>
						<dd>
							<ul>
								<li>1) 포털 서비스 이용료 : 당 사이트 이용에 따른 기본 이용료로 매월 월정액을 부과합니다.</li>
								<li>2) 중계수수료 : 당 사이트를 통하여 전자문서 중계서비스를 이용한 경우에 한하여 전송료 및 전자문서변환료의 형태로 부과되며, 회사가 정한 별도의 단가를 적용하여 송신료는 송신자에게, 수신료는 수신자에게 부과함을 원칙으로 하며, 월 전송료가 일정금액 미만인 경우에는 최저사용료를 부과할 수 있습니다. 단, 이용자간 별도의 약정이 없는 경우라도 회사는 합리적인 이유가 있는 경우에는 무역유관기관의 요청에 따라 전송료를 발신인 또는 수신인 중 일방에게 부담시킬 수 있습니다.</li>
								<li>3) 기타 회사가 제공하는 유료서비스 이용료</li>
							</ul>
						</dd>
						<dd>3. HOST 접속, 기타 회사 업무에 밀접한 관련이 있는 정부기관이나 정보제공자에 대한 서비스이용요금 등은 별도의 계약에 의해 정할 수 있습니다.</dd>
						<dd>4. 이용요금은 ID별로 부과하며, 월 단위로 부과한다.</dd>
						<dd>5. 회사는 본 조의 이용요금에 대하여 다음 각 호의 사항을 서비스 이용초기화면이나 당 사이트의 화면에 게시하는 방법으로 이용자가 알기 쉽게 표시합니다.</dd>
						<dd>
							<ul>
								<li>1) 서비스의 내용, 이용방법, 요금부과시기, 이용료 기타 이용조건</li>
							</ul>
						</dd>
					</dl>
					<dl>
						<dt>제 20 조 (요금납입책임자)</dt>
						<dd>1. 요금납입책임자는 서비스 이용자를 원칙으로 합니다. 단, 회사가 인정하는 타인을 요금납입책임자로 지정할 수 있습니다.</dd>
						<dd>2. 제 1 항의 규정에 의한 요금납입책임자는 이용자가 회사에 대하여 부담하는 서비스 이용요금 등 약관에 따른 모든 채무를 회사에 납부할 책임이 있습니다.</dd>
					</dl>
					<dl>
						<dt>제 21 조 (요금 청구 및 납부)</dt>
						<dd>1. 회사는 서비스요금 청구서를 납입 기일로부터 7일 전 까지 요금납입책임자에게 도달하도록 발송해야 합니다. 단, 요금납입책임자가 자동이체, 신용카드 등 지로 이외의 방식으로 납부하는 경우에는 예외로 합니다.</dd>
						<dd>2. 요금납입책임자는 요금 청구서에 기재된 납입 기일까지 회사가 지정하는 방법으로 요금을 납부하여야 합니다.</dd>
						<dd>3. 요금납입책임자는 요금 청구서 등의 정확한 수령 및 문의 전화수신 등을 위해 주소 이전 또는 전화번호 변경 등 청구서 발송과 관련된 변경사항을 반드시 회사에 통보하여야 하며, 요금납입책임자의 통보 누락 등으로 인하여 발생한 불이익에 대해 회사는 책임지지 않습니다.</dd>
						<dd>4. 회사는 2개월 이상 요금이 연체된 이용자는 신용정보집중기관에 정보를 제공할 수 있습니다.</dd>
					</dl>
					<p class="tit_article">제 6 장 기타</p>
					<dl>
						<dt>제 22 조 (당 서비스의 소유권)</dt>
						<dd>1. 당 서비스가 제공하는 서비스, 그에 필요한 소프트웨어, 이미지, 마크, 로고, 디자인, 서비스 명칭, 정보 및 상표 등과 관련된 지적재산권 및 기타 권리는 회사에 소유권이 있습니다.</dd>
						<dd>2. 이용자는 당 서비스가 명시적으로 승인한 경우를 제외하고는 제1항의 각 재산에 대한 전부 또는 일부의 수정, 대여, 대출, 판매, 배포, 제작, 양도, 재 라이선스, 담보권 설정 행위, 상업적 이용행위를 할 수 없으며, 제3자로 하여금 이와 같은 행위를 하도록 허락할 수 없습니다.</dd>
					</dl>
					<dl>
						<dt>제 23조 (양도금지)</dt>
						<dd>이용자가 서비스의 이용권한, 기타 이용계약 상 지위를 타인에게 양도, 증여할 수 없으며, 이를 담보로 제공할 수 없습니다.</dd>
					</dl>
					<dl>
						<dt>제 24 조 (지위승계)</dt>
						<dd>1. 다음 각 호의 사유가 발생한 경우에는 이용자의 지위를 승계합니다.</dd>
						<dd>
							<ul>
								<li>1) 법인이 다른 법인을 흡수 합병하여 존속하는 법인이 그 지위를 승계한 경우</li>
								<li>2) 둘 이상의 법인이 하나의 법인으로 신설ㆍ합병하여 그 새로운 법인이 지위를 승계한 경우</li>
								<li>3) 타인의 영업을 양수하여 그 영업을 승계하는 경우</li>
							</ul>
						</dd>
						<dd>2. 제 1항의 규정에 의하여 이용자의 지위를 승계한 자는 승계일로부터 30일 이내에 이용자의 지위승계 사실을 증명하는 서류를 첨부하여 당 사이트에 제출하여야 합니다.</dd>
					</dl>
					<dl>
						<dt>제 25 조 (손해배상)</dt>
						<dd>1. 본 서비스는 이용자의 편의를 위하여 제공하는 서비스로, 본 서비스와 관련된 이용금액이 무료인 동안에는 본 서비스 이용과 관련하여 발생한 어떠한 손해에 대하여도 회사가 책임을 지지 않습니다.</dd>
						<dd>2. 이용자가 본 약관을 위반함으로 인하여 회사에 손해가 발생하게 되는 경우, 이 약관을 위반한 이용자는 회사에 발생하는 모든 손해를 배상하여야 합니다.</dd>
						<dd>3. 이용자가 서비스를 이용함에 있어 행한 불법행위나 본 약관 위반행위로 인하여 회사가 당해 이용자 이외의 제 3자로부터 손해배상 청구 또는 소송을 비롯한 각종 이의제기를 받는 경우 당해 이용자는 그로 인하여 회사에 발생한 모든 손해를 배상하여야 합니다.</dd>
					</dl>
					<dl>
						<dt>제 26 조 (면책조항)</dt>
						<dd>1. 당 서비스는 이용자의 귀책사유로 인한 서비스 이용 상의 장애 또는 서비스 이용과 관련한 손해에 대하여 책임을 지지 않습니다.</dd>
						<dd>2. 회사는 다음 각 호에 해당하는 사유로 인하여 이용자 또는 제3자에게 발생하는 손해에 대하여는 그 책임을 지지 아니합니다.</dd>
						<dd>
							<ul>
								<li>1) 천재지변 또는 이에 준하는 불가항력으로 인해 서비스를 제공할 수 없는 경우</li>
								<li>2) 이용자가 자신의 아이디, 비밀번호, 발급키 등의 관리를 소홀히 하는 등 타인의 부정사용을 방치한 경우</li>
								<li>3) 이용자가 제3자의 아이디, 비밀번호, 발급키, 휴대폰번호 등 개인정보를 도용하여 제3자에게 손해를 발생시킨 경우</li>
								<li>4) 회사의 관리 영역이 아닌 공중통신선로의 장애 또는 서비스용 설비의 보수 또는 공사 등 부득이한 사유로 서비스 이용이 불가능한 경우</li>
								<li>5) 기타 회사의 귀책사유가 없는 통신서비스 등의 장애로 인한 경우3. 회사는 이용자가 서비스를 이용하여 얻은 정보 등으로 입은 손해 등에 대하여는 책임이 면제되며, 이용자가 서비스에 기재한 정보, 자료, 사실의 정확성, 신뢰성 등의 내용에 관하여는 어떠한 책임도 부담하지 않습니다.</li>
							</ul>
						</dd>
						<dd>4. 이용자는 서비스 이용에 있어서, 관련 법령을 준수하고, 관련 법령을 위반하지 않도록 수시로 필용한 사항을 확인하여야 하며, 이를 게을리 하는 등의 부주위로 발생한 손해에 대해서는 회사는 책임을 지지 않습니다.</dd>
						<dd>5. 이용자가 서비스를 이용함에 있어 행한 불법행위나 본 약관 위반행위로 인하여 당해 이용자 이외의 제3자로부터 손해배상 청구 또는 소송을 비롯한 각종 이의제기를 받는 경우 당해 이용자는 자신의 책임과 비용으로 회사를 면책시켜야 하며, 회사가 면책되지 못한 경우 당해 이용자는 그로 인하여 회사에 발행한 모든 손해를 배상하여야 합니다.</dd>
					</dl>
					<dl>
						<dt>제 27 조 (관할법원)</dt>
						<dd>1. 서비스 이용과 관련하여 회사와 이용자 사이에 분쟁이 발생한 경우, 쌍방 간에 분쟁의 해결을 위해 성실히 협의한 후가 아니면 제소할 수 없습니다.</dd>
						<dd>2. 본 조 제1항의 협의에서도 분쟁이 해결되지 않아 소송이 제기될 경우 서울중앙지방법원을 전속적 관할 법원으로 합니다.</dd>
					</dl>
					<dl>
						<dt>* 부 칙 *</dt>
						<dd>1. (시행일) 본 약관은 2016년 3월 31일부터 시행합니다.</dd>
					</dl>
				</div>
			</div>
			<div class="agree">
				<input type="checkbox" id="agree" name="agree">
				<label for="agree"><span></span><strong>해당 약관의 내용을 숙지하였으며, 이에 동의합니다.</strong></label>
			</div>
			<div class="title_frame">
			    <p>관련 정보 등록</p>
				<div class="table_typeA gray">
					<table>
						<colgroup>
							<col width="118px"/>
							<col width="*"/>
						</colgroup>
						<tbody>
							<tr>
								<td>신청자</td>
								<td>${session.getUserNm()} (${session.getUserId()})</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="btn_area">
				<a href="#" class="b_btn blue_btn" id="btnIssue">Key 발급 신청하기</a>
				<a href="#" class="b_btn gray_btn" id="btnCancel">취소</a>
			</div>
		</div><!-- //bg_frame_content -->
	</div><!-- //padding_box -->
	<form id="commonForm" name="commonForm"></form>
</div><!-- //inner-box -->

</body>

</body>
</html>
