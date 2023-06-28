import java.io.File;
import java.util.ArrayList;
import java.util.Scanner;

public class DataBaseHandler {
    String fileName;
    DataBaseHandler(String fileName) {
        this.fileName = fileName;
    }
    String[] findUserRows(String username) {
        ArrayList<String> rows = new ArrayList<>();
        try {
            File file = new File(fileName);
            Scanner reader = new Scanner(file);
            String thisRow;
            while (reader.hasNextLine()) {
                thisRow = reader.nextLine();
                if (thisRow.startsWith(username)) {
                    rows.add(thisRow);
                }
            }
        } catch (Exception e) {
            System.out.println("File not found!");
        }
        String[] out = new String[rows.size()];
        return rows.toArray(out);
    }

    boolean findEmail(String email) {
        boolean flag = false;
        try {
            File file = new File(fileName);
            Scanner reader = new Scanner(file);
            String thisRow;
            while (reader.hasNextLine()) {
                thisRow = reader.nextLine();
                if (thisRow.split("-")[2].equals(email)) {
                    flag = true;
                    break;
                }
            }
        } catch (Exception e) {
            System.out.println("File not found!");
        }
        return flag;
    }
}