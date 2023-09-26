local gh = require("github-pr.pull_request")

describe("setup", function()
  it("should work with default values", function()
    assert(gh.pull_request(), " successfully")
  end)

  it("should work with custom values", function()
    gh.setup({ opt = "custom" })
    assert(gh.pull_request() == "custom", "does not provide custom value")
  end)
end)
