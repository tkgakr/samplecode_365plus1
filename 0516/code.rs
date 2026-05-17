#![allow(non_snake_case)]
use std::io;

/// Zeller の合同式で `year/month/day` の曜日名を返す。
fn day_of_week(year: i32, month: i32, day: i32) -> &'static str {
    // Zeller’s congruence
    // この合同式では1月は前年13月、2月は前年14月として扱う
    let (month_modified, year_modified) = if month < 3 {
        (month + 12, year - 1)
    } else {
        (month, year)
    };
    let yearLast2Digits = year_modified.rem_euclid(100);
    let yearFirst2Digits = year_modified.div_euclid(100);
    let f = day
        + (13 * (month_modified + 1)) / 5
        + yearLast2Digits
        + yearLast2Digits / 4
        + yearFirst2Digits / 4
        - 2 * yearFirst2Digits;
    let day_names = [
        "Saturday",
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
    ];
    day_names[f.rem_euclid(7) as usize]
}

fn read_i32(prompt: &str) -> i32 {
    let mut buf = String::new();
    println!("{}", prompt);
    io::stdin()
        .read_line(&mut buf)
        .expect("failed to read line");
    buf.trim().parse().unwrap_or(0)
}

fn main() {
    let year = read_i32("Input Year:");
    let month = read_i32("Input Month:");
    let day = read_i32("Input Day:");
    println!("The day of the week is: {}", day_of_week(year, month, day));
}

#[cfg(test)]
mod tests {
    use super::day_of_week;

    /// 実在の著名な日付で結果が一致するかを広く確認する回帰テスト。
    /// 世紀をまたぐ年（1900/2000）や歴史的イベント日を選び、
    /// 計算式全体が壊れていないことを検知する網羅型のスモークテスト。
    #[test]
    fn known_dates() {
        assert_eq!(day_of_week(2026, 5, 17), "Sunday");
        assert_eq!(day_of_week(1900, 1, 1), "Monday"); // 20世紀最初の日
        assert_eq!(day_of_week(2000, 1, 1), "Saturday"); // 21世紀最初の日
        assert_eq!(day_of_week(2024, 2, 29), "Thursday"); // うるう年の2/29
        assert_eq!(day_of_week(1969, 7, 20), "Sunday"); // アポロ11号月面着陸
        assert_eq!(day_of_week(2001, 9, 11), "Tuesday");
        assert_eq!(day_of_week(1989, 1, 8), "Sunday"); // 平成改元
    }

    /// `month < 3` で年をデクリメントする分岐（1月=前年13月, 2月=前年14月）の境界テスト。
    /// 異なるコードパスを通る隣接日（2/29 と 3/1）が
    /// カレンダー上連続した曜日（Sat→Sun）になることを確認し、
    /// `year - 1` のシフト忘れや符号ミスを回帰検知する。
    #[test]
    fn january_february_shifts_to_previous_year() {
        assert_eq!(day_of_week(2020, 2, 29), "Saturday"); // if 分岐に入る側
        assert_eq!(day_of_week(2020, 3, 1), "Sunday"); // if 分岐に入らない側
    }
}
