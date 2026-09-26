-- menu.lua
-- A Roblox UI shell: a small menu with an Open button and a Minimize button.
-- Runs on the client (your PC) via an executor, or inside Roblox Studio for testing.

-- ─────────────────────────────────────────────
-- 1. Grab the services we need
-- ─────────────────────────────────────────────
-- "Players" is the service that knows about your character.
-- "LocalPlayer" is YOU, the person running this script.
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- "CoreGui" is the top-level container Roblox uses to hold GUIs.
-- We'll parent our GUI to PlayerGui, which is the per-player GUI container.
-- Wait until LocalPlayer.PlayerGui exists (it always does, but be safe).
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ─────────────────────────────────────────────
-- 2. Build the ScreenGui (the invisible canvas everything sits on)
-- ─────────────────────────────────────────────
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PotatoMenuGui"
-- IgnoreGuiInset = true makes coordinates start at the very top-left of
-- the window, not below Roblox's top bar. Cleaner for our purposes.
ScreenGui.IgnoreGuiInset = true
-- ResetOnSpawn = false keeps the GUI alive when your character respawns.
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- ─────────────────────────────────────────────
-- 3. The "Open" button (visible when menu is hidden)
-- ─────────────────────────────────────────────
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Text = "☰ Menu"
OpenButton.Size = UDim2.new(0, 90, 0, 34)       -- 90px wide, 34px tall
OpenButton.Position = UDim2.new(0, 20, 0, 20)   -- 20px from left, 20px from top
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.TextColor3 = Color3.fromRGB(240, 240, 240)
OpenButton.BorderSizePixel = 0
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 14
OpenButton.AutoButtonColor = true
-- Add rounded corners via a UICorner child instance.
local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 8)
OpenCorner.Parent = OpenButton
OpenButton.Parent = ScreenGui

-- ─────────────────────────────────────────────
-- 4. The main menu Frame (hidden initially)
-- ─────────────────────────────────────────────
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Position = UDim2.new(0, 20, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false  -- start hidden; Open button will reveal it
MainFrame.Active = true    -- allows dragging
MainFrame.Draggable = true -- Roblox has built-in drag for Frames — handy
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame
MainFrame.Parent = ScreenGui

-- ─────────────────────────────────────────────
-- 5. Title bar (top strip of the frame)
-- ─────────────────────────────────────────────
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)       -- full width, 30px tall
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar
TitleBar.Parent = MainFrame

-- Title text label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Text = "My Menu"
TitleLabel.Size = UDim2.new(1, -60, 1, 0)   -- leave room for the minimize button
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1       -- fully see-through
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- ─────────────────────────────────────────────
-- 6. Minimize button (top-right of the title bar)
-- ─────────────────────────────────────────────
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Text = "—"                    -- em dash, looks like a minimize icon
MinimizeButton.Size = UDim2.new(0, 26, 0, 22)
MinimizeButton.Position = UDim2.new(1, -32, 0, 4)  -- anchor right, offset inward
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeButton.TextColor3 = Color3.fromRGB(240, 240, 240)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = TitleBar

-- ─────────────────────────────────────────────
-- 7. Wire the buttons
-- ─────────────────────────────────────────────
-- .MouseButton1Click fires when the LEFT mouse button is released on the button.

OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)

-- ─────────────────────────────────────────────
-- 8. Start state
-- ─────────────────────────────────────────────
-- Menu hidden, Open button visible. Already set above, but explicit is nice.
MainFrame.Visible = false
OpenButton.Visible = true

-- Print a message to the executor console so you know it loaded.
print("[Potato Menu] loaded — click '☰ Menu' to open.")
