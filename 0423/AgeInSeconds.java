import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Scanner;

public class AgeInSeconds {
    public static void main(String[] args) {
        System.out.println("--- 生涯秒数カウンター ---");
        try (Scanner sc = new Scanner(System.in)) {
            System.out.print("生まれた西暦を入力: ");
            int year = sc.nextInt();
            System.out.print("生まれた月を入力: ");
            int month = sc.nextInt();
            System.out.print("生まれた日を入力: ");
            int day = sc.nextInt();
            
            LocalDateTime birthDateTime = LocalDateTime.of(year, month, day, 0, 0, 0);
            
            LocalDateTime now = LocalDateTime.now();
            
            long seconds = ChronoUnit.SECONDS.between(birthDateTime, now);
            
            System.out.println("\n-------------------------");
            System.out.printf("あなたは生まれてから約 %,d 秒経過しました！%n", seconds);
            System.out.println("-------------------------");
        } catch (Exception e) {
            System.out.println("エラー: 不正な入力です。");
        }
    }
}