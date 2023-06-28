import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class ClientAccount {
    String signup(String username, String password, String email) {
        DataBaseHandler handler = new DataBaseHandler("db/Users.csv");
        try {
            File file = new File("db/Users.csv");
            FileWriter writer = new FileWriter(file, true);
            String[] userInfo = handler.findUserRows(username);
            boolean usedEmail = handler.findEmail(email);
            if (userInfo.length == 0 && !usedEmail) {
                String info = username + "-" + password + "-" + email + "\n";
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
}