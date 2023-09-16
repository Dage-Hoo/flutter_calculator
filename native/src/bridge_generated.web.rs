use super::*;
// Section: wire functions

#[wasm_bindgen]
pub fn wire_store_history(port_: MessagePort, path: String, history: JsValue) {
    wire_store_history_impl(port_, path, history)
}

#[wasm_bindgen]
pub fn wire_get_histroy(port_: MessagePort, path: String) {
    wire_get_histroy_impl(port_, path)
}

#[wasm_bindgen]
pub fn wire_dart_calculate(input: String) -> support::WireSyncReturn {
    wire_dart_calculate_impl(input)
}

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for String {
    fn wire2api(self) -> String {
        self
    }
}
impl Wire2Api<(Expr, String)> for JsValue {
    fn wire2api(self) -> (Expr, String) {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        (self_.get(0).wire2api(), self_.get(1).wire2api())
    }
}
impl Wire2Api<(ExprType, String)> for JsValue {
    fn wire2api(self) -> (ExprType, String) {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        (self_.get(0).wire2api(), self_.get(1).wire2api())
    }
}

impl Wire2Api<DataStruct> for JsValue {
    fn wire2api(self) -> DataStruct {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            2,
            "Expected 2 elements, got {}",
            self_.length()
        );
        DataStruct {
            current_expr: self_.get(0).wire2api(),
            history_expr: self_.get(1).wire2api(),
        }
    }
}
impl Wire2Api<Expr> for JsValue {
    fn wire2api(self) -> Expr {
        let self_ = self.dyn_into::<JsArray>().unwrap();
        assert_eq!(
            self_.length(),
            3,
            "Expected 3 elements, got {}",
            self_.length()
        );
        Expr {
            expr_list: self_.get(0).wire2api(),
            l_bracket_count: self_.get(1).wire2api(),
            r_bracket_count: self_.get(2).wire2api(),
        }
    }
}

impl Wire2Api<Vec<(Expr, String)>> for JsValue {
    fn wire2api(self) -> Vec<(Expr, String)> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}
impl Wire2Api<Vec<(ExprType, String)>> for JsValue {
    fn wire2api(self) -> Vec<(ExprType, String)> {
        self.dyn_into::<JsArray>()
            .unwrap()
            .iter()
            .map(Wire2Api::wire2api)
            .collect()
    }
}

impl Wire2Api<Vec<u8>> for Box<[u8]> {
    fn wire2api(self) -> Vec<u8> {
        self.into_vec()
    }
}
// Section: impl Wire2Api for JsValue

impl Wire2Api<String> for JsValue {
    fn wire2api(self) -> String {
        self.as_string().expect("non-UTF-8 string, or not a string")
    }
}
impl Wire2Api<ExprType> for JsValue {
    fn wire2api(self) -> ExprType {
        (self.unchecked_into_f64() as i32).wire2api()
    }
}
impl Wire2Api<i32> for JsValue {
    fn wire2api(self) -> i32 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<i64> for JsValue {
    fn wire2api(self) -> i64 {
        ::std::convert::TryInto::try_into(self.dyn_into::<js_sys::BigInt>().unwrap()).unwrap()
    }
}
impl Wire2Api<u8> for JsValue {
    fn wire2api(self) -> u8 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<Vec<u8>> for JsValue {
    fn wire2api(self) -> Vec<u8> {
        self.unchecked_into::<js_sys::Uint8Array>().to_vec().into()
    }
}
