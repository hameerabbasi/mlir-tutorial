// RUN: mlir-opt %s --convert-math-to-funcs=convert-ctlz | FileCheck %s
// RUN: mlir-opt %s \
// RUN:   --pass-pipeline="builtin.module( \
// RUN:      convert-math-to-funcs{convert-ctlz}, \
// RUN:      func.func(convert-scf-to-cf,convert-arith-to-llvm), \
// RUN:      convert-func-to-llvm, \
// RUN:      convert-cf-to-llvm, \
// RUN:      reconcile-unrealized-casts)" \
// RUN: | mlir-cpu-runner -e test_7i32_to_29 -entry-point-result=i32 > %t
// RUN: FileCheck %s --check-prefix=CHECK_TEST_7i32_TO_29 < %t

func.func @main(%arg0: i32) -> i32 {
  // CHECK-NOT: math.ctlz
  // CHECK: call
  // CHECK: return
  %0 = math.ctlz %arg0 : i32
  func.return %0 : i32
}

func.func @test_7i32_to_29() -> i32 {
  %arg = arith.constant 7 : i32
  %0 = math.ctlz %arg : i32
  func.return %0 : i32
}
// CHECK_TEST_7i32_TO_29: 29