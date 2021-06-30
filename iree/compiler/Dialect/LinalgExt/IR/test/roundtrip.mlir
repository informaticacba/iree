// RUN: iree-opt -split-input-file %s | IreeFileCheck %s

// CHECK-LABEL: func @sort_tensor
// CHECK:         linalg_ext.sort
// CHECK-SAME:      ins({{.*}})
// CHECK:           linalg_ext.yield
func @sort_tensor(%arg0: tensor<128xi32>) -> tensor<128xi32> {
  %0 = linalg_ext.sort
    ins(%arg0 : tensor<128xi32>) {
  ^bb0(%arg1: i32, %arg2: i32):  // no predecessors
    %1 = cmpi sgt, %arg1, %arg2 : i32
    linalg_ext.yield %1 : i1
  } -> tensor<128xi32>
  return %0 : tensor<128xi32>
}

// CHECK-LABEL: func @sort_memref
// CHECK:         linalg_ext.sort
// CHECK-SAME:      ins({{.*}}) outs({{.*}})
// CHECK:           linalg_ext.yield
func @sort_memref(%arg0: memref<128xi32>, %arg1: memref<128xi32>) {
  linalg_ext.sort {dimension = 0 : i64}
    ins(%arg0 : memref<128xi32>)
    outs(%arg1 : memref<128xi32>) {
  ^bb0(%arg2: i32, %arg3: i32):  // no predecessors
    %0 = cmpi sgt, %arg2, %arg3 : i32
    linalg_ext.yield %0 : i1
  }
  return
}