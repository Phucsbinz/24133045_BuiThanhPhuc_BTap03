package vn.iotstar.util;

import java.io.File;

public class Constant {
    public static final String DIR = initUploadDir();
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";

    private static String initUploadDir() {
        try {
            File dUpload = new File("d:\\upload");
            if (dUpload.exists() || (new File("d:\\").exists() && dUpload.mkdirs())) {
                return "d:\\upload";
            }
        } catch (Exception ignored) {
        }
        // Fallback neu may khong co o dia D (vi du chi co o C, macOS hoac Linux)
        String userHome = System.getProperty("user.home");
        File fallback = new File(userHome, "upload");
        if (!fallback.exists()) {
            fallback.mkdirs();
        }
        return fallback.getAbsolutePath();
    }
}

