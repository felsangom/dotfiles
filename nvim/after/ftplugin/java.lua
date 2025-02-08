vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', '/home/felipe/Projetos/Java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar',
    '-configuration', '/home/felipe/Projetos/Java/jdtls/config_linux',
    '-data', '/home/felipe/Projetos/Java/jdtls_data/' .. project_name
  },

  root_dir = vim.fs.dirname(vim.fs.find({'pom.xml', 'gradlew', '.git', 'mvnw'}, { upward = true })[1]),

  settings = {
    java = {
      autobuild = { enabled = false },
    }
  },

  init_options = {
    bundles = {}
  },
}

require('jdtls').start_or_attach(config)
