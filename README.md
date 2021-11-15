# 32bitALU_Design
采用 Verilog 语言设计一个 32 位 ALU,所有模块均采用门级设计
## 功能描述
**具有以下功能:**
- 32 位无符号数加法
- 32 位无符号数移位
- 32 位无符号数截断
- 32 位数逻辑与、32 位数逻辑或、32 位数逻辑非 、32 位数逻辑异或
## 目录说明
- **sim_1** 放置Testbench文件
- **constrs_1** 放置FPGA管脚约束文件
- **sources_1** 放置模块文件
    - **ALU_32bit_Display.v** 上FPGA调试模块
    - **ALUModule.v** 顶层模块
    - **DecoderModule.v**译码器模块
    - **AdderModule.v** 加法器模块
    - **ShiftModule.v** 移位器模块
    - **TruncateModule.v** 截断器模块
    - **AndModule.v** 逻辑与模块
    - **OrModule.v** 逻辑或模块
    - **NotModule.v** 逻辑非模块
    - **XorModule.v** 逻辑异或模块
    - **lcd_module.dcp** FPGA上LCD触摸屏模块
## 仿真环境
- Vivado
- FPGA
## 使用
  1. 在Vivado中创建新的项目，在项目目录下找到 **项目名.src** 的文件夹,将仓库中 **sim_1、constrs_1、sources_1** 复制到该文件夹中
  2. 上板调试，将 **ALU_32bit_Display.v** 在Vivado中设为顶部模块(Set as Top),之后运行生成bit文件，写入到FPGA中(具体操作见Xilinx教程)
