import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    static boolean isServerUp = true;
    static int port = 444;

    public static void main(String[] args) {
        try {
            ServerSocket serverSocket = new ServerSocket(port);

//            Connect to database

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

//    String listener() {
//        StringBuilder num = new StringBuilder();
//        StringBuilder listen = new StringBuilder();
//        char i;
//        try {
//            while ((i = (char) dis.read()) != ',') {
//                num.append(i);
//            }
//            int counter = Integer.parseInt(num.toString());
//            for (int j = 0; j < counter; j++) {
//                listen.append((char) dis.read());
//            }
//        } catch (IOException e) {
//            try {
//                dis.close();
//                dos.close();
//                socket.close();
//            } catch (IOException ioException) {
//                ioException.printStackTrace();
//            }
//            e.printStackTrace();
//        }
//        return listen.toString();
//    }
//
//    void writer(String write) {
//        if (write != null && !write.isEmpty()) {
//            try {
//                dos.writeUTF(write);
//                System.out.println("write: " + write);
//            } catch (IOException e) {
//                try {
//                    dis.close();
//                    dos.close();
//                    socket.close();
//                } catch (IOException ioException) {
//                    ioException.printStackTrace();
//                }
//                e.printStackTrace();
//            }
//            return;
//        }
//        System.out.println("Invalid write");
//    }

    @Override
    public void run() {
////        listen request
//        System.out.println("ready");
//        String command = listener();
//        System.out.println("command is: " + command);
//        String[] split = command.split("-");
//
////        implementation...
//        String ans = "done";
//        if (split[1].equals("+")) {
//            ans = Integer.parseInt(split[0]) + Integer.parseInt(split[2]) + "";
//        } else if (split[1].equals("-")) {
//            ans = Integer.parseInt(split[0]) - Integer.parseInt(split[2]) + "";
//        } else if (split[1].equals("*")) {
//            ans = Integer.parseInt(split[0]) * Integer.parseInt(split[2]) + "";
//        } else if (split[1].equals("/")) {
//            ans = Integer.parseInt(split[0]) / Integer.parseInt(split[2]) + "";
//        }
//
////        Send answer
//        writer(ans);
//    }
}