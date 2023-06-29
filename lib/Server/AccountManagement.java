import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;

public class AccountManagement {
    String signup(String isSeller, String username, String password, String email, String firstName) {
        DataBaseHandler handler = new DataBaseHandler("db/Users.csv");
        try {
            File file = new File("db/Users.csv");
            FileWriter writer = new FileWriter(file, true);
            String[] userInfo = handler.findUserRows(username, true);
            boolean usedEmail = handler.findEmail(email);
            if (userInfo.length == 0 && !usedEmail) {
                String info = username + "-" + isSeller + "-" + password + "-" + email +
                        "-" + "null" + "-" + "null" + "-" + "null" + "-" + firstName + "-" + "null" + "-" + "null" + "\n";
                writer.write(info);
                writer.close();
            } else if (usedEmail){
                return "email";
            } else {
                return "un";
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return "true";
    }
    String login(String isSeller, String email, String password) {
        DataBaseHandler handler = new DataBaseHandler("db/Users.csv");
        String[] userInfo = handler.findUserRows(email, false);
        if (userInfo.length != 0 && userInfo[0].split("-")[1].equals(isSeller) && userInfo[0].split("-")[2].equals(password)) {
            return userInfo[0].split("-")[0];   // return username
        } else {
            return "false";
        }
    }
    String edit(String type, String username, String data) {
        DataBaseHandler handler = new DataBaseHandler("db/Users.csv");
        String[] userInfo = handler.findUserRows(username, true);
        if (userInfo.length != 0) {
            System.out.println(Arrays.toString(userInfo));
            String[] info = userInfo[0].split("-");
            switch (type) {
                case "password" -> info[2] = data;
                case "email" -> {
                    if (handler.findEmail(data)) {
                        return "false";
                    } else {
                        info[3] = data;
                    }
                }
                case "balance" -> info[4] = data;
                case "phoneNumber" -> info[5] = data;
                case "birthdate" -> info[6] = data;
                case "firstName" -> info[7] = data;
                case "lastName" -> info[8] = data;
                case "nationalId" -> info[9] = data;
                default -> {
                    return "false";
                }
            }
            String newData = info[0] + "-" + info[1] + "-" + info[2] + "-" + info[3] + "-" + info[4] + "-" + info[5] +
                    "-" + info[6] + "-" + info[7] + "-" + info[8] + "-" + info[9] + "\n";
            handler.deleteRow(username);
            handler.write(newData);
            return "true";
        } else {
            return "false";
        }
    }
}