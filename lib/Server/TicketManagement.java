import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class TicketManagement {
    DataBaseHandler handler = new DataBaseHandler("db/Tickets.csv");

    String addTicket(
            String ticketCode,
            String transportBy,
            String from,
            String to,
            String outboundDateYear,
            String outboundDateMonth,
            String outboundDateDay,
            String outboundTimeHour,
            String outboundTimeMinute,
            String inboundDateYear,
            String inboundDateMonth,
            String inboundDateDay,
            String inboundTimeHour,
            String inboundTimeMinute,
            String companyName,
            String price,
            String remainingSeats,
            String description,
            String tags1,
            String tags2,
            String tags3,
            String tags4
    ) {
        DataBaseHandler handler = new DataBaseHandler("db/Tickets.csv");
        try {
            File file = new File("db/Tickets.csv");
            FileWriter writer = new FileWriter(file, true);
            String[] allTickets = handler.getAllTickets();
            // check ticket code is unique
            for (String ticket : allTickets) {
                if (ticket.split("-")[0].equals(ticketCode)) {
                    return "code is not unique";
                }
            }
                String info = ticketCode + "-" +
                        transportBy + "-" +
                        from + "-" +
                        to + "-" +
                        outboundDateYear + "-" +
                        outboundDateMonth + "-" +
                        outboundDateDay + "-" +
                        outboundTimeHour + "-" +
                        outboundTimeMinute + "-" +
                        inboundDateYear + "-" +
                        inboundDateMonth + "-" +
                        inboundDateDay + "-" +
                        inboundTimeHour + "-" +
                        inboundTimeMinute + "-" +
                        companyName + "-" +
                        price + "-" +
                        remainingSeats + "-" +
                        description + "-" +
                        tags1 + "-" +
                        tags2 + "-" +
                        tags3 + "-" +
                        tags4 + "\n";
                writer.write(info);
                writer.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return "true";
    }


    String deleteTicket(String ticketCode) {
        DataBaseHandler handler = new DataBaseHandler("db/Tickets.csv");
        String[] allTickets = handler.getAllTickets();
        String out = "";
        for (String ticket : allTickets) {
            if (!ticket.split("-")[0].equals(ticketCode)) {
                out += ticket + "\n";
            }
        }
        try {
            File file = new File("db/Tickets.csv");
            FileWriter writer = new FileWriter(file);
            writer.write(out);
            writer.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return "true";
    }
    String getTickets(String companyName) {
        String[] tickets = handler.getCompanyTickets(companyName);
        String out = "";
        for (String ticket : tickets) {
            out += ticket + "\n";
        }
        return out;
    }

}
