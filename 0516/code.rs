#![allow(non_snake_case)]
use std::io;

fn main() {
    let mut input_year = String::new();
    println!("Input Year:");
    io::stdin()
        .read_line(&mut input_year)
        .expect("failed to read year");
    let year: i32 = input_year.trim().parse().unwrap_or(0);
    let mut input_month = String::new();
    println!("Input Month:");
    io::stdin()
        .read_line(&mut input_month)
        .expect("failed to read month");
    let month: i32 = input_month.trim().parse().unwrap_or(0);
    let mut input_day = String::new();
    println!("Input Day:");
    io::stdin()
        .read_line(&mut input_day)
        .expect("failed to read day");
    let day: i32 = input_day.trim().parse().unwrap_or(0);

    // Zeller’s congruence
    let mut month_modified: i32 = month;
    let mut year_modified: i32 = year;
    if month < 3 {
        month_modified = month + 12;
        year_modified = year - 1;
    }
    let yearLast2Digits = year_modified % 100;
    let yearFirst2Digits = year_modified / 100;
    let f = day
        + (13 * (month_modified + 1)) / 5
        + yearLast2Digits
        + yearLast2Digits / 4
        + yearFirst2Digits / 4
        - 2 * yearFirst2Digits;
    let day_of_week = f.rem_euclid(7);
    let day_names = [
        "Saturday",
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
    ];
    println!(
        "The day of the week is: {}",
        day_names[day_of_week as usize]
    );
}
