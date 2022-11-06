-- stolen from here: https://github.com/mfussenegger/dotfiles/blob/833d634251ebf3bf7e9899ed06ac710735d392da/vim/.config/nvim/lua/me/lsp/conf.lua

local jdtls = require('jdtls')
local root_markers = { 'pom.xml', 'mvnw', 'gradlew', '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local home = os.getenv('HOME')
local workspace_folder = home .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')
local jdtls_home = home .. '/.local/share/nvim/mason/packages/jdtls'
local jdtls_jar = vim.fn.glob(jdtls_home .. '/plugins/org.eclipse.equinox.launcher_*.jar')

local config = {}
config.settings = {
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = 'fernflower' },
    completion = {
      favoriteStaticMembers = {
        -- TODO: add assertj
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*'
      },
      filteredTypes = {
        'com.sun.*',
        'io.micrometer.shaded.*',
        'java.awt.*',
        'jdk.*',
        'sun.*',
      }
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      };
    };
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}'
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    };
    configuration = {
      runtimes = {
        {
          name = 'Current',
          path = home .. '/.sdkman/candidates/java/current'
        },
        {
          name = 'JavaSE-11',
          path = home .. '/.sdkman/candidates/java/11.0.16-tem/',
        },
        {
          name = 'JavaSE-17',
          path = home .. '/.sdkman/candidates/java/17.0.4.1-tem/',
        },
      }
    };
  };
}
config.cmd = {
  'java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xmx4g',
  -- '-javaagent:$XDG_CONFIG_HOME/nvim/dependencies/lombok.jar',
  -- '-Xbootclasspath/a:$XDG_CONFIG_HOME/nvim/dependencies/lombok.jar',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-jar', jdtls_jar,
  '-configuration', jdtls_home .. '/config_linux',
  '-data', workspace_folder,
}
config.on_attach = function(client, bufnr)
  -- TODO: why is this not called??
  require('jdsee.lsp.config').on_attach(client, bufnr)

  jdtls.setup_dap { hotcodereplace = 'auto' }
  jdtls.setup.add_commands()
  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<leader>ro', jdtls.organize_imports, opts)
  vim.keymap.set('n', '<leader>ta', jdtls.test_class, opts)
  vim.keymap.set('n', '<leader>tj', jdtls.test_nearest_method, opts)
  vim.keymap.set('n', '<leader>iv', jdtls.extract_variable, opts)
  vim.keymap.set('v', '<leader>im', jdtls.extract_method(true), opts)
  vim.keymap.set('n', '<leader>ic', jdtls.extract_constant, opts)
end

local jar_patterns = {
  '/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
  '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
  '/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin/target/*.jar',
  '/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/target/*.jar',
  '/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.runner/lib/*.jar',
  '/dev/testforstephen/vscode-pde/server/*.jar'
}
-- npm install broke for me: https://github.com/npm/cli/issues/2508
-- So gather the required jars manually; this is based on the gulpfile.js in the vscode-java-test repo
local plugin_path = '/dev/microsoft/vscode-java-test/java-extension/com.microsoft.java.test.plugin.site/target/repository/plugins/'
local bundle_list = vim.tbl_map(
  function(x) return require('jdtls.path').join(plugin_path, x) end,
  {
    'org.eclipse.jdt.junit4.runtime_*.jar',
    'org.eclipse.jdt.junit5.runtime_*.jar',
    'org.junit.jupiter.api*.jar',
    'org.junit.jupiter.engine*.jar',
    'org.junit.jupiter.migrationsupport*.jar',
    'org.junit.jupiter.params*.jar',
    'org.junit.vintage.engine*.jar',
    'org.opentest4j*.jar',
    'org.junit.platform.commons*.jar',
    'org.junit.platform.engine*.jar',
    'org.junit.platform.launcher*.jar',
    'org.junit.platform.runner*.jar',
    'org.junit.platform.suite.api*.jar',
    'org.apiguardian*.jar'
  }
)
vim.list_extend(jar_patterns, bundle_list)
local bundles = {}
for _, jar_pattern in ipairs(jar_patterns) do
  for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
    if not vim.endswith(bundle, 'com.microsoft.java.test.runner-jar-with-dependencies.jar')
        and not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
      table.insert(bundles, bundle)
    end
  end
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
config.init_options = {
  bundles = bundles;
  extendedClientCapabilities = extendedClientCapabilities;
}
-- mute; having progress reports is enough
-- config.handlers['language/status'] = function() end

jdtls.start_or_attach(config)
