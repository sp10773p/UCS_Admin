package kr.pe.frame.basic.prod.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Pattern;

public class ProdValidator {
	private static Pattern PTRN_ENG = Pattern.compile("[a-zA-Z]+");
	private static Pattern PTRN_UPPER_ENG = Pattern.compile("[A-Z]+");
	private static Pattern PTRN_ENG_SPC = Pattern.compile("[a-zA-Z ]+");
	private static Pattern PTRN_ENG_NUM = Pattern.compile("[a-zA-Z0-9]+");
	private static Pattern PTRN_ENG_NUM_SPC = Pattern.compile("[a-zA-Z0-9 ]+");
	private static Pattern PTRN_NUM = Pattern.compile("[0-9]+");

	private static String TYPE_ENG = "ENG";
	private static String TYPE_UPPER_ENG = "UPPER_ENG";
	private static String TYPE_ENG_SPC = "ENG_SPC";
	private static String TYPE_ENG_NUM = "ENG_NUM";
	private static String TYPE_ENG_NUM_SPC = "ENG_NUM_SPC";
	private static String TYPE_NUM = "NUM";

	private static String TYPE_NONE = "";
	
	// 영문,숫자,길이,필수항목 체크
	public static String isValidEngNum(String value, String title, int length, boolean required) throws Exception {
		return valueCheck(value, title, TYPE_ENG_NUM, length, false, required);
	}
	
	// 영문,숫자,길이,공백,필수항목 체크
	public static String isValidEngNumSpc(String value, String title, int length, boolean required) throws Exception {
		return valueCheck(value, title, TYPE_ENG_NUM_SPC, length, false, required);
	}
	
	
	// 대문자 영문,길이,필수항목 체크
	public static String isValidUpperEng(String value, String title, int length, boolean required) throws Exception {
		return valueCheck(value, title, TYPE_UPPER_ENG, length, false, required);
	}

	// 숫자,길이,필수항목 체크
	public static String isValidNum(String value, String title, int numberLength, int decimalLength, boolean required) throws Exception {
		return numberValueCheck(value, title, numberLength, decimalLength, required);
	}
	
	// 공통
	public static String isValidComm(String value, String title, int length, boolean required) throws Exception {
		return valueCheck(value, title, TYPE_NONE, length, false, required);
	}
	
	public static String lengthLimit(String inputStr, int limit, String fixStr) {
        if (inputStr == null) return "";
        if (limit <= 0) return inputStr;

        byte[] strbyte = null;
        strbyte = inputStr.getBytes();

        if (strbyte.length <= limit) return inputStr;
        char[] charArray = inputStr.toCharArray();

        int checkLimit = limit;
        for ( int i = 0 ; i < charArray.length ; i++ ) {
            if (charArray[i] < 256) {
                checkLimit -= 1;
            } else {
                checkLimit -= 2;
            }
            if (checkLimit <= 0) break;
        }
        byte[] newByte = new byte[limit + checkLimit];

        for ( int i = 0 ; i < newByte.length ; i++ ) {
            newByte[i] = strbyte[i];
        }

        if (fixStr == null) {
            return new String(newByte);
        } else {
            return new String(newByte) + fixStr;
        }
    }
	
	/**
	 * 입력값을 필수여부, 길이, 검증타입에 따라 체크한다.
	 *
	 * @param value 입력값
	 * @param name 입력값 이름
	 * @param type 검증타입
	 * @param size 최대바이트
	 * @param sameSizeOnly 입력값의 바이트수와 최대바이트수가 일치해야만 하는지 여부
	 * @param required 필수 여부
	 * @return
	 */
	private static String valueCheck(String value, String name, String type, int size, boolean sameSizeOnly, boolean required) {
		String errMsg = "";

		if (value == null || value.length() == 0) {
			if (required) {
				errMsg = makeMsg(name, "은(는)", "필수항목입니다.\n");
			}
		} else if (sameSizeOnly && value.getBytes().length != size) {
			errMsg = makeMsg(name, "의", "길이가 맞지 않습니다. " + size + " 자리만 가능합니다.\n");
		} else if (!sameSizeOnly && value.getBytes().length > size) {
			errMsg = makeMsg(name,  "의", "길이가 너무 깁니다. 최대바이트(" + size + ")\n");
		} else if (TYPE_ENG.equals(type) && !PTRN_ENG.matcher(value).matches()) {
			errMsg = makeMsg(name, "에는", "영문만 입력 가능합니다.\n");
		} else if (TYPE_ENG_SPC.equals(type) && !PTRN_ENG_SPC.matcher(value).matches()) {
			errMsg = makeMsg(name, "에는", "영문, 공백만 입력 가능합니다.\n");
		} else if (TYPE_ENG_NUM.equals(type) && !PTRN_ENG_NUM.matcher(value).matches()) {
			errMsg = makeMsg(name, "에는", "영문, 숫자만 입력 가능합니다.\n");
		} else if (TYPE_ENG_NUM_SPC.equals(type) && !PTRN_ENG_NUM_SPC.matcher(value).matches()) {
			errMsg = makeMsg(name, "에는", "영문, 숫자, 공백만 입력 가능합니다.\n");
		} else if (TYPE_NUM.equals(type) && !PTRN_NUM.matcher(value).matches()) {
			errMsg = makeMsg(name, "에는", "숫자만 입력 가능합니다.\n");
		} else if (TYPE_UPPER_ENG.equals(type) && !PTRN_UPPER_ENG.matcher(value).matches()) {
			errMsg = makeMsg(name, "에는", "대문자 영문만 가능합니다.\n");
		}
		return errMsg;
	}

	/**
	 * 숫자 입력값을 필수여부, 정수부/소수부 길이에 따라 체크한다.
	 *
	 * @param value 입력값
	 * @param name 입력값 이름
	 * @param type 검증타입
	 * @param size 최대바이트
	 * @param sameSizeOnly 입력값의 바이트수와 최대바이트수가 일치해야만 하는지 여부
	 * @param required 필수 여부
	 * @return
	 * @throws Exception
	 */
	private static String numberValueCheck(String value, String name, int numberSize, int decimalSize, boolean require) throws Exception {
		String errMsg = "";

		if (value == null || value.length() == 0) {
			if (require) {
				errMsg = makeMsg(name, "은(는)", "필수항목입니다.\n");
			}
		} else if (numberSize < 0 || decimalSize < 0) {
			errMsg = makeMsg(name, "의", "숫자 자리수 설정이 잘못 되었습니다.\n");
		} else if (value.length() > (numberSize + decimalSize + (decimalSize > 0 ? 1 : 0))) {
			errMsg = makeMsg(name, "의", "길이가 너무 깁니다. 소수점 제외 최대 " + (numberSize + decimalSize) + "자리로 입력해 주세요.\n");
		} else {
			Pattern numberPoint = Pattern.compile("[0-9]{1," + numberSize + "}" + (decimalSize > 0 ? "(\\.[0-9]{1," + decimalSize + "})?" : ""));
			if (!numberPoint.matcher(value).matches()) {
				errMsg = makeMsg(name, "의", "값이 올바르지 않습니다. 정수 부분은 최대 " + numberSize + "자리, 소수 부분은 최대 " + decimalSize + "자리로 입력해 주세요.\n");
			}
		}

		return errMsg;
	}

	private static String makeMsg(String title, String postposition, String msg) {
		if (title == null || title.equals("")) {
			return msg;
		}

		return title + postposition + " " + msg;
	}

}
