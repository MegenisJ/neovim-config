local function Get_Namespace()
    -- Get the path to the current file
    local filepath = vim.fn.expand('%:p')

    -- Get the project root directory
    local project_root = vim.fn.finddir('*.csproj', vim.fn.expand('%:p:h') .. ';')

    -- Calculate the namespace based on the folder structure
    local relative_path = string.gsub(filepath, project_root, '')
    local namespace = string.gsub(relative_path, '/', '.')
    namespace = string.gsub(namespace, '\\.', '')

    -- Remove leading dot and trailing slash
    namespace = string.gsub(namespace, '^%.+', '')
    namespace = string.gsub(namespace, '%.$', '')

    return namespace
end

-- Template for the C# class file
local class_template = [[
namespace %s
{
    public class ClassName
    {
        public ClassName()
        {
            // Constructor logic here
        }

        // Other members here
    }
}
]]

-- Function to insert the template with the calculated namespace
function Insert_Class_Template()
    local namespace = Get_Namespace()
    local template = string.format(class_template, namespace)

    -- Insert the template into the buffer
    vim.api.nvim_put({template}, '', true, true)
end

-- Automatically insert the template when creating a new .cs file
vim.cmd([[
    autocmd BufNewFile *.cs lua require('vim.lsp.buf').clear_references()<cr>
    autocmd BufNewFile *.cs lua insert_class_template()
]])
