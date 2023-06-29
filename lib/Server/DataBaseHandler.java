import java.io.File;
import java.util.ArrayList;
import java.util.Objects;
import java.util.Scanner;
import java.io.FileWriter;

public class DataBaseHandler {
    String fileName;

    DataBaseHandler(String fileName) {
        this.fileName = fileName;
    }

    String[] findUserRows(String key, boolean isUsername) {
        ArrayList<String> rows = new ArrayList<>();
        try {
            File file = new File(fileName);
            Scanner reader = new Scanner(file);
            String thisRow;
            while (reader.hasNextLine()) {
                thisRow = reader.nextLine();
                if (isUsername) {
                    if (thisRow.split("-")[0].equals(key)) {
                        rows.add(thisRow);
                    }
                } else {
                    if (thisRow.split("-")[3].equals(key)) {
                        rows.add(thisRow);
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("File not found!");
        }
        String[] out = new String[rows.size()];
        return rows.toArray(out);
    }

    String[] getAllTickets() {
        ArrayList<String> rows = new ArrayList<>();
        try {
            File file = new File(fileName);
            Scanner reader = new Scanner(file);
            String thisRow;
            while (reader.hasNextLine()) {
                thisRow = reader.nextLine();
                rows.add(thisRow);
            }
        } catch (Exception e) {
            System.out.println("File not found!");
        }
        String[] out = new String[rows.size()];
        return rows.toArray(out);
    }

    String[] getCompanyTickets(String companyName) {
        ArrayList<String> rows = new ArrayList<>();
        try {
            File file = new File(fileName);
            Scanner reader = new Scanner(file);
            String thisRow;
            while (reader.hasNextLine()) {
                System.out.println("Hi " + companyName);
                thisRow = reader.nextLine();
                if (!Objects.equals(companyName, "all")) {
                    if (thisRow.split("-")[14].equals(companyName)) {
                        rows.add(thisRow);
                    }
                } else {
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
                if (thisRow.split("-")[3].equals(email)) {
                    flag = true;
                    break;
                }
            }
        } catch (Exception e) {
            System.out.println("File not found!");
        }
        return flag;
    }

    void write(String data) {
        try {
            File file = new File(fileName);
            FileWriter writer = new java.io.FileWriter(file, true);
            writer.write(data);
            writer.close();
        } catch (Exception e) {
            System.out.println("File not found!");
        }
    }

    void deleteRow(String username) {
        try {
            File file = new File(fileName);
            Scanner reader = new Scanner(file);
            String thisRow;
            ArrayList<String> rows = new ArrayList<>();
            while (reader.hasNextLine()) {
                thisRow = reader.nextLine();
                if (!thisRow.split("-")[0].equals(username)) {
                    rows.add(thisRow);
                }
            }
            FileWriter writer = new FileWriter(file);
            for (String row : rows) {
                writer.write(row + "\n");
            }
            writer.close();
        } catch (Exception e) {
            System.out.println("File not found!");
        }
    }
}