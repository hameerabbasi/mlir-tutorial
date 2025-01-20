import os
from pathlib import Path
from lit.formats import ShTest

config.name = "mlir_tutorial"
config.test_format = ShTest()
config.suffixes = [".mlir"]

runfiles_dir = Path(".").absolute()
tool_relpaths = [
    "externals/llvm-project/mlir",
    "externals/llvm-project/llvm",
    "build-ninja/tools",
]

config.environment["PATH"] = (
    ":".join(str(runfiles_dir.joinpath(Path(path))) for path in tool_relpaths)
    + ":"
    + os.environ["PATH"]
)
