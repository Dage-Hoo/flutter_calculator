#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
typedef struct _Dart_Handle* Dart_Handle;

typedef struct DartCObject DartCObject;

typedef int64_t DartPort;

typedef bool (*DartPostCObjectFnType)(DartPort port_id, void *message);

typedef struct wire_uint_8_list {
  uint8_t *ptr;
  int32_t len;
} wire_uint_8_list;

typedef struct wire___record__expr_type_String {
  int32_t field0;
  struct wire_uint_8_list *field1;
} wire___record__expr_type_String;

typedef struct wire_list___record__expr_type_String {
  struct wire___record__expr_type_String *ptr;
  int32_t len;
} wire_list___record__expr_type_String;

typedef struct wire_Expr {
  struct wire_list___record__expr_type_String *expr_list;
  int64_t l_bracket_count;
  int64_t r_bracket_count;
} wire_Expr;

typedef struct wire___record__expr_String {
  struct wire_Expr field0;
  struct wire_uint_8_list *field1;
} wire___record__expr_String;

typedef struct wire_list___record__expr_String {
  struct wire___record__expr_String *ptr;
  int32_t len;
} wire_list___record__expr_String;

typedef struct wire_DataStruct {
  struct wire_Expr current_expr;
  struct wire_list___record__expr_String *history_expr;
} wire_DataStruct;

typedef struct DartCObject *WireSyncReturn;

void store_dart_post_cobject(DartPostCObjectFnType ptr);

Dart_Handle get_dart_object(uintptr_t ptr);

void drop_dart_object(uintptr_t ptr);

uintptr_t new_dart_opaque(Dart_Handle handle);

intptr_t init_frb_dart_api_dl(void *obj);

void wire_store_history(int64_t port_,
                        struct wire_uint_8_list *path,
                        struct wire_DataStruct *history);

void wire_get_histroy(int64_t port_, struct wire_uint_8_list *path);

WireSyncReturn wire_dart_calculate(struct wire_uint_8_list *input);

struct wire_DataStruct *new_box_autoadd_data_struct_0(void);

struct wire_list___record__expr_String *new_list___record__expr_String_0(int32_t len);

struct wire_list___record__expr_type_String *new_list___record__expr_type_String_0(int32_t len);

struct wire_uint_8_list *new_uint_8_list_0(int32_t len);

void free_WireSyncReturn(WireSyncReturn ptr);

static int64_t dummy_method_to_enforce_bundling(void) {
    int64_t dummy_var = 0;
    dummy_var ^= ((int64_t) (void*) wire_store_history);
    dummy_var ^= ((int64_t) (void*) wire_get_histroy);
    dummy_var ^= ((int64_t) (void*) wire_dart_calculate);
    dummy_var ^= ((int64_t) (void*) new_box_autoadd_data_struct_0);
    dummy_var ^= ((int64_t) (void*) new_list___record__expr_String_0);
    dummy_var ^= ((int64_t) (void*) new_list___record__expr_type_String_0);
    dummy_var ^= ((int64_t) (void*) new_uint_8_list_0);
    dummy_var ^= ((int64_t) (void*) free_WireSyncReturn);
    dummy_var ^= ((int64_t) (void*) store_dart_post_cobject);
    dummy_var ^= ((int64_t) (void*) get_dart_object);
    dummy_var ^= ((int64_t) (void*) drop_dart_object);
    dummy_var ^= ((int64_t) (void*) new_dart_opaque);
    return dummy_var;
}
