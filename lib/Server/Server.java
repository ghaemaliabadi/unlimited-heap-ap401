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
            case "addTicket":
                TicketManagement ticketManagement = new TicketManagement();
                response = String.valueOf(ticketManagement.addTicket(dataArr[1], dataArr[2], dataArr[3], dataArr[4], dataArr[5], dataArr[6], dataArr[7], dataArr[8], dataArr[9], dataArr[10], dataArr[11], dataArr[12], dataArr[13], dataArr[14], dataArr[15], dataArr[16], dataArr[17], dataArr[18], dataArr[19], dataArr[20], dataArr[21], dataArr[22]));
            case "getTickets":
                ticketManagement = new TicketManagement();
                response = ticketManagement.getTickets(dataArr[1]);
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