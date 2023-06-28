import java.io.FileWriter;
import java.io.IOException;

public class ClientAccount {
    boolean signup(String username, String password, String email) {
        DataBaseHandler handler = new DataBaseHandler("db/Users.csv");
        try {
            FileWriter writer = new FileWriter(handler.file, true);
            String[] userInfo = handler.findUserRows(username);
            if (userInfo.length == 0) {
                String info = username + "-" + password + "-" + email + "\n";
                writer.write(info);
                writer.close();
            } else {
                return false;
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return true;
    }
}