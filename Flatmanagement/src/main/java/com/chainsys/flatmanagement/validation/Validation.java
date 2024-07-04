package com.chainsys.flatmanagement.validation;

import java.util.regex.Pattern;

public class Validation {

    private static final Pattern NAME_PATTERN = Pattern.compile("^[a-zA-Z\\s]+$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^\\d{10}$");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    private static final Pattern AADHAAR_PATTERN = Pattern.compile("^\\d{12}$");
    private static final Pattern ADVANCE_STATUS_PATTERN = Pattern.compile("^(Paid|Unpaid)$");
    private static final Pattern FLAT_TYPE_PATTERN = Pattern.compile("^[A-Za-z\\s]+$");
    private static final Pattern FLOOR_NUMBER_PATTERN = Pattern.compile("^\\d+$");
    private static final Pattern ROOM_NUMBER_PATTERN = Pattern.compile("^\\d+$");
    private static final Pattern DATE_PATTERN = Pattern.compile("^\\d{4}-\\d{2}-\\d{2}$");
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$");

    public static boolean isValidName(String name) {
        return NAME_PATTERN.matcher(name).matches();
    }

    public static boolean isValidPhoneNo(String phoneNo) {
        return PHONE_PATTERN.matcher(phoneNo).matches();
    }

    public static boolean isValidEmail(String email) {
        return EMAIL_PATTERN.matcher(email).matches();
    }

    public static boolean isValidAadhaarNumber(String aadhaarNumber) {
        return AADHAAR_PATTERN.matcher(aadhaarNumber).matches();
    }

    public static boolean isValidAdvanceStatus(String advanceStatus) {
        return ADVANCE_STATUS_PATTERN.matcher(advanceStatus).matches();
    }

    public static boolean isValidFlatType(String flatType) {
        return FLAT_TYPE_PATTERN.matcher(flatType).matches();
    }

    public static boolean isValidFloorNumber(String floorNumber) {
        return FLOOR_NUMBER_PATTERN.matcher(floorNumber).matches();
    }

    public static boolean isValidRoomNumber(String roomNumber) {
        return ROOM_NUMBER_PATTERN.matcher(roomNumber).matches();
    }

    public static boolean isValidDate(String date) {
        return DATE_PATTERN.matcher(date).matches();
    }
    public static boolean isValidPassword(String password) {
        return PASSWORD_PATTERN.matcher(password).matches();
    }
}
