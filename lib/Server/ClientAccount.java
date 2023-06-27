import java.io.FileWriter;
import java.io.IOException;

public class ClientAccount {
    boolean signup(String username) {
        DataBaseHandler handler = new DataBaseHandler("db/Users.csv");
        try {
            FileWriter writer = new FileWriter(handler.file);
            String[] userInfo = handler.findUserRows(username);
            if (userInfo.length == 0) {
                writer.write(username + "\n");
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