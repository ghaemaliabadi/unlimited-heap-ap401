import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.charset.StandardCharsets;

public class Server {
    static boolean isServerUp = true;
    static int port = 1234;

    public static void main(String[] args) {
        try {
            ServerSocket serverSocket = new ServerSocket(port);
            while (isServerUp) {
                Socket socket = serverSocket.accept();
                System.out.println("Connected");
                RequestHandler requestHandler = new RequestHandler(socket);
                requestHandler.start();
            }
        } catch (IOException e) {
            System.out.println("Server was not created!");
        }
    }
}

class RequestHandler extends Thread {
    Socket socket;
    BufferedReader dis;
    BufferedWriter dos;

    RequestHandler(Socket socket) {
        this.socket = socket;
        try {
            dis = new BufferedReader(new InputStreamReader(socket.getInputStream(), StandardCharsets.UTF_8));
//            dis = new DataInputStream(socket.getInputStream());
//            dos = new DataOutputStream(socket.getOutputStream());
            dos = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream(), StandardCharsets.UTF_8));
        } catch (IOException e) {
            System.out.println("Request was failed");
        }
    }

    String listener() {
        StringBuilder listen = new StringBuilder();
        char i;
        try {
            while (true) {
                i = (char) dis.read();
                if (i == '*') {
                    break;
                }
                listen.append(i);
            }
        } catch (IOException e) {
            System.out.println("catch1");
            try {
                dis.close();
                dos.close();
                socket.close();
            } catch (IOException ioException) {
                System.out.println("catch2");
                ioException.printStackTrace();
            }
            e.printStackTrace();
        }
        return listen.toString();
    }

    @Override
    public void run() {
        String data = listener();
        System.out.println("data is: " + data);
        String[] dataArr = data.split("-");
        String response = "";
        switch (dataArr[0]) {
            case "signup":
                AccountManagement accountManagement = new AccountManagement();
                if (dataArr[1].equals("true")) {
                    response = String.valueOf(accountManagement.signup(dataArr[1], dataArr[2], dataArr[3], dataArr[4], dataArr[5]));
                } else {
                    response = String.valueOf(accountManagement.signup(dataArr[1], dataArr[2], dataArr[3], dataArr[4], "null"));
                }
                break;
            case "login":
                accountManagement = new AccountManagement();
                response = String.valueOf(accountManagement.login(dataArr[1], dataArr[2], dataArr[3]));
                break;
            case "edit":
                accountManagement = new AccountManagement();
                if (dataArr[1].equals("all")) {
                    String r1 = String.valueOf(accountManagement.edit("firstName", dataArr[2], dataArr[3]));
                    String r2 = String.valueOf(accountManagement.edit("lastName", dataArr[2], dataArr[4]));
                    String r3 = String.valueOf(accountManagement.edit("nationalId", dataArr[2], dataArr[5]));
                    String r4 = String.valueOf(accountManagement.edit("phoneNumber", dataArr[2], dataArr[6]));
                    String r5 = String.valueOf(accountManagement.edit("birthdate", dataArr[2], dataArr[7]));
                    response = (r1.equals("true") && r2.equals("true") && r3.equals("true") && r4.equals("true") && r5.equals("true")
                            ? "true"
                            : "false");
                } else {
                    response = String.valueOf(accountManagement.edit(dataArr[1], dataArr[2], dataArr[3]));
                }
                break;
            case "getUser":
                accountManagement = new AccountManagement();
                response = accountManagement.getUser(dataArr[1]);
                break;
            case "getTransactions":
                accountManagement = new AccountManagement();
                response = accountManagement.getTransactions(dataArr[1]);
                break;
            case "addTransaction":
                accountManagement = new AccountManagement();
                response = accountManagement.addTransaction(dataArr[1], dataArr[2], dataArr[3], dataArr[4]);
                break;
            case "addTransfer":
                accountManagement = new AccountManagement();
                response = accountManagement.addTransfer(dataArr[1], dataArr[2], dataArr[3], dataArr[4]);
                break;
            case "getTransfers":
                accountManagement = new AccountManagement();
                response = accountManagement.getTransfers(dataArr[1]);
                break;
            case "addTakenTrip":
                accountManagement = new AccountManagement();
                response = accountManagement.addTakenTrip(dataArr[1], dataArr[2], dataArr[3], dataArr[4], dataArr[5], dataArr[6],
                        dataArr[7], dataArr[8], dataArr[9], dataArr[10], dataArr[11], dataArr[12], dataArr[13], dataArr[14]);
                break;
            case "getTakenTrips":
                accountManagement = new AccountManagement();
                response = accountManagement.getTakenTrips(dataArr[1]);
                break;
            case "getFirstName":
                accountManagement = new AccountManagement();
                response = accountManagement.getFirstName(dataArr[1]);
                break;
            case "addTicket":
                TicketManagement ticketManagement = new TicketManagement();
                response = String.valueOf(ticketManagement.addTicket(dataArr[1], dataArr[2], dataArr[3], dataArr[4],
                        dataArr[5], dataArr[6], dataArr[7], dataArr[8], dataArr[9], dataArr[10], dataArr[11], dataArr[12],
                        dataArr[13], dataArr[14], dataArr[15], dataArr[16], dataArr[17], dataArr[18],
                        dataArr[19].equals("null") ? "" : dataArr[19], dataArr[20].equals("null") ? "" : dataArr[20],
                        dataArr[21].equals("null") ? "" : dataArr[21], dataArr[22].equals("null") ? "" : dataArr[22]));
                break;
            case "getTickets":
                ticketManagement = new TicketManagement();
                response = ticketManagement.getTickets(dataArr[1]);
                break;
            case "deleteTicket":
                ticketManagement = new TicketManagement();
                response = String.valueOf(ticketManagement.deleteTicket(dataArr[1]));
                break;
            case "editTicket":
                ticketManagement = new TicketManagement();
                ticketManagement.deleteTicket(dataArr[1]);
                response = String.valueOf(ticketManagement.addTicket(dataArr[1], dataArr[2], dataArr[3], dataArr[4], dataArr[5], dataArr[6], dataArr[7], dataArr[8], dataArr[9], dataArr[10], dataArr[11], dataArr[12], dataArr[13], dataArr[14], dataArr[15], dataArr[16], dataArr[17], dataArr[18], dataArr[19].equals("null") ? "" : dataArr[19], dataArr[20].equals("null") ? "" : dataArr[20], dataArr[21].equals("null") ? "" : dataArr[21], dataArr[22].equals("null") ? "" : dataArr[22]));
                break;
            case "getAllOrigins":
                ticketManagement = new TicketManagement();
                response = ticketManagement.getAllOrigins(dataArr[1]);
                break;
            case "getTicketsFromTo":
                ticketManagement = new TicketManagement();
                response = ticketManagement.getTicketsFromTo(dataArr[1], dataArr[2], dataArr[3], dataArr[4], dataArr[5]);
                break;
            default:
                response = "false";
        }
        try {
            dos.write(response);
            dos.flush();
            dos.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}