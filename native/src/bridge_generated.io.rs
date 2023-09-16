use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_store_history(
    port_: i64,
    path: *mut wire_uint_8_list,
    history: *mut wire_DataStruct,
) {
    wire_store_history_impl(port_, path, history)
}

#[no_mangle]
pub extern "C" fn wire_get_histroy(port_: i64, path: *mut wire_uint_8_list) {
    wire_get_histroy_impl(port_, path)
}

#[no_mangle]
pub extern "C" fn wire_dart_calculate(input: *mut wire_uint_8_list) -> support::WireSyncReturn {
    wire_dart_calculate_impl(input)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_data_struct_0() -> *mut wire_DataStruct {
    support::new_leak_box_ptr(wire_DataStruct::new_with_null_ptr())
}

#[no_mangle]
pub extern "C" fn new_list___record__expr_String_0(
    len: i32,
) -> *mut wire_list___record__expr_String {
    let wrap = wire_list___record__expr_String {
        ptr: support::new_leak_vec_ptr(<wire___record__expr_String>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_list___record__expr_type_String_0(
    len: i32,
) -> *mut wire_list___record__expr_type_String {
    let wrap = wire_list___record__expr_type_String {
        ptr: support::new_leak_vec_ptr(<wire___record__expr_type_String>::new_with_null_ptr(), len),
        len,
    };
    support::new_leak_box_ptr(wrap)
}

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}
impl Wire2Api<(Expr, String)> for wire___record__expr_String {
    fn wire2api(self) -> (Expr, String) {
        (self.field0.wire2api(), self.field1.wire2api())
    }
}
impl Wire2Api<(ExprType, String)> for wire___record__expr_type_String {
    fn wire2api(self) -> (ExprType, String) {
        (self.field0.wire2api(), self.field1.wire2api())
    }
}
impl Wire2Api<DataStruct> for *mut wire_DataStruct {
    fn wire2api(self) -> DataStruct {
        let wrap = unsafe { support::box_from_leak_ptr(self) };
        Wire2Api::<DataStruct>::wire2api(*wrap).into()
    }
}
impl Wire2Api<DataStruct> for wire_DataStruct {
    fn wire2api(self) -> DataStruct {
        DataStruct {
            current_expr: self.current_expr.wire2api(),
            history_expr: self.history_expr.wire2api(),
        }
    }
}
impl Wire2Api<Expr> for wire_Expr {
    fn wire2api(self) -> Expr {
        Expr {
            expr_list: self.expr_list.wire2api(),
            l_bracket_count: self.l_bracket_count.wire2api(),
            r_bracket_count: self.r_bracket_count.wire2api(),
        }
    }
}

impl Wire2Api<Vec<(Expr, String)>> for *mut wire_list___record__expr_String {
    fn wire2api(self) -> Vec<(Expr, String)> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}
impl Wire2Api<Vec<(ExprType, String)>> for *mut wire_list___record__expr_type_String {
    fn wire2api(self) -> Vec<(ExprType, String)> {
        let vec = unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        };
        vec.into_iter().map(Wire2Api::wire2api).collect()
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire___record__expr_String {
    field0: wire_Expr,
    field1: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire___record__expr_type_String {
    field0: i32,
    field1: *mut wire_uint_8_list,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_DataStruct {
    current_expr: wire_Expr,
    history_expr: *mut wire_list___record__expr_String,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_Expr {
    expr_list: *mut wire_list___record__expr_type_String,
    l_bracket_count: i64,
    r_bracket_count: i64,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list___record__expr_String {
    ptr: *mut wire___record__expr_String,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_list___record__expr_type_String {
    ptr: *mut wire___record__expr_type_String,
    len: i32,
}

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

impl NewWithNullPtr for wire___record__expr_String {
    fn new_with_null_ptr() -> Self {
        Self {
            field0: Default::default(),
            field1: core::ptr::null_mut(),
        }
    }
}

impl Default for wire___record__expr_String {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire___record__expr_type_String {
    fn new_with_null_ptr() -> Self {
        Self {
            field0: Default::default(),
            field1: core::ptr::null_mut(),
        }
    }
}

impl Default for wire___record__expr_type_String {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_DataStruct {
    fn new_with_null_ptr() -> Self {
        Self {
            current_expr: Default::default(),
            history_expr: core::ptr::null_mut(),
        }
    }
}

impl Default for wire_DataStruct {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

impl NewWithNullPtr for wire_Expr {
    fn new_with_null_ptr() -> Self {
        Self {
            expr_list: core::ptr::null_mut(),
            l_bracket_count: Default::default(),
            r_bracket_count: Default::default(),
        }
    }
}

impl Default for wire_Expr {
    fn default() -> Self {
        Self::new_with_null_ptr()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
