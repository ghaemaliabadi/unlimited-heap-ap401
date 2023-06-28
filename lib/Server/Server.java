import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

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
    DataInputStream dis;
    DataOutputStream dos;

    RequestHandler(Socket socket) {
        this.socket = socket;
        try {
            dis = new DataInputStream(socket.getInputStream());
            dos = new DataOutputStream(socket.getOutputStream());
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
                response = String.valueOf(accountManagement.signup(dataArr[1], dataArr[2], dataArr[3], dataArr[4]));
                break;
            case "login":
                accountManagement = new AccountManagement();
                response = String.valueOf(accountManagement.login(dataArr[1], dataArr[2], dataArr[3]));
                break;
            default:
                response = "false";
        }
        try {
            dos.writeUTF(response);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}