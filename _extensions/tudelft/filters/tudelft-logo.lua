-- tudelft-logo.lua
-- This filter adds the TU Delft logo to the user's metadata

function Meta(meta)
	-- Check if the TU Delft logo should be included (default: true)
	if meta["institute-logo-tudelft"] == nil or meta["institute-logo-tudelft"] then
		-- Get the path to the extension's directory
		local extension_path = "_extensions/tudelft"
		local tudelft_logo_path = extension_path .. "/www/tudelft.png"

		-- If no logos are specified, create a new list with just the TU Delft logo
		if meta["institute-logos"] == nil then
			-- Check if a single logo is specified
			if meta["institute-logo"] ~= nil then
				-- Convert the single logo to the first item in the list
				local user_logo = meta["institute-logo"]
				meta["institute-logos"] = {
					{
						path = tudelft_logo_path,
						spacing = "1.5cm",
					},
					{
						path = user_logo,
					},
				}
				-- Remove the single logo parameter to avoid duplication
				meta["institute-logo"] = nil
			else
				-- Just add the TU Delft logo
				meta["institute-logos"] = {
					{
						path = tudelft_logo_path,
					},
				}
			end
		else
			-- Insert the TU Delft logo at the beginning of the list
			table.insert(meta["institute-logos"], 1, {
				path = tudelft_logo_path,
				spacing = "1.5cm",
			})
		end
	end

	return meta
end
