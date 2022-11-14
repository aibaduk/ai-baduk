<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/jsp/views/common/head.jsp" %>
	<title>연구소 소개</title>
</head>
<body>
	<div class="wrapper">
		<%@ include file="/WEB-INF/jsp/views/common/header.jsp" %>
        <section class="container">
            <div class="keyvi"></div>
            <section class="content intro">
                <div class="inner">
                    <div class="tab-wrap">
                        <ul class="tab-menu"></ul>
                        <div class="inner-depth">
                            <div class="tab-inner">
                                <h2>연구소 소개</h2>
                                <p>구텐베르크(Gutenberg)가 발명한 금속활자는 인쇄술의 혁명을 불러일으켰고, 증기기관차의 등장은 세계의 거리를 단축시켰으며, 컴퓨터는 새로운 디지털 세계를 창조했습니다.</p>
                                <img src="/static/images/img_introduce1.jpg" alt="">
                                <p>그리고, 구글 딥마인드(Google DeepMind)사가 개발한 알파고(AlphaGo)는 5000년 바둑 이론의 근간을 뒤흔들었습니다.</p>
                                <img src="/static/images/img_introduce2.jpg" alt="">
                                <div class="introduce">
                                    <div>
                                        <p>현재 바둑계는 혁신의 중심에 서있습니다.<br>달리기 선수가 기관차를 경쟁상대로 여기지 않듯 인간의 한계를 넘어선 바둑AI는 더 이상 이겨야 할 대상이 아닌 성장의 도구로 활용되어야 합니다.</p>
                                        <p>아날로그에 머물러 있던 바둑은 AI를 통해 정보화시대를 맞이했고, AI가 던져주는 무한한 정보의 홍수 속에서 학습자에게 적확하고 효율적인 정보를 선별하여 제공하는 커리큘럼이 새로운 문명이 인류에게 선물한 신(新)개념 교육 방법입니다.</p>
                                    </div>
                                    <img src="/static/images/img_introduce3.jpg" alt="알파고(AlphaGo)의 등장은 시작일 뿐입니다. 한국AI바둑연구소가 미래 바둑 혁명을 선도하겠습니다.">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </section>
		<%@ include file="/WEB-INF/jsp/views/common/footer.jsp" %>
	</div>
</body>
</html>