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
            email = email.toLowerCase();
            username = username.toLowerCase();
            String[] userInfo = handler.findUserRows(username, true);
            boolean usedEmail = handler.findEmail(email);
            if (userInfo.length == 0 && !usedEmail) {
                String info = username + "-" + isSeller + "-" + password + "-" + email +
                        "-" + "0" + "-" + "null" + "-" + "null" + "-" + firstName + "-" + "null" + "-" + "null" + "\n";
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
        email = email.toLowerCase();
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

    String getUser(String username) {
        DataBaseHandler handler = new DataBaseHandler("db/Users.csv");
        String[] userRow = handler.findUserRows(username, true);
        return userRow[0];
    }

    String getTransactions(String username) {
        DataBaseHandler handler = new DataBaseHandler("db/Transactions.csv");
        String[] transactions = handler.findUserRows(username, true);
        if (transactions.length != 0) {
            StringBuilder out = new StringBuilder();
            for (String transaction : transactions) {
                out.append(transaction).append("*");
            }
            return out.substring(0, out.length() - 1);
        } else {
            return "false";
        }
    }

    String getTransfers(String username) {
        DataBaseHandler handler = new DataBaseHandler("db/Transfers.csv");
        String[] transfers = handler.findUserRows(username, true);
        if (transfers.length != 0) {
            StringBuilder out = new StringBuilder();
            for (String transfer : transfers) {
                out.append(transfer).append("*");
            }
            return out.substring(0, out.length() - 1);
        } else {
            return "false";
        }
    }

    String getFirstName(String username) {
        DataBaseHandler handler = new DataBaseHandler("db/Users.csv");
        String[] userInfo = handler.findUserRows(username, true);
        if (userInfo.length != 0) {
            return userInfo[0].split("-")[7];
        } else {
            return "false";
        }
    }

    String addTransaction(String username, String date, String amount, String type) {
        DataBaseHandler TransactionHandler = new DataBaseHandler("db/Transactions.csv");
        DataBaseHandler UserHandler = new DataBaseHandler("db/Users.csv");
        try {
            File file = new File("db/Transactions.csv");
            FileWriter writer = new FileWriter(file, true);
            String info = username + "-" + date + "-" + amount + "-" + type + "\n";
            writer.write(info);
            writer.close();
            file = new File("db/Users.csv");
            writer = new FileWriter(file, true);
            String[] userInfo = UserHandler.findUserRows(username, true);
            String[] infoArr = userInfo[0].split("-");
            System.out.println(userInfo[0]);
            infoArr[4] = String.valueOf(Integer.parseInt(infoArr[4]) + Integer.parseInt(amount));
            String newData = infoArr[0] + "-" + infoArr[1] + "-" + infoArr[2] + "-" + infoArr[3] + "-" + infoArr[4] + "-" + infoArr[5] +
                    "-" + infoArr[6] + "-" + infoArr[7] + "-" + infoArr[8] + "-" + infoArr[9] + "\n";
            UserHandler.deleteRow(username);
            writer.write(newData);
            writer.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return "true";
    }

    String addTransfer(String username, String date, String amount, String id) {
        DataBaseHandler handler = new DataBaseHandler("db/Transfers.csv");
        DataBaseHandler UserHandler = new DataBaseHandler("db/Users.csv");
        try {
            File file = new File("db/Transfers.csv");
            FileWriter writer = new FileWriter(file, true);
            String info = username + "-" + date + "-" + amount + "-" + id + "\n";
            writer.write(info);
            writer.close();
            file = new File("db/Users.csv");
            writer = new FileWriter(file, true);
            String[] userInfo = UserHandler.findUserRows(username, true);
            String[] infoArr = userInfo[0].split("-");
            infoArr[4] = String.valueOf(Integer.parseInt(infoArr[4]) - Integer.parseInt(amount));
            String newData = infoArr[0] + "-" + infoArr[1] + "-" + infoArr[2] + "-" + infoArr[3] + "-" + infoArr[4] + "-" + infoArr[5] +
                    "-" + infoArr[6] + "-" + infoArr[7] + "-" + infoArr[8] + "-" + infoArr[9] + "\n";
            UserHandler.deleteRow(username);
            writer.write(newData);
            writer.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return "true";
    }

    String getTakenTrips(String username) {
        DataBaseHandler handler = new DataBaseHandler("db/TakenTrips.csv");
        String[] trips = handler.findUserRows(username, true);
        if (trips.length != 0) {
            StringBuilder out = new StringBuilder();
            for (String trip : trips) {
                out.append(trip).append("*");
            }
            return out.substring(0, out.length() - 1);
        } else {
            return "false";
        }
    }
}