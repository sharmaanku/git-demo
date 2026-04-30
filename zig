#!/bin/bash

# Exit immediately if any command fails
set -e

echo "=============================="
echo "Step 1: Update system"
echo "=============================="
sudo apt update -y
sudo apt upgrade -y

echo "=============================="
echo "Step 2: Install dependencies"
echo "=============================="
sudo apt install -y wget tar

echo "=============================="
echo "Step 3: Download Zig"
echo "=============================="
cd /tmp
wget https://ziglang.org/download/0.11.0/zig-linux-x86_64-0.11.0.tar.xz

echo "=============================="
echo "Step 4: Extract Zig"
echo "=============================="
tar -xf zig-linux-x86_64-0.11.0.tar.xz

echo "=============================="
echo "Step 5: Move Zig to /opt"
echo "=============================="
sudo mv zig-linux-x86_64-0.11.0 /opt/zig

echo "=============================="
echo "Step 6: Add Zig to PATH"
echo "=============================="
echo 'export PATH=$PATH:/opt/zig' >> ~/.bashrc
source ~/.bashrc

echo "=============================="
echo "Step 7: Verify Installation"
echo "=============================="
zig version

echo "=============================="
echo "Step 8: Create Hello World Program"
echo "=============================="
cat <<EOF > hello.zig
const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, Zig!\\n", .{});
}
EOF

echo "=============================="
echo "Step 9: Compile Program"
echo "=============================="
zig build-exe hello.zig

echo "=============================="
echo "Step 10: Run Program"
echo "=============================="
./hello

echo "=============================="
echo "Zig setup and execution completed successfully!"
echo "=============================="
