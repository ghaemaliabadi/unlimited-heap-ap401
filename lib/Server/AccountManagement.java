import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

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
}