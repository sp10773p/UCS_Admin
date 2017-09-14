<%--
    Class Name : logList.jsp
    Description : 로그목록조회
    Modification Information
    수정일      수정자   수정내용
    ----------- -------- ---------------------------
    2017.01.15  성동훈   최초 생성
    author : 성동훈
    since : 2017.01.15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%@ include file="/WEB-INF/include/include-admin-header.jspf" %>
    <script>
        var gridWrapper, headers;
        $(function (){
            headers = [
                {"HEAD_TEXT": "로그일자"   , "WIDTH": "150", "FIELD_NAME": "LOG_DTM"},
                {"HEAD_TEXT": "스케쥴ID"   , "WIDTH": "150", "FIELD_NAME": "SCREEN_ID" },
                {"HEAD_TEXT": "스케쥴명"   , "WIDTH": "150", "FIELD_NAME": "SCREEN_NM"},
                {"HEAD_TEXT": "비고"       , "WIDTH": "*", "FIELD_NAME": "RMK", "ALIGN":"left"}
            ];

            gridWrapper = new GridWrapper({
                "actNm"        : "스케쥴로그 조회",
                "targetLayer"  : "gridLayer",
                "qKey"         : "log.selectSchLogList",
                "headers"      : headers,
                "paramsFormId" : "searchForm",
                "gridNaviId"   : "gridPagingLayer",
                "firstLoad"    : true,
                "check"        : true,
                "controllers"  : [
                    {"btnName": "btnSearch", "type": "S"},
                    {"btnName": "btnExcel" , "type": "EXCEL"}
                ]
            });

        });
    </script>
</head>
<body>
<div id="content_body">
    <%-- 조회 영역 --%>
    <div class="search_toggle_frame">
        <form id="searchForm">
            <div class="search_frame">
                <ul class="search_sectionB">
                    <li>
                        <label for="F_LOG_DTM">로그일자</label><label for="T_LOG_DTM"
                                                                  style="display: none">로그일자</label>
                        <div class="dateSearch">
                            <form action="#">
                                <fieldset>
                                    <legend class="blind">달력</legend>
                                    <input type="text" id="F_LOG_DTM" name="F_LOG_DTM" class="input" <attr:datefield to="T_LOG_DTM" value="0"/> />
                                    <span>~</span>
                                    <input type="text" id="T_LOG_DTM" name="T_LOG_DTM" class="input" <attr:datefield  value="0"/>/>
                                </fieldset>
                            </form>
                        </div>
                    </li>
                    <li>
                        <label for="SCREEN_ID">스케쥴ID</label>
                        <input id="SCREEN_ID" name="SCREEN_ID" type="text">
                    </li>
                    <li>
                        <label for="SCREEN_NM">스케쥴명</label>
                        <input id="SCREEN_NM" name="SCREEN_NM" type="text">
                    </li>
                </ul>
                <a href="#조회" id="btnSearch" class="btn_inquiryC" style="float:right;">조회</a>
            </div>
            <a href="" class="search_toggle close">검색접기</a>
        </form>
    </div>

    <div class="white_frame">
        <div class="util_frame">
            <a href="#엑셀 다운로드" class="btn white_100" id="btnExcel">엑셀 다운로드</a>
        </div>
        <div id="gridLayer" style="height: 430px">
        </div>
        <div class="bottom_util">
            <div class="paging" id="gridPagingLayer">
            </div>
        </div>

    </div>
    <%-- white_frame --%>
</div>
<%@ include file="/WEB-INF/include/include-admin-body.jspf" %>
</body>
</html>
