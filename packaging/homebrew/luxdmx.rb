class Luxdmx < Formula
  desc "Zero-driver LAN lighting CLI & MCP server for Art-Net 4 and ANSI E1.31 sACN"
  homepage "https://github.com/raydeoliveira/luxdmx"
  url "https://github.com/raydeoliveira/luxdmx/releases/download/v0.1.0/luxdmx-0.1.0-macos-arm64.tar.gz"
  sha256 "54bf040bb0f9f4e14e19784ba3f33546bf1cba8516bfeb59ef43d9d202936bca"
  license :cannot_represent

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    bin.install "luxdmx"
    doc.install "README.md", "LICENSE", "SECURITY.md", "SKILL.md", "server.json"
  end

  test do
    assert_match "luxdmx 0.1.0", shell_output("#{bin}/luxdmx --version")
    describe_json = shell_output("#{bin}/luxdmx --describe")
    assert_match "\"schema_version\":1", describe_json
    solve_json = shell_output("#{bin}/luxdmx solve --gel L201 --dim 80 --fixture aputure-600c-rgbww --json")
    assert_match "\"L201\"", solve_json
  end
end
