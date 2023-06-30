import java.util.List;

public class RandomTicketGenerator {
    //21-پرواز خارجی-استانبول-تهران-1402-4-9-8-0-1402-5-4-5-53-وارش-1200000-115--بیزنس-با شام-چیکن رایس-
    //22-پرواز خارجی-تهران-دبی-1402-4-9-8-0-1402-5-4-5-53-وارش-1200000-115--بیزنس-با شام-چیکن رایس-
    //23-پرواز خارجی-دبی-تهران-1402-4-9-8-0-1402-5-4-5-53-وارش-1200000-115--بیزنس-با شام-چیکن رایس-
    //11-قطار-تهران-مشهد-1402-4-9-8-0-1402-4-10-3-0-وارش-1200000-50--بیزنس-با شام-چیکن رایس-
//    static List<String> internationalCities = List.of("نیویورک", "لندن", "پاریس", "مادرید", "میلان", "برلین", "تهران", "مونیخ", "بروکسل", "روم", "فرانکفورت", "مسکو", "وارشو", "برن", "پراگ", "بوداپست", "استانبول", "دوحه", "دبی", "بنگلور", "بانکوک", "سنگاپور", "هانوی", "هنگ‌کنگ", "شانگهای", "سئول", "طوکیو", "سیدنی", "ملبورن", "ونکوور", "تورنتو", "مونترال", "کالگری", "اوتاوا", "ونیز", "میونیخ", "ونکوور", "تورنتو", "مونترال", "کالگری", "اوتاوا", "ونیز");
    static List<String> internationalCities = List.of("نیویورک", "لندن", "پاریس", "مادرید", "میلان", "برلین", "تهران", "مونیخ");
//    static List<String> cities = List.of("تهران", "مشهد", "اصفهان", "شیراز", "تبریز", "کرج", "اهواز", "قم", "کرمانشاه", "ارومیه", "رشت", "زاهدان", "کرمان", "اراک", "همدان", "یزد", "اردبیل", "بندرعباس", "سنندج", "بجنورد", "ساری", "خرم‌آباد", "بوشهر", "سمنان", "بیرجند", "قزوین", "گرگان", "ملایر", "نیشابور", "بندرانزلی", "بجنورد", "ساری", "خرم‌آباد", "بوشهر", "سمنان", "بیرجند", "قزوین", "گرگان", "ملایر", "نیشابور", "بندرانزلی");
    static List<String> cities = List.of("تهران", "مشهد", "اصفهان", "شیراز", "تبریز", "کرج", "اهواز", "کرمانشاه");
    static List<String> companies = List.of("وارش", "ایران ایر", "ماهان");
    static List<String> types = List.of("قطار", "اتوبوس", "پرواز داخلی", "پرواز خارجی");
    static List<String> descriptions = List.of("توضیحات رندم تستی", "", "");
    int year = 1402;
    int month = 4;
    int day = 9;
    static List<String> tags = List.of("CF0", "اکونومی", "سیستمی", "بیزنس");

    public static void main(String[] args) {
        for (int i = 1; i <= 10000; i++) {
            String type = types.get((int) (Math.random() * types.size()));
            String from = cities.get((int) (Math.random() * cities.size()));
            String to = cities.get((int) (Math.random() * cities.size()));
            while (from.equals(to)) {
                to = cities.get((int) (Math.random() * cities.size()));
            }
            String company = companies.get((int) (Math.random() * companies.size()));
            String tag1 = tags.get((int) (Math.random() * tags.size()));
            String tag2 = tags.get((int) (Math.random() * tags.size()));
            String tag3 = tags.get((int) (Math.random() * tags.size()));
            String desc = descriptions.get((int) (Math.random() * descriptions.size()));
            int price = (int) (Math.random() * 1000000) + 800000;
            price = price - (price % 1000);
            int capacity = (int) (Math.random() * 100) + 50;
            int hour = (int) (Math.random() * 20);
            int minute = (int) (Math.random() * 60);
            int duration = (int) (Math.random() * 2) + 1;
            int year = 1402;
            int month = 4;
            int day = (Math.random() < 0.5 ? 10 : 11);
            int year2 = 1402;
            int month2 = 4;
            int day2 = day + 1;
            if (type.equals("پرواز خارجی")) {
                from = internationalCities.get((int) (Math.random() * internationalCities.size()));
                to = internationalCities.get((int) (Math.random() * internationalCities.size()));
                day2 = day + 1;
            }
            if (type.equals("قطار")) {
                day2 = day + 1;
            }
            if (type.equals("اتوبوس")) {
                day2 = day + 1;
            }
            //
//            String ticketCode,
//            String transportBy,
//            String from,
//            String to,
//            String outboundDateYear,
//            String outboundDateMonth,
//            String outboundDateDay,
//            String outboundTimeHour,
//            String outboundTimeMinute,
//            String inboundDateYear,
//            String inboundDateMonth,
//            String inboundDateDay,
//            String inboundTimeHour,
//            String inboundTimeMinute,
//            String companyName,
//            String price,
//            String remainingSeats,
//            String description,
//            String tags1,
//            String tags2,
//            String tags3,
//            String tags4
            System.out.println(
                    i + "-" +
                    type + "-" +
                    from + "-" +
                    to + "-" +
                    year + "-" +
                    month + "-" +
                    day + "-" +
                    hour + "-" +
                    minute + "-" +
                    year2 + "-" +
                    month2 + "-" +
                    day2 + "-" +
                    (hour + duration) + "-" +
                    minute + "-" +
                    company + "-" +
                    price + "-" +
                    capacity + "-" +
                    desc + "-" +
                    tag1 + "-" +
                    tag2 + "-" +
                    tag3 + "-" + "-"
            );
        }
    }
}
