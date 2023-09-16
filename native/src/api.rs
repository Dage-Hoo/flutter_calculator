// This is the entry point of your Rust library.
// When adding new code to your project, note that only items used
// here will be transformed to their Dart equivalents.

// A plain enum without any fields. This is similar to Dart- or C-style enums.
// flutter_rust_bridge is capable of generating code for enums with fields
// (@freezed classes in Dart and tagged unions in C).

use flutter_rust_bridge::SyncReturn;
use rcalc::calculate;
pub use rcalc::CalculatorError;
use serde::{Deserialize, Serialize};
use std::fs::OpenOptions;
use std::io::prelude::*;
use std::path::Path;

#[derive(serde::Serialize, Deserialize, PartialEq, Eq)]
pub enum ExprType {
    Functon,
    LeftBracket,
    RightBracket,
    AddSub,
    MulDiv,
    RegularSymbol,
    Number,
}

#[derive(Serialize, Deserialize)]
pub struct Expr {
    pub expr_list: Vec<(ExprType, String)>,
    pub l_bracket_count: i64,
    pub r_bracket_count: i64,
}

#[derive(Serialize, Deserialize)]
pub struct DataStruct {
    pub current_expr: Expr,
    pub history_expr: Vec<(Expr, String)>,
}

pub fn store_history(path: String, history: DataStruct) -> anyhow::Result<()> {
    let p = Path::new(&path).join("history.json");
    let mut file = OpenOptions::new().create(true).write(true).truncate(true).open(p)?;
    
    file.write(&serde_json::to_string(&history)?.as_bytes())?;
    file.flush()?;
    Ok(())
}

pub fn get_histroy(path: String) -> anyhow::Result<DataStruct> {
    let p = Path::new(&path).join("history.json");
    let mut file = OpenOptions::new().read(true).open(p)?;
    let mut history = String::new();
    file.read_to_string(&mut history)?;
    let expr: DataStruct = serde_json::from_str(&history)?;
    Ok(expr)
}

pub fn dart_calculate(input: String) -> SyncReturn<String> {
    let result = calculate(&input);
    flutter_rust_bridge::SyncReturn(
        result
            .map(|res| {
                res.with_scale_round(10, rcalc::RoundingMode::HalfUp)
                    .normalized()
                    .to_string()
            })
            .expect("Failed to calculate"),
    )
}
