import java.io.File;
import java.util.ArrayList;
import java.util.Scanner;

public class DataBaseHandler {
    final File file;
    DataBaseHandler(String fileName) {
        this.file = new File(fileName);
    }
    String[] findUserRows(String username) {
        ArrayList<String> rows = new ArrayList<>();
        try {
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
}