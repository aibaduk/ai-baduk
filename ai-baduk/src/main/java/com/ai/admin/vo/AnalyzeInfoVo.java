package com.ai.admin.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AnalyzeInfoVo extends BaseVo {

	/** 회원ID */
	private String userId;

	/** 분석정보ID */
	private String analyzeInfoId;

	/** 바둑성향 */
	private String badukTendency;

	/** 승리패턴 */
	private String victoryPattern;

	/** BP */
	private String bp;

	/** IBM */
	private String ibm;

	/** 목표 */
	private String target;

	/** 포석 */
	private String opening;

	/** 포석 starting */
	private String openingStarting;

	/** 포석 AI일치율 */
	private String openingAiMatchRate;

	/** 포석 AI그래프 */
	private String openingAiGraph;

	/** 포석 실착률 */
	private String openingMissRate;

	/** 중반 */
	private String middleGame;

	/** 중반 전투력 */
	private String middleGameCombativePower;

	/** 중반 선방율 */
	private String middleGameSaveRate;

	/** 중반 실착횟수 */
	private String middleGameMissCnt;

	/** 중반 실착율 */
	private String middleGameMissRate;

	/** 끝내기 */
	private String endGame;

	/** 끝내기 DEFENSE */
	private String endGameDefense;

	/** 끝내기 DEFENSE_FAILURE */
	private String endGameDefenseFailure;

	/** 끝내기 TURN_THE_TABLES */
	private String endGameTurnTheTables;

	/** 끝내기 실착횟수 */
	private String endGameMissCnt;

	/** 승부호흡 */
	private String gameTiming;

	/** 승부호흡 흔들기 */
	private String gameTimingWave;

	/** 승부호흡 수비 */
	private String gameTimingDefence;

	/** 기술 */
	private String technique;

	/** 기술 가치판단 */
	private String techniqueValueJudgment;

	/** 기술 행마 */
	private String techniqueHaengma;

	/** 기술 수읽기 */
	private String techniqueReading;

	/** 시험 포석/형세판단 */
	private String examOpeningPositionalJudgment;

	/** 시험 행마/가치판단 */
	private String examHaengmaValueJudgment;

	/** 시험 수읽기/사활 */
	private String examReadingLifeAndDeath;

	/** 시험 끝내기/계가 */
	private String examEndGameCounting;

	/** 시험 총점 */
	private String examTotal;

	/** 총점 */
	private String allTotal;

	/** 비고 */
	private String etc;

	/** 사용자 정보 */
	private String userGrade;
	private String userNm;
	private String userNickNm;
	private String levelNm;
	private String age;
	private String team;

}
